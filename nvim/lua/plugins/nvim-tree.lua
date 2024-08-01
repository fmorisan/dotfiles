return {
	"nvim-tree/nvim-tree.lua",
	config = function() 
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
		require("nvim-tree").setup({})
	end
}
