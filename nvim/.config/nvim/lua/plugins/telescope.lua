return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-live-grep-args.nvim" ,
            -- This will not install any breaking changes.
            -- For major updates, this must be adjusted manually.
            version = "^1.0.0",
        },
    },
	config = function(_, opts)
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		vim.keymap.set('n', '<leader>fp', builtin.quickfix)
		vim.keymap.set('n', '<leader>fc', builtin.colorscheme)
        require("telescope").setup(opts)

        require("telescope").load_extension("live_grep_args")
		vim.keymap.set('n', '<leader>fg', ":lua require(\"telescope\").extensions.live_grep_args.live_grep_args()<CR>", {})

	end
}
