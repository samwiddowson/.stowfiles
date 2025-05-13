return {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({})
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
        vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga show_workspace_diagnostics ++normal<CR>', opts)

        vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
        vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder<CR>', opts)
        vim.keymap.set('n', 'gr', '<Cmd>lspsaga rename<cr>', opts)

        vim.keymap.set('n', '<C-o>', '<Cmd>Lspsaga outline<cr>', opts)
        -- vim.keymap.set({ 'n', 't' }, '<A-d>', '<cmd>Lspsaga term_toggle<CR>')
    end,
    dependencies = {
        'VonHeikemen/lsp-zero.nvim'
    }
}
