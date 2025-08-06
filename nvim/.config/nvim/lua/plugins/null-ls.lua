return {
    'nvimtools/none-ls.nvim',
    config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettierd.with({
                    filetypes = { "javascript", "typescript", "css", "html", "json", "yaml", "markdown", "vue" },
                }),
            }
        })
    end,
}
