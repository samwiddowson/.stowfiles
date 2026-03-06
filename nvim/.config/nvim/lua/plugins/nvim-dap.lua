return {
    "mfussenegger/nvim-dap",
    dependencies = { "igorlfs/nvim-dap-view" },
    config = function()
        local dap = require("dap")
        local dap_ui_widgets = require("dap.ui.widgets")

        local dapView = false;
        vim.keymap.set("n", "<leader>dv", function()
            if (dapView) then
                vim.cmd("DapViewClose")
                dapView = false
            else
                vim.cmd("DapViewOpen")
                dapView = true
            end
        end, { desc = "DAP: Open DAP View" })

        vim.keymap.set("n", "<leader>dd", function()
            dap.toggle_breakpoint()
        end, { desc = "DAP: Toggle breakpoint" })

        vim.keymap.set("n", "<leader><leader>l", function()
            dap.step_into()
        end, { desc = "DAP: Step into" })

        vim.keymap.set("n", "<leader><leader>j", function()
            dap.step_over()
        end, { desc = "DAP: Step over" })

        vim.keymap.set("n", "<leader><leader>h", function()
            dap.step_out()
        end, { desc = "DAP: Step out" })

        vim.keymap.set("n", "<leader><leader>u", function()
            dap.step_out()
        end, { desc = "DAP: Restart frame" })

        vim.keymap.set("n", "<F5>", function()
            dap.continue()
        end, { desc = "DAP: Continue" })

        vim.keymap.set("n", "<leader><leader>k", function()
            dap_ui_widgets.hover()
        end, { desc = "DAP: Hover" })
    end
}
