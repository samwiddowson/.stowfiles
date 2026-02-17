return {
    'nvimtools/none-ls.nvim',
    ft = { "yaml", "javascript", "typescript", "css", "html", "json", "markdown", "vue" },
    config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettierd.with({
                    filetypes = { "javascript", "typescript", "css", "html", "json", "markdown", "vue" },
                }),
                null_ls.builtins.diagnostics.kube_linter,
            }
        })
    end,
}
