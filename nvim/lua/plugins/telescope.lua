return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	keys = {
		{ "<Space>ff", "<Cmd>Telescope find_files<CR>" },
		{ "<Space>fg", "<Cmd>Telescope live_grep<CR>" },
		{ "<Space>fb", "<Cmd>Telescope buffers<CR>" },
		{ "<Space>fd", "<Cmd>Telescope diagnostics<CR>" },
	},
	config = function()
		require("configs.telescope")
	end,
}
