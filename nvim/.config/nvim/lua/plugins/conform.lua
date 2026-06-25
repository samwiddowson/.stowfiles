local prettier_opts = {
    -- Only run when the project has a Prettier config (.prettierrc*, prettier.config.*,
    -- or a "prettier" key in package.json).
    require_cwd = true,
}

local prettier_formatters = { "prettierd", "prettier", stop_after_first = true }

return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<Leader>f",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = { "n", "x" },
            desc = "Format buffer",
        },
    },
    opts = {
        formatters = {
            prettier = prettier_opts,
            prettierd = prettier_opts,
        },
        formatters_by_ft = {
            javascript      = prettier_formatters,
            javascriptreact = prettier_formatters,
            typescript      = prettier_formatters,
            typescriptreact = prettier_formatters,
            json            = prettier_formatters,
            jsonc           = prettier_formatters,
            css             = prettier_formatters,
            scss            = prettier_formatters,
            less            = prettier_formatters,
            html            = prettier_formatters,
            htmlangular     = prettier_formatters,
            markdown        = prettier_formatters,
            yaml            = prettier_formatters,
            graphql         = prettier_formatters,
            vue             = prettier_formatters,
            svelte          = prettier_formatters,
        },
        format_on_save = {
            timeout_ms = 2000,
            lsp_format = "fallback",
        },
    },
}
