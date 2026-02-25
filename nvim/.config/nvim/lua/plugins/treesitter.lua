return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require 'nvim-treesitter.configs'.setup({
            ensure_installed = { "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "hyprlang" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            modules = {},
            ignore_install = {}

        })

        vim.api.nvim_create_autocmd('User', {
            pattern = 'TSUpdate',
            callback = function()
                require('nvim-treesitter.parsers').hyprlang = {
                    install_info = {
                        url = 'https://github.com/tree-sitter-grammars/tree-sitter-hyprlang',
                        commit = 'HEAD',
                        -- optional entries:
                        queries = 'queries/hyprlang', -- also install queries from given directory
                    },
                }
            end
        })
        vim.filetype.add({
            pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
        })
    end,
}
