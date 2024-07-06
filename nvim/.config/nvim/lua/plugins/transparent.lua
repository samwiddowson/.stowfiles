local transparent = require("transparent")

vim.g.transparent_groups = vim.list_extend(
    vim.g.transparent_groups or {},
    { "NormalFloat"}
)
