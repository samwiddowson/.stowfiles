return {
    'preservim/vim-pencil',
    config = function()
        vim.keymap.set("n", "<leader>f", "<cmd>SoftPencil<CR>")
    end
}
