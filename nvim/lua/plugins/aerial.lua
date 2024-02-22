return {
	"stevearc/aerial.nvim",
	opts = {
		backends = { "lsp" },

		show_guide = true,
	},
	keys = {
		{ "<Space>cs", "<cmd>AerialToggle<CR>" },
	},
}
