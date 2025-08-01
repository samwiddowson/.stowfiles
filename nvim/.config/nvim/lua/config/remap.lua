vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<leader>pv", vim.cmd.NvimTreeOpen, { desc = "Open NvimTree" })

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "<leader>p", "\"_dP", { desc = "Put (keep register)" })

map("n", "<leader>y", "\"+y", { desc = "yank to clipboard" })
map("v", "<leader>y", "\"+y", { desc = "yank to clipboard" })
map("n", "<leader>Y", "\"+Y")

map("n", "<leader><leader>pp", "\"+p", { desc = "Put from clipboard" })

map("v", "<C-c>", "\"+yi")
map("v", "<C-x>", "\"+c")
-- map("v", "<C-v>", "c<Esc>\"+p")
map("i", "<C-v>", "<Esc>\"+pa")

map("n", "Q", "<nop>")
map("n", "q:", "<nop>")

-- map("n", "<leader>f", function()
--     vim.lsp.buf.format()
-- end)

-- map("n", "<C-k>", "<cmd>cnext<CR>zz")
-- map("n", "<C-j>", "<cmd>cprev<CR>zz")
-- map("n", "<leader>k", "<cmd>lnext<CR>zz")
-- map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word in file" })
-- map("v", "<leader>s", "\"+y:%s/<C-V>/<C-V>/gI<Left><Left><Left>")
map("v", "<leader>s", function()
    vim.cmd('normal! "+y')
    local selected = vim.fn.getreg("+")
    local cmd = ':%s/' .. selected .. '/' .. selected .. '/gI<Left><Left><Left>'
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), 'n', false)
end, { desc = "Replace selection in file" })

map("n", "<leader>nn", function() --toggle relative vs absolute line numbers
    vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "toggle relative line numbers" })

map("n", "<leader>zm", function()
    vim.opt.foldmethod = "marker"
    vim.opt.foldmarker = "#region,#endregion"
end, { desc = "Set foldmethod to 'marker'" })

map("n", "<leader>zi", function()
    vim.opt.foldmethod = "indent"
end, { desc = "Set foldmethod to 'indent'" })
