return {
	"folke/noice.nvim",
	event = "VeryLazy",
	config = function()
		require("noice").setup({
			presets = {
				command_palette = false,
			},
			messages = {
				enabled = true,
			},
			popupmenu = {
				enabled = false,
			},
			lsp = {
				signature = {
					enabled = true,
				},
				progress = {
					enabled = true,
				},
				hover = {
					enabled = false,
				},
			},
		})
	end,
}
