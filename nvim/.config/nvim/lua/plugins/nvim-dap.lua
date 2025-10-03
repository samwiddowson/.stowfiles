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

        vim.keymap.set("n", "<leader>db", function()
            dap.toggle_breakpoint()
        end, { desc = "DAP: Toggle breakpoint" })

        vim.keymap.set("n", "M-Right", function()
            dap.step_into()
        end, { desc = "DAP: Step into" })

        vim.keymap.set("n", "M-Down", function()
            dap.step_over()
        end, { desc = "DAP: Step over" })

        vim.keymap.set("n", "M-Left", function()
            dap.step_out()
        end, { desc = "DAP: Step out" })

        vim.keymap.set("n", "M-Up", function()
            dap.step_out()
        end, { desc = "DAP: Restart frame" })

        vim.keymap.set("n", "<F5>", function()
            dap.continue()
        end, { desc = "DAP: Continue" })

        vim.keymap.set("n", "M-k", function()
            dap_ui_widgets.hover()
        end, { desc = "DAP: Hover" })
    end
}
