local prettier_opts = {
    -- Only run when the project has a Prettier config (.prettierrc*, prettier.config.*,
    -- or a "prettier" key in package.json).
    require_cwd = true,
}

local prettier_formatters = { "prettierd", "prettier", stop_after_first = true }

local ktlint_opts = {
    command = vim.fn.expand("~/.local/bin/ktlint"),
    args = { "--format", "--stdin", "--stdin-path", "$FILENAME", "--log-level=none" },
    exit_codes = { 0, 1 },
    -- asdf selects the JDK from .tool-versions, which ktlint's java launcher needs.
    cwd = function(_, ctx)
        return vim.fs.root(ctx.dirname, ".tool-versions")
    end,
}

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
            ktlint = ktlint_opts,
        },
        formatters_by_ft = {
            kotlin          = { "ktlint" },
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
        format_on_save = function(bufnr)
            -- ktlint starts a JVM, so Kotlin needs a longer budget than Prettier.
            local timeout_ms = vim.bo[bufnr].filetype == "kotlin" and 10000 or 2000
            return {
                timeout_ms = timeout_ms,
                lsp_format = "fallback",
            }
        end,
    },
}
