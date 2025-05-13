return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local fzf = require('fzf-lua')
        fzf.setup()
        vim.keymap.set('n', '<C-p>', fzf.git_files, {})
        vim.keymap.set('n', '<leader>po', fzf.files, {})
        vim.keymap.set('n', '<leader>r', fzf.registers, {})
        vim.keymap.set('n', '<leader>m', fzf.marks, {})
        vim.keymap.set('n', '<leader>b', fzf.buffers, {})
        vim.keymap.set('n', '<leader>i', fzf.live_grep, {})
    end
}
