return {
	"linux-cultist/venv-selector.nvim",
	-- dependencies = { "neovim/nvim-lspconfig" },
	lazy = false,
	branch = "regexp",
	config = function()
		-- local utils_python = require("utils.python")
		require("venv-selector").setup({
			-- anaconda_base_path = "~/miniconda3",
			-- anaconda_envs_path = "~/miniconda3/envs",
			stay_on_this_version = true,
			-- settings = {
			-- 	options = {
			-- 		notify_user_on_venv_activation = true,
			-- 	},
			-- },
		})
	end,
	keys = {
		{ "<leader>vs", "<Cmd>VenvSelect<CR>" },
		{ "<leader>vc", "<Cmd>VenvSelectCached<CR>" },
	},
}
