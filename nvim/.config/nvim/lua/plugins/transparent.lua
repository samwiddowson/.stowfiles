return {
    'xiyaowong/transparent.nvim',
    config = function()
        local transparent = require("transparent").setup()

        vim.g.transparent_groups = vim.list_extend(
            vim.g.transparent_groups or {},
            { "NormalFloat" }
        )
    end
}
