return {
	"RRethy/vim-illuminate",
	event = "VeryLazy", -- LazyFile in LazyVim
	opts = {
		providers = { "lsp" },
		delay = 100,
		filetypes_denylist = {
			"dirbuf",
			"dirvish",
			"fugitive",
		},
		under_cursor = true,
		large_file_cutoff = 2000,
		large_file_overrides = nil,
		min_count_to_highlight = 1,
		case_insensitive_regex = false,
	},
	config = function(_, opts)
		require("illuminate").configure(opts)
	end,
}
