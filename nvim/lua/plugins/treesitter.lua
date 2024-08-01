return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = "all",
	},
	config = function(_, opts)
		vim.cmd("silent :TSUpdate")
		require("nvim-treesitter.configs").setup(opts)
	end,
}
