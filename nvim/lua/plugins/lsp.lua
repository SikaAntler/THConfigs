return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{
			"williamboman/mason.nvim",
			event = "VeryLazy",
			config = true,
		},
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		require("configs.lsp")
	end,
}
