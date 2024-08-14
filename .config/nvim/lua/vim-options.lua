vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
vim.cmd("set numberwidth=2")

-- Insert mode mapping for 'kj' to exit insert mode
vim.api.nvim_set_keymap('i', 'kj', '<Esc>', { noremap = true, silent = true })
vim.opt.timeoutlen = 500

vim.opt.swapfile = false
