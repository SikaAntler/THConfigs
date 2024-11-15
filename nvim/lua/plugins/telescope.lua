return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	keys = {
		{ "<Space>ff", "<Cmd>Telescope find_files<CR>" },
		{ "<Space>fg", "<Cmd>Telescope live_grep<CR>" },
		{ "<Space>fb", "<Cmd>Telescope buffers<CR>" },
        { "<Space>fo", "<Cmd>Telescope oldfiles<CR>"},
		{ "<Space>fd", "<Cmd>Telescope diagnostics<CR>" },
		{ "<Space>D", "<Cmd>Telescope lsp_type_definitions<CR>" },
		{ "gd", "<Cmd>Telescope lsp_definitions<CR>" },
		{ "gi", "<Cmd>Telescope lsp_implementations<CR>" },
		{ "gr", "<Cmd>Telescope lsp_references<CR>" },
	},
	config = function()
		require("configs.telescope")
	end,
}
