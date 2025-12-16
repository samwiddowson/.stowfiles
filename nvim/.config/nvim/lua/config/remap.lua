vim.g.mapleader = " "

local map = vim.keymap.set

-- remappings
map({ "n", "x" }, ";", ":", { desc = "Switch : and ; mappings" })
map({ "n", "x" }, ":", ";", { desc = "Switch : and ; mappings" })

-- disable these
map({ "n", "x" }, "ZZ", "<nop>")
map({ "n", "x" }, "ZQ", "<nop>")
map("n", "Q", "<nop>")
map("n", "q:", "<nop>")

-- window stuff
map("n", "<leader>\\", "<C-^>", { desc = "Switch to alternate file" })
map("n", "<leader>S", "<Cmd>vs #<CR>", { desc = "Open alternate file as split window" })
map({ "i", "n", "x" }, "<M-n>", "<Cmd>vertical resize -5<CR>", { desc = "Decrease window width" })
map({ "i", "n", "x" }, "<M-.>", "<Cmd>vertical resize +5<CR>", { desc = "Increase window width" })
map({ "i", "n", "x" }, "<M-m>", "<Cmd>horizontal resize -2<CR>", { desc = "Decrease window height" })
map({ "i", "n", "x" }, "<M-,>", "<Cmd>horizontal resize +2<CR>", { desc = "Increase window height" })

-- file stuff
map({ "n", "x" }, "<leader>o", ":update<CR> :source<CR>", { desc = "Write and source file" })
map({ "n", "x" }, "<leader>w", ":update<CR>", { desc = "Write file" })

-- view stuff
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down and recentre" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up and recentre" })

-- register/clipboard stuff
map("x", "<leader>p", "\"_dP", { desc = "Put (keep register)" })
map("n", "<leader>y", "\"+y", { desc = "yank to clipboard" })
map("x", "<leader>y", "\"+y", { desc = "yank to clipboard" })
map("n", "<leader>Y", "\"+Y", { desc = "yank to end of line to clipboard" })
map("n", "<leader><leader>pp", "\"+p", { desc = "Put from clipboard" })

-- other
map("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
map("x", ">>", ">>gv", { desc = "Keep text highlighted after shifting indent" })
map("x", "<<", "<<gv", { desc = "Keep text highlighted after shifting indent" })
map({ "n", "x" }, "<leader>l", ":norm ", { desc = ":norm shortcut" })

map("n", "J", "mzJ`z", { desc = "Join line below and retain cursor position" })

map("n", "<leader>;", function()
    vim.wo.wrap = not vim.wo.wrap
    vim.wo.linebreak = true
end, { desc = "Toggle word wrapping" })

-- map("n", "n", "nzzzv", { desc = "" })
-- map("n", "N", "Nzzzv", { desc = "" })

map("i", "<C-n>", "<C-x><C-o>", { desc = "Activate autocomplete" })

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word in file" })
map("x", "<leader>s", function()
    vim.cmd('normal! "+y')
    local selected = vim.fn.getreg("+")
    local cmd = ':%s/' .. selected .. '/' .. selected .. '/gI<Left><Left><Left>'
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), 'n', false)
end, { desc = "Replace selection in file" })

map("n", "<leader>nn", function()
    vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "toggle relative line numbers" })

map("n", "<leader>hs", function()
    vim.opt.hlsearch = true
end, { desc = "search hilighting on" })

map("n", "<leader>hx", function()
    vim.opt.hlsearch = false
end, { desc = "search highlighting off" })

map("n", "<leader>zm", function()
    vim.opt.foldmethod = "marker"
    vim.opt.foldmarker = "#region,#endregion"
end, { desc = "Set foldmethod to 'marker'" })

map("n", "<leader>zi", function()
    vim.opt.foldmethod = "indent"
end, { desc = "Set foldmethod to 'indent'" })
