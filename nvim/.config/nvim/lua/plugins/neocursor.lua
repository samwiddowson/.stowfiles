return {
    "samwiddowson/neocursor.nvim",
    event = "InsertEnter",
    -- pre-warm the sidecar (double quotes so cmd.exe and sh both parse it)
    build = 'uv run --with "httpx[http2]" python -c "import httpx"',
    config = function()
        vim.env.CURSOR_CONFIG_DIR = vim.fn.expand("~/.config/neocursor-cli")
        require("neocursor").setup({
            debounce    = 250,
            map_tab     = true,
            map_partial = false,
            filetypes   = { "python", "typescript", "typescriptreact", "kotlin" },
            show_hints  = true,
            sidecar_cmd = { "uv", "run", "--with", "httpx[http2]" },
        })
    end,
    opts = {},
}
