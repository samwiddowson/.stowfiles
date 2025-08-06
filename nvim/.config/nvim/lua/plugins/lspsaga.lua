return {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({})
        vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>',
            { noremap = true, silent = true, desc = "Jump to next diagnostic" })
        vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga show_workspace_diagnostics ++normal<CR>',
            { noremap = true, silent = true, desc = "Show workspace diagnostics" })

        vim.keymap.set('n', 'gff', '<Cmd>Lspsaga finder<CR>',
            { noremap = true, silent = true, desc = "Find all definitions, implementations and references" })
        vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder def<CR>',
            { noremap = true, silent = true, desc = "Find definitions" })
        vim.keymap.set('n', 'gfi', '<Cmd>Lspsaga finder imp<CR>',
            { noremap = true, silent = true, desc = "Find implementations" })
        vim.keymap.set('n', 'grr', '<Cmd>Lspsaga finder ref<CR>',
            { noremap = true, silent = true, desc = "Find references" })
        vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>',
            { noremap = true, silent = true, desc = "Peek definition" })
        vim.keymap.set('n', 'gop', '<Cmd>Lspsaga goto_definition<CR>',
            { noremap = true, silent = true, desc = "Go to definition" })
        vim.keymap.set('n', 'gt', '<Cmd>Lspsaga peek_type_definition<CR>',
            { noremap = true, silent = true, desc = "Peek type definition" })
        vim.keymap.set('n', 'got', '<Cmd>Lspsaga goto_type_definition<CR>',
            { noremap = true, silent = true, desc = "Goto type definition" })

        vim.keymap.set('n', '<C-o>', '<Cmd>Lspsaga outline<CR>',
            { noremap = true, silent = true, desc = "Show outline" })
    end,
    dependencies = {
        'VonHeikemen/lsp-zero.nvim'
    }
}
