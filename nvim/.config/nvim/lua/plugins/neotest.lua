return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nsidorenco/neotest-vstest",
    },
    config = function()
        local neotest = require("neotest")
        neotest.setup({
            adapters = {
                require("neotest-vstest")
            }
        })

        vim.keymap.set("n", "<leader>to", function()
            neotest.output_panel.toggle()
        end, { desc = "NeoTest: Toggle output" })

        vim.keymap.set("n", "<leader>ts", function()
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
    end
}
