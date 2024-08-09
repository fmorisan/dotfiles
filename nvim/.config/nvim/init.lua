require("config.lazy")

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.title = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.keymap.set({'n'}, "gd", vim.lsp.buf.definition)
