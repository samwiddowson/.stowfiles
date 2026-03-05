return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Vim Fugitive" })
        vim.keymap.set("n", "<leader>ggb", ":Git blame<CR>", { desc = "Open Vim Fugitive" })
    end
}
