return {
	"catppuccin/nvim",
	name = "catppuccin",
	prioroty = 1000,
	init = function()
		vim.cmd.colorscheme("catppuccin")
		-- vim.cmd.hi("Comment gui=none")
	end,
	opts = {
		flavour = "macchiato",
		transparent_background = true,
		show_end_of_buffer = true,
		term_colors = true,
		highlight_overrides = {
			macchiato = function(mocha)
				return {
					LineNr = { fg = mocha.subtext1 },
					LineNrAbove = { fg = mocha.overlay2 },
					LineNrBelow = { fg = mocha.overlay2 },
				}
			end,
		},
		integrations = {
			aerial = true,
			dashboard = true,
			diffview = true,
			dropbar = { enabled = true, color_mode = true },
			gitsigns = true,
			mason = true,
			neotree = true,
			noice = true,
			cmp = true,
			treesitter_context = true,
			treesitter = true,
			telescope = { enabled = true },
			lsp_trouble = true,
			illuminate = { enabled = true, lsp = false },
			which_key = true,
		},
	},
}
