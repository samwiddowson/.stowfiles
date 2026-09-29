local M = {}

local OTEL_ENV = {
    OTEL_METRICS_EXPORTER = "none",
    OTEL_TRACES_EXPORTER = "none",
    OTEL_LOGS_EXPORTER = "none",
}

---Kotlin backtick identifiers arrive from treesitter with the quotes included.
function M.bare_method_name(name)
    return (name:gsub("^`(.*)`$", "%1"))
end

---Gradle project path for a module directory.
---dashboards-and-visualisations includes projects by their path under workspaces/ or packages/.
function M.project_task(gradle_root, module_dir)
    gradle_root = gradle_root:gsub("/$", "")
    module_dir = module_dir:gsub("/$", "")
    if module_dir == gradle_root then
        return "test"
    end

    for _, base in ipairs({ "workspaces", "packages" }) do
        local prefix = gradle_root .. "/" .. base .. "/"
        if module_dir:sub(1, #prefix) == prefix then
            return ":" .. module_dir:sub(#prefix + 1):gsub("/", ":") .. ":test"
        end
    end

    local prefix = gradle_root .. "/"
    if module_dir:sub(1, #prefix) ~= prefix then
        error("module directory is outside the Gradle root: " .. module_dir)
    end
    return ":" .. module_dir:sub(#prefix + 1):gsub("/", ":") .. ":test"
end

function M.package_from_path(file_path, is_directory)
    for _, marker in ipairs({ "/src/test/kotlin/", "/src/test/java/" }) do
        local _, finish = file_path:find(marker, 1, true)
        if finish then
            local relative = file_path:sub(finish + 1):gsub("/$", "")
            if not is_directory then
                relative = vim.fs.dirname(relative)
            end
            if relative == "." or relative == "" then
                return ""
            end
            return (relative:gsub("/", "."))
        end
    end
end

function M.qualified_classes(package_name, class_names)
    local qualified = {}
    for _, class_name in ipairs(class_names) do
        if package_name and package_name ~= "" then
            table.insert(qualified, package_name .. "." .. class_name)
        else
            table.insert(qualified, class_name)
        end
    end
    return qualified
end

function M.test_patterns(qualified_classes, method_name)
    local patterns = {}
    for _, class_name in ipairs(qualified_classes) do
        if method_name then
            table.insert(patterns, class_name .. "." .. method_name)
        else
            table.insert(patterns, class_name)
        end
    end
    return patterns
end

function M.gradle_command(opts)
    local command = { opts.gradle_root .. "/gradlew" }
    if opts.init_script then
        table.insert(command, "-I")
        table.insert(command, opts.init_script)
    end
    table.insert(command, opts.task)
    for _, pattern in ipairs(opts.patterns) do
        table.insert(command, "--tests")
        table.insert(command, pattern)
    end
    table.insert(command, "--console=plain")
    return command
end

function M.class_matches(reported, qualified_classes)
    if not qualified_classes or #qualified_classes == 0 then
        return true
    end
    for _, class_name in ipairs(qualified_classes) do
        local simple = class_name:match("([^%.]+)$")
        if reported == class_name or reported == simple then
            return true
        end
    end
    return false
end

local function segment_matches(segment, bare)
    segment = vim.trim(segment)
    if segment == bare then
        return true
    end
    return segment:sub(1, #bare) == bare and segment:sub(#bare + 1, #bare + 1) == "("
end

---Gradle prints the method display name, which drops backticks and may append parameter types.
function M.method_matches(reported, position_name)
    local bare = M.bare_method_name(position_name)
    if segment_matches(reported, bare) then
        return true
    end
    local last = reported:match("([^>]+)$")
    return last ~= nil and segment_matches(last, bare)
end

local function split_result_line(raw)
    local trimmed = vim.trim(raw:gsub("\27%[[0-9;]*m", ""):gsub("\r", ""))
    local body, status = trimmed:match("^(.-)%s+(PASSED)$")
    if not body then
        body, status = trimmed:match("^(.-)%s+(FAILED)$")
    end
    if not body then
        body, status = trimmed:match("^(.-)%s+(SKIPPED)$")
    end
    if not body then
        return nil
    end
    local class_name, method = body:match("^(%S+) > (.-)$")
    if not class_name or method == "" then
        return nil
    end
    return class_name, vim.trim(method), status:lower()
end

function M.parse_gradle_results(lines)
    local groups = {}
    local current
    for _, raw in ipairs(lines) do
        local class_name, method, status = split_result_line(raw)
        if class_name then
            current = {
                class_name = class_name,
                method = method,
                status = status,
                lines = { vim.trim(raw:gsub("\r", "")) },
            }
            table.insert(groups, current)
        elseif current then
            table.insert(current.lines, (raw:gsub("\r", "")))
        end
    end
    return groups
end

function M.failure_details(lines, file_path)
    local base = file_path and vim.fs.basename(file_path) or nil
    local message, line_number
    for index = 2, #lines do
        local line = lines[index]
        if base and not line_number then
            local found = line:match(vim.pesc(base) .. ":(%d+)")
            if found then
                line_number = tonumber(found) - 1
            end
        end
        if not message and not line:match("^%s*at ") and not line:match("^%s*Caused by:") then
            local found = line:match(": (.+)$")
            if found then
                message = vim.trim(found)
            end
        end
    end
    return message, line_number
end

local function unescape(value)
    return value
        :gsub("&amp;", "&")
        :gsub("&quot;", '"')
        :gsub("&apos;", "'")
        :gsub("&lt;", "<")
        :gsub("&gt;", ">")
end

local function xml_attr(text, name)
    local value = text:match(name .. '="(.-)"')
    if value then
        return unescape(value)
    end
end

function M.parse_junit_xml(xml)
    local cases = {}
    local cursor = 1
    while true do
        local _, finish, inner = xml:find("<testcase%s+(.-)/?>", cursor)
        if not finish then
            break
        end
        local name = inner and xml_attr(inner, "name")
        local status = "passed"
        local message
        local self_closing = xml:sub(finish - 1, finish - 1) == "/"
        if not self_closing then
            local body_start = finish + 1
            local body_finish = xml:find("</testcase>", body_start, true)
            local body = xml:sub(body_start, (body_finish or #xml) - 1)
            if body:find("<failure", 1, true) or body:find("<error", 1, true) then
                status = "failed"
                local tag = body:match("<failure%s+(.-)>") or body:match("<error%s+(.-)>")
                message = tag and xml_attr(tag, "message")
            elseif body:find("<skipped", 1, true) then
                status = "skipped"
            end
            cursor = body_finish and (body_finish + #"</testcase>" - 1) or finish + 1
        else
            cursor = finish + 1
        end
        if name then
            table.insert(cases, { name = name, status = status, message = message })
        end
    end
    return cases
end

local function test_positions(tree)
    local positions = {}
    for _, position in tree:iter() do
        if position.type == "test" then
            table.insert(positions, position)
        end
    end
    return positions
end

function M.match_groups(groups, positions, qualified_classes)
    local results = {}
    local used = {}
    for _, group in ipairs(groups) do
        if M.class_matches(group.class_name, qualified_classes) then
            for _, position in ipairs(positions) do
                if not used[position.id] and M.method_matches(group.method, position.name) then
                    used[position.id] = true
                    local result = { status = group.status }
                    if group.status == "failed" then
                        local message, line_number = M.failure_details(group.lines, position.path)
                        result.short = message or group.lines[1]
                        result.errors = { { message = result.short, line = line_number } }
                    end
                    results[position.id] = result
                    break
                end
            end
        end
    end
    return results
end

function M.match_xml_cases(cases, positions)
    local results = {}
    local used = {}
    for _, case in ipairs(cases) do
        for _, position in ipairs(positions) do
            if not used[position.id] and M.method_matches(case.name, position.name) then
                used[position.id] = true
                local result = { status = case.status }
                if case.status == "failed" then
                    result.short = case.message or case.name
                    result.errors = { { message = result.short } }
                end
                results[position.id] = result
                break
            end
        end
    end
    return results
end

local function ancestor_file(start_dir, names)
    return vim.fs.find(names, {
        upward = true,
        path = start_dir,
        type = "file",
    })[1]
end

function M.has_nested_module(directory)
    local builds = vim.fs.find({ "build.gradle.kts", "build.gradle" }, {
        path = directory,
        limit = 2,
        type = "file",
    })
    for _, build in ipairs(builds) do
        if vim.fs.dirname(build) ~= vim.fs.normalize(directory) then
            return true
        end
    end
    return false
end

local function with_otel(spec)
    spec.env = vim.tbl_extend("force", spec.env or {}, OTEL_ENV)
    return spec
end

local function on_main_thread()
    if vim.in_fast_event() then
        require("nio").scheduler()
    end
end

local function is_kotest(file_path, read_lines)
    local ok, lines = pcall(read_lines, file_path)
    if not ok or not lines then
        return false
    end
    for _, line in ipairs(lines) do
        if line:find("io.kotest", 1, true) then
            return true
        end
    end
    return false
end

function M.install(kotlin)
    local treesitter = require("neotest-kotlin.treesitter")
    local lib = require("neotest.lib")
    local original_build_spec = kotlin.build_spec
    local original_results = kotlin.results
    local init_script = vim.api.nvim_get_runtime_file("test-logging.init.gradle.kts", false)[1]

    function kotlin.build_spec(args)
        local tree = args.tree
        if not tree then
            return nil
        end
        local position = tree:data()
        if position.type ~= "file" and position.type ~= "test" and position.type ~= "dir" then
            return nil
        end
        if position.type ~= "dir" and is_kotest(position.path, lib.files.read_lines) then
            -- The Kotest adapter creates a buffer while parsing the file.
            on_main_thread()
            local spec = original_build_spec(args)
            if spec then
                with_otel(spec)
            end
            return spec
        end

        local start_dir = position.type == "dir" and position.path or vim.fs.dirname(position.path)
        if position.type == "dir" and has_nested_module(start_dir) then
            error("neotest-kotlin: this directory contains multiple Gradle modules; run one module or a test file")
        end

        local build_file = ancestor_file(start_dir, { "build.gradle.kts", "build.gradle" })
        local gradlew = ancestor_file(start_dir, { "gradlew" })
        if not build_file or not gradlew then
            error("neotest-kotlin: could not find gradlew and a build script for " .. position.path)
        end

        local module_dir = vim.fs.dirname(build_file)
        local gradle_root = vim.fs.dirname(gradlew)
        local patterns
        local qualified = {}
        if position.type == "dir" then
            local package_name = M.package_from_path(position.path, true)
            if package_name and package_name ~= "" then
                patterns = { package_name .. ".*" }
            else
                patterns = {}
            end
        else
            local package_name = M.package_from_path(position.path)
            -- list_all_classes creates a buffer, which is illegal in a fast event.
            on_main_thread()
            if package_name == nil then
                package_name = treesitter.java_package(position.path)
            end
            local class_names = treesitter.list_all_classes(position.path)
            if not class_names or #class_names == 0 then
                local base = vim.fs.basename(position.path):gsub("%.kt$", ""):gsub("%.java$", "")
                class_names = { base }
            end
            qualified = M.qualified_classes(package_name, class_names)
            local method_name = position.type == "test" and M.bare_method_name(position.name) or nil
            patterns = M.test_patterns(qualified, method_name)
        end

        return with_otel({
            cwd = gradle_root,
            context = {
                junit = true,
                classes = qualified,
                module_dir = module_dir,
            },
            command = M.gradle_command({
                gradle_root = gradle_root,
                init_script = init_script,
                task = M.project_task(gradle_root, module_dir),
                patterns = patterns,
            }),
        })
    end

    function kotlin.results(spec, strategy_result, tree)
        if not (spec.context and spec.context.junit) then
            return original_results(spec, strategy_result, tree)
        end

        local lines = {}
        if strategy_result.output then
            local ok, read = pcall(lib.files.read_lines, strategy_result.output)
            if ok and read then
                lines = read
            end
        end

        local positions = test_positions(tree)
        local groups = M.parse_gradle_results(lines)
        local matched = M.match_groups(groups, positions, spec.context.classes)
        if next(matched) then
            return matched
        end
        if strategy_result.code ~= 0 then
            return {}
        end

        local xml_cases = {}
        for _, class_name in ipairs(spec.context.classes) do
            local xml_path = spec.context.module_dir
                .. "/build/test-results/test/TEST-"
                .. class_name
                .. ".xml"
            local ok, xml = pcall(lib.files.read, xml_path)
            if ok and xml then
                vim.list_extend(xml_cases, M.parse_junit_xml(xml))
            end
        end
        return M.match_xml_cases(xml_cases, positions)
    end
end

return M
