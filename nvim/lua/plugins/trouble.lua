return {
	"folke/trouble.nvim",
	dependences = { "nvim-tree/nvim-web-devicons" },
	cmd = { "TroubleToggle", "Trouble" },
	opts = { use_diagnostic_signs = true },
	keys = {
		{ "<Space>xx", "<cmd>TroubleToggle document_diagnostics<CR>" },
		{ "<Space>xX", "<cmd>TroubleToggle workspace_diagnostics<CR>" },
		{ "<Space>xL", "<cmd>TroubleToggle loclist<CR>" },
		{ "<Space>xQ", "<cmd>TroubleToggle quickfix<CR>" },
	},
}
