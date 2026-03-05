return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local fzf = require('fzf-lua')
        require('fzf-lua').register_ui_select()
        vim.keymap.set('n', '<C-p>', fzf.git_files, {})
        vim.keymap.set('n', '<leader>po', fzf.files, { desc = "Open file in directory" })
        vim.keymap.set('n', '<leader>r', fzf.registers, { desc = "View registers" })
        vim.keymap.set('n', '<leader>m', fzf.marks, { desc = "View marks" })
        vim.keymap.set('n', '<leader>b', fzf.buffers, { desc = "View open files" })
        vim.keymap.set('n', '<leader>i', fzf.live_grep, { desc = "Live grep" })
        vim.keymap.set('n', '<leader>k', fzf.keymaps, { desc = "View keymaps" })
        vim.keymap.set('n', '<leader>gc', fzf.git_commits, { desc = "View commit history" })
        vim.keymap.set('n', '<leader>gb', fzf.git_bcommits, { desc = "View file commit history" })
    end
}
