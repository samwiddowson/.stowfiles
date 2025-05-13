return {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({})
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
        vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga show_workspace_diagnostics ++normal<CR>', opts)

        vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
        vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder<CR>', opts)
        vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
        vim.keymap.set('n', 'ggp', '<Cmd>Lspsaga goto_definition<CR>', opts)
        vim.keymap.set('n', 'gt', '<Cmd>Lspsaga peek_type_definition<CR>', opts)
        vim.keymap.set('n', 'ggt', '<Cmd>Lspsaga goto_type_definition<CR>', opts)
        vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

        vim.keymap.set('n', '<C-o>', '<Cmd>Lspsaga outline<CR>', opts)
        -- vim.keymap.set({ 'n', 't' }, '<A-d>', '<cmd>Lspsaga term_toggle<CR>')
    end,
    dependencies = {
        'VonHeikemen/lsp-zero.nvim'
    }
}
