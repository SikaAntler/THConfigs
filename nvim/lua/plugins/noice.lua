return {
	"folke/noice.nvim",
	-- event = "VeryLazy",
	config = function()
		require("noice").setup({
			presets = {
				long_message_to_split = true,
				lsp_doc_border = true,
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
