return {
	"rebelot/heirline.nvim",
	event = "VeryLazy",
	config = function()
		require("heirline").setup({
			statusline = require("configs.heirline.statusline"),
		})
	end,
}
