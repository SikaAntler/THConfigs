return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	keys = {
		{ "<Space>fe", "<Cmd>Neotree source=filesystem reveal=true position=left<CR>" },
	},
	config = function()
		require("configs.neo-tree")
	end,
}
