vim.cmd("set number")
vim.cmd("set autoindent")
vim.cmd("set smartindent")
vim.cmd("set wrap")
vim.cmd("set linebreak")
vim.cmd("set expandtab")
vim.cmd("set sw=4 ts=4")
vim.cmd("set t_RV=")
vim.cmd("set t_u7=")
vim.cmd("set t_vb=")
vim.cmd("set relativenumber")

require("config.lazy")
vim.cmd.colorscheme "catppuccin"
