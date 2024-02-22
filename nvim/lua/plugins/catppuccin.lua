return {
	"catppuccin/nvim",
	name = "catppuccin",
	prioroty = 1000,
	lazy = false,
	opts = {
		flavour = "mocha",
		transparent_background = 0.9,
		show_end_of_buffer = true,
		highlight_overrides = {
			mocha = function(mocha)
				return {
					LineNr = { fg = mocha.subtext1 },
					LineNrAbove = { fg = mocha.overlay2 },
					LineNrBelow = { fg = mocha.overlay2 },
				}
			end,
		},
	},
	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
