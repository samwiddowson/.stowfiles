return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {
            model = 'gpt-5.2',       -- AI model to use
            temperature = 0.1,       -- Lower = focused, higher = creative
            window = {
                layout = 'vertical', -- 'vertical', 'horizontal', 'float'
                width = 0.5,         -- 50% of screen width
            },
            auto_insert_mode = true, -- Enter insert mode when opening
        },
        config = function()
            require("CopilotChat").setup()

            vim.keymap.set("n", "<leader>cc", "<Cmd>CopilotChatToggle<CR>", { desc = "CopilotChat: Toggle window" })
            vim.keymap.set("n", "<leader>cm", "<Cmd>CopilotChatModels<CR>", { desc = "CopilotChat: Select model" })
            vim.keymap.set("n", "<leader>cb", [[:lua require ("CopilotChat").ask("#buffer ")<Left><Left>]],
                { desc = "CopilotChat: Ask a question about this buffer" })
        end,
    },
}
