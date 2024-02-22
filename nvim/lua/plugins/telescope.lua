return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	cmd = "Telescope",
	keys = {
		{ "<Space>ff", "<cmd>Telescope find_files<CR>" },
		{ "<Space>fg", "<cmd>Telescope live_grep<CR>" },
		{ "<Space>fb", "<cmd>Telescope buffers<CR>" },
		{ "<Space>fh", "<cmd>Telescope help_tags<CR>" },
	},
}
