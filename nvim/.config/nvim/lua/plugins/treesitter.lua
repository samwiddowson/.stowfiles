return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    main = 'nvim-treesitter',
    opts = {},
    init = function()
        local ensure_installed = {
            "bash", "c", "ecma", "groovy", "html", "html_tags", "java", "javascript", "json", "jsx", "kotlin", "lua",
            "make", "markdown", "markdown_inline", "python", "query", "toml", "typescript", "vim", "vimdoc", "yaml",
            "zsh",
        }

        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                local ts = require('nvim-treesitter')
                local lang = vim.treesitter.language.get_lang(args.match)
                if lang and vim.list_contains(ts.get_available(), lang)
                    and not vim.list_contains(ts.get_installed(), lang) then
                    ts.install(lang, function()
                        vim.schedule(function()
                            vim.treesitter.start(args.buf, lang)
                        end)
                    end)
                end
                pcall(vim.treesitter.start)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        vim.api.nvim_create_user_command('TSDump', function()
            local parsers = require('nvim-treesitter').get_installed()
            table.sort(parsers)
            local quoted = vim.tbl_map(function(p) return '"' .. p .. '"' end, parsers)
            local line = '            ' .. table.concat(quoted, ', ') .. ','
            vim.api.nvim_put({ line }, 'l', true, true)
        end, {})

        local installed = require('nvim-treesitter.config').get_installed()
        local to_install = vim.iter(ensure_installed)
            :filter(function(p) return not vim.tbl_contains(installed, p) end)
            :totable()
        if #to_install > 0 then
            require('nvim-treesitter').install(to_install)
        end
    end,
}
