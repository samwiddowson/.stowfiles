return {
    'mrcjkb/rustaceanvim',
    version = '^8', -- Recommended
    lazy = false,   -- This plugin is already lazy
    config = function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.keymap.set('n', '<leader>K', function()
                vim.cmd.RustLsp('codeAction')
            end,
            {
                buffer = bufnr,
                desc = 'Rustaceanvim - Code action'
            })
        vim.keymap.set('n', 'K', function()
                vim.cmd.RustLsp('hover', 'actions')
            end,
            {
                buffer = bufnr,
                desc = 'Rustaceanvim - Hover actions'
            })
    end
}
