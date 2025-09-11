vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.encoding = "UTF-8"
vim.o.fileencoding = "UTF-8"

vim.opt.shell = "/bin/zsh"

vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true

vim.o.showtabline = 2 -- Always show the tabline

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true
vim.o.cursorcolumn = true

vim.opt.foldmethod = "indent"
vim.opt.foldenable = true -- Enable folding
vim.opt.foldlevel = 99    -- Start with all folds open

-- Disable providers for languages not in use
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

