-- local tmux = require "tmux"
-- vim.keymap.set("n", "M-h", tmux.)
-- vim.keymap.set("n", "M-l", tmux.move_right())
-- vim.keymap.set("n", "M-k", tmux.move_up())
-- vim.keymap.set("n", "M-j", tmux.move_down())

local map = vim.api.nvim_set_keymap
map("n", "<Left>", [[<cmd>lua require('tmux').move_left()<cr>]], {})
map("n", "<Down>", [[<cmd>lua require('tmux').move_down()<cr>]], {})
map("n", "<Up>", [[<cmd>lua require('tmux').move_up()<cr>]], {})
map("n", "<Right>", [[<cmd>lua require('tmux').move_right()<cr>]], {})
