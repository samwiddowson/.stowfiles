return
{
    'williamboman/mason.nvim',
    branch = 'v4.x',
    dependencies = {
        { 'neovim/nvim-lspconfig' },
        { 'nvimtools/none-ls.nvim' },
        { 'Hoffs/omnisharp-extended-lsp.nvim' }
    },
    config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettierd.with({
                    filetypes = { "javascript", "typescript", "css", "html", "json", "yaml", "markdown", "vue" }, -- customize as needed
                }),
            }
        })

        require('mason').setup({})

        local registry = require('mason-registry')
        registry.refresh()

        vim.lsp.enable("lua_ls")
        vim.lsp.enable("jsonls")
        vim.lsp.enable("vtsls")
        vim.lsp.enable("vue_ls")
        vim.lsp.enable("omnisharp")
        vim.lsp.enable('eslint')
        vim.lsp.enable('html')
        vim.lsp.enable('tailwindcss')
        vim.lsp.enable('markdown_oxide')
        vim.lsp.enable('zls')

        local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
        local event = "BufWritePre" -- or "BufWritePost"
        local async = event == "BufWritePost"
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if client:supports_method('textDocument/completion') then
                    vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'fuzzy', 'popup', 'preview' }
                    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
                end

                if client.supports_method("textDocument/formatting") then
                    vim.keymap.set("n", "<Leader>f", function()
                        vim.lsp.buf.format({ bufnr = ev.buf, async = true })
                    end, { buffer = ev.buf, desc = "[lsp] format" })

                    -- format on save
                    vim.api.nvim_clear_autocmds({ buffer = ev.buf, group = group })
                    vim.api.nvim_create_autocmd(event, {
                        buffer = ev.buf,
                        group = group,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = ev.buf, async = async })
                        end,
                        desc = "[lsp] format on save",
                    })
                end
            end,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
            end,
        })

        vim.diagnostic.config({
            virtual_lines = {
                -- Only show virtual line diagnostics for the current cursor line
                current_line = true,
            },
        })
    end
}
