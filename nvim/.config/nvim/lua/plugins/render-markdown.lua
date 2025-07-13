return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {},
    config = function()
        local render_markdown = require('render-markdown')
        vim.keymap.set("n", "<leader>d", render_markdown.toggle, { desc = "Toggle Render-Markdown" })
    end
}
