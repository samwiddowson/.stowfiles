return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    main = 'nvim-treesitter',
    opts = {},
    init = function()
        local ensure_installed = {
            "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query",
            "markdown", "markdown_inline",
        }

        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                pcall(vim.treesitter.start)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        local installed = require('nvim-treesitter.config').get_installed()
        local to_install = vim.iter(ensure_installed)
            :filter(function(p) return not vim.tbl_contains(installed, p) end)
            :totable()
        if #to_install > 0 then
            require('nvim-treesitter').install(to_install)
        end
    end,
}
