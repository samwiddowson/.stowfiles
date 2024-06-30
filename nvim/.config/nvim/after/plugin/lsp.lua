local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'tsserver', 'eslint', 'lua_ls', 'volar', 'emmet_language_server', 'tailwindcss' },
    handlers = {
        --	lsp_zero.default_setup,
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,

        volar = function()
            require 'lspconfig'.volar.setup {
                filetypes = { 'vue', 'json' }
            }
        end,

        tsserver = function()
            require('lspconfig').tsserver.setup {
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', },
                cmd = { "typescript-language-server", "--stdio"},
                root_dir = function() return vim.loop.cwd() end
            }
        end,

        emmet_language_server = function()
            require 'lspconfig'.emmet_language_server.setup {
                filetypes = { "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "typescriptreact", "vue" }
            }
        end,

    }
})
