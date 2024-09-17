return {
	"stevearc/conform.nvim",
	-- event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<C-A-l>",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = { "n", "i" },
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			toml = { "taplo" },
		},
		-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
	},
}
