local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		-- sorting_strategy = "ascending",
		mappings = {
			i = {
				["<Esc>"] = actions.close,
			},
		},
	},
})
