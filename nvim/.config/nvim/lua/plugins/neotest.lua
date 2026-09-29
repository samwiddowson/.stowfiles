return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-jest",
        "marilari88/neotest-vitest",
        "codymikol/neotest-kotlin",
        "mfussenegger/nvim-dap",
    },
    config = function()
        local neotest = require("neotest")
        local react_test_files = require("config.react-test-files")
        local jest_util = require("neotest-jest.jest-util")

        local function ignore_dir(name)
            local ignore = {
                "node_modules",
                ".venv",
                "venv",
                ".git",
                "__pycache__",
                "dist",
                "build",
            }
            return not vim.tbl_contains(ignore, name)
        end

        neotest.setup({
            discovery = {
                filter_dir = function(name, rel_path, root)
                    return ignore_dir(name)
                end,
            },
            adapters = {
                require("neotest-python")({
                    args = { "--log-level", "DEBUG" },
                    runner = "pytest",
                }),
                require("neotest-jest")({
                    isTestFile = function(file_path)
                        if not react_test_files.is_react_test_file(file_path) then
                            return false
                        end
                        return jest_util.hasJestDependency(file_path)
                    end,
                }),
                require("neotest-vitest")({
                    is_test_file = function(file_path)
                        return react_test_files.is_react_test_file(file_path)
                    end,
                    filter_dir = function(name, rel_path, root)
                        return ignore_dir(name)
                    end,
                }),
                (function()
                    local kotlin = require("neotest-kotlin")
                    require("config.neotest-kotlin-junit").install(kotlin)
                    return kotlin
                end)(),
            },
        })

        vim.keymap.set("n", "<leader>tt", function()
            neotest.output_panel.toggle()
        end, { desc = "NeoTest: Toggle output" })

        vim.keymap.set("n", "<leader>to", function()
            neotest.summary.toggle()
        end, { desc = "NeoTest: Toggle summary" })

        vim.keymap.set("n", "<leader>tr", function()
            neotest.run.run()
        end, { desc = "NeoTest: Run current test" })

        vim.keymap.set("n", "<leader>tf", function()
            neotest.run.run(vim.fn.expand("%"))
        end, { desc = "NeoTest: Run current file" })

        vim.keymap.set("n", "<leader>tw", function()
            neotest.watch.toggle(vim.fn.expand("%"))
        end, { desc = "NeoTest: Toggle watch on current file" })

        vim.keymap.set("n", "<leader>td", function()
            neotest.run.run({ strategy = "dap" })
        end, { desc = "NeoTest: Debug nearest test" })

        vim.keymap.set("n", "<leader>tD", function()
            neotest.run.run({ vim.fn.expand("%"), strategy = "dap" })
        end, { desc = "NeoTest: Debug current file" })
    end
}
