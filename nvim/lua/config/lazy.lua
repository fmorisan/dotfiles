local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- If lazyvim is not found, install it
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath
	})

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{
				"Failed to clone lazy.nvim\n", "ErrorMsg"
			},
			{
				out, "WarningMsg"
			},
			{
				"Press any key to exit...\n"
			}, 
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","
vim.g.maplocalleader = "//"

local lazy = require("lazy")

lazy.setup({
	spec = {
		{ import = "plugins" },
	},

	install = {
		colorscheme = { "catppuccin-macchiato" },
	},
	checker = {
		enabled = true,
	}
})

if require("lazy.status").has_updates() then
    require("lazy").update()
end
