vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.cmd("set autochdir")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=0 noexpandtab")
vim.cmd("set shiftwidth=4")
vim.cmd("set nohlsearch")

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
