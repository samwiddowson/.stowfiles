local M = {}

local lib = require("neotest.lib")
local RTL_IMPORT = "@testing%-library/react"
local TEST_EXTENSIONS = { "tsx", "jsx", "ts", "js" }

local function matches_test_path(file_path)
    if file_path:find("__tests__") then
        return true
    end

    for _, kind in ipairs({ "spec", "test" }) do
        for _, ext in ipairs(TEST_EXTENSIONS) do
            if file_path:match("%." .. kind .. "%." .. ext .. "$") then
                return true
            end
        end
    end

    return false
end

local function file_extension(file_path)
    return file_path:match("%.([^.]+)$")
end

---@async
---@param file_path string?
---@return boolean
function M.uses_react_testing_library(file_path)
    if not file_path then
        return false
    end

    local ok, content = pcall(lib.files.read, file_path)
    if not ok or not content then
        return false
    end

    return content:match(RTL_IMPORT) ~= nil
end

---React component tests that import @testing-library/react.
---@async
---@param file_path string?
---@return boolean
function M.is_react_test_file(file_path)
    if not file_path or not M.uses_react_testing_library(file_path) then
        return false
    end

    local ext = file_extension(file_path)
    if not ext or not vim.tbl_contains(TEST_EXTENSIONS, ext) then
        return false
    end

    return matches_test_path(file_path)
end

return M
