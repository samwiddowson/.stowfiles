return {
    "mfussenegger/nvim-dap",
    dependencies = { "igorlfs/nvim-dap-view", "mfussenegger/nvim-dap-python" },
    config = function()
        local dap = require("dap")
        local dap_ui_widgets = require("dap.ui.widgets")

        -- set up nvim-dap-python
        -- TODO: probably only run this for a python project with a .venv
        require("dap-python").setup("uv")

        -- Remote Python debugging (attach to debugpy listening on remote host)
        table.insert(dap.configurations.python, {
            type = "python",
            request = "attach",
            name = "Remote Attach",
            connect = function()
                local host = vim.fn.input("Host [127.0.0.1]: ")
                host = host ~= "" and host or "127.0.0.1"
                local port = tonumber(vim.fn.input("Port [5678]: "))
                port = port and port or 5678
                return { host = host, port = port }
            end,
            pathMappings = {
                {
                    localRoot = function()
                        return vim.fn.input("Local root [" .. vim.fn.getcwd() .. "]: ", vim.fn.getcwd())
                    end,
                    remoteRoot = function()
                        return vim.fn.input("Remote root [.]: ", ".")
                    end,
                },
            },
        })

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

        vim.keymap.set("n", "<F9>", function()
            dap.step_into()
        end, { desc = "DAP: Step into" })

        vim.keymap.set("n", "<F7>", function()
            dap.step_over()
        end, { desc = "DAP: Step over" })

        vim.keymap.set("n", "<F6>", function()
            dap.step_out()
        end, { desc = "DAP: Step out" })

        vim.keymap.set("n", "<F8>", function()
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
