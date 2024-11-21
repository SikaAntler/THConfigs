return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			-- open_mapping = "<C-`>", -- tmux does not recognize this
			open_mapping = "<F5>",
			direction = "float",
		})
	end,
}
