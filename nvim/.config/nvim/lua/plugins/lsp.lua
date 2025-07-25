return
{
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    dependencies = {
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        { 'neovim/nvim-lspconfig' },
        { 'nvimtools/none-ls.nvim' },
        -- { 'hrsh7th/nvim-cmp' },
        -- { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
        { 'Hoffs/omnisharp-extended-lsp.nvim' }
    },
    config = function()
        local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
        local event = "BufWritePre" -- or "BufWritePost"
        local async = event == "BufWritePost"


        local lsp_zero = require('lsp-zero')
        lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({ buffer = bufnr })
            if client.supports_method("textDocument/formatting") then
                vim.keymap.set("n", "<Leader>f", function()
                    vim.lsp.buf.format({ bufnr = bufnr, async = true })
                end, { buffer = bufnr, desc = "[lsp] format" })

                -- format on save
                vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
                vim.api.nvim_create_autocmd(event, {
                    buffer = bufnr,
                    group = group,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr, async = async })
                    end,
                    desc = "[lsp] format on save",
                })
            end

            if client.supports_method("textDocument/rangeFormatting") then
                vim.keymap.set("x", "<Leader>f", function()
                    vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
                end, { buffer = bufnr, desc = "[lsp] format" })
            end
        end)

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

        require('mason-lspconfig').setup({

            ensure_installed = {
                'lua_ls',
                'eslint',
                'emmet_language_server',
                'html',
                'tailwindcss',
                'ts_ls',
                'vue_ls',
                -- 'angularls',
                'jsonls',
                'markdown_oxide',
                'zls'
            },
            handlers = {
                lsp_zero.default_setup,
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
            }
        })

        require('lspconfig').jsonls.setup({
            filetypes = { 'json' }
        })

        require('lspconfig').volar.setup({
            init_options = {
                vue = {
                    hybridMode = false,
                },
            },
            filetypes = { 'vue' }
        })

        require('lspconfig').emmet_language_server.setup({
            filetypes = {
                'css',
                'html',
                'javascriptreact',
                'less',
                'sass',
                'scss',
                'typescriptreact',
                'vue'
            }
        })

        local vueLanguageServerLocation = vim.fn.stdpath 'data' ..
            '/mason/packages/vue-language-server/node_modules/@vue/language-server'

        -- print('vueLanguageServerLocation = ' .. vueLanguageServerLocation)
        require('lspconfig').ts_ls.setup({
            init_options = {
                plugins = { -- I think this was my breakthrough that made it work
                    {
                        name = "@vue/typescript-plugin",
                        location = vueLanguageServerLocation,
                        languages = { "vue" },
                    },
                },
            },
            filetypes = {
                'css',
                'html',
                'javascriptreact',
                'less',
                'sass',
                'scss',
                'typescriptreact',
                'vue'
            },
            root_dir = function() return vim.loop.cwd() end,
        })


        require "lspconfig".omnisharp.setup({
            cmd = {
                "/home/sam/.local/share/nvim/mason/bin/omnisharp-mono",
                "--languageserver",
                "--hostPID",
                tostring(vim.fn.getpid())
            },
            root_dir = require "lspconfig".util.root_pattern("*.sln", "*.csproj", ".git"),
            enable_editorconfig_support = true,
            enable_roslyn_analyzers = true,
            organize_imports_on_format = true,
            enable_import_completion = true,
            handlers = {
                ["textDocument/definition"] = require("omnisharp_extended").handler,
            },
        })

        -- local cmp = require('cmp')
        --
        -- cmp.setup({
        --     sources = {
        --         { name = 'nvim_lsp' },
        --     },
        --     snippet = {
        --         expand = function(args)
        --             -- You need Neovim v0.10 to use vim.snippet
        --             vim.snippet.expand(args.body)
        --         end,
        --     },
        --     mapping = cmp.mapping.preset.insert({}),
        -- })
        --

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if client:supports_method('textDocument/completion') then
                    vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
                    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
                end
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
