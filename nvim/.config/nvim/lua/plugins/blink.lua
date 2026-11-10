return {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
        keymap = { preset = 'default' },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            list = { selection = { preselect = true, auto_insert = false } },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            per_filetype = {
                kotlin = { 'lsp', 'path' },
            },
        },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
}
