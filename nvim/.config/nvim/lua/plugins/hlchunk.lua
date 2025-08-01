return {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("hlchunk").setup({
            chunk = {
                enable = true,
                chars = {
                    horizontal_line = "─",
                    vertical_line = "│",
                    left_top = "╭",
                    left_bottom = "╰",
                    right_arrow = "─",
                },
                use_treesitter = true,
                style = {
                    { fg = "#3C4841" },
                    { fg = "#4C3743" },
                },
                duration = 0,
                delay = 0,
            },
            indent = {
                enable = true,
                use_treesitter = false,
                chars = {
                    " ",
                },
                style = {
                    { bg = "#220000" },
                    { bg = "#221100" },
                    { bg = "#222200" },
                    { bg = "#002200" },
                    { bg = "#002222" },
                    { bg = "#000022" },
                    { bg = "#150022" },
                },
            },
        })
    end
}
