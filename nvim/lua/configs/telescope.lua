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

require("telescope").load_extension("fzf")
require("telescope").load_extension("live_grep_args")
