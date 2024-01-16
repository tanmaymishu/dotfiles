vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.list = true -- enable the below listchars
vim.opt.listchars = { tab = "▸ ", trail = "·" }
vim.opt.fillchars:append({ eob = " " }) -- remove the ~ from end of buffer
vim.opt.completeopt = "menuone,longest,preview"
