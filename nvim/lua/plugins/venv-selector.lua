return {
	"linux-cultist/venv-selector.nvim",
	events = "VeryLazy",
	opts = function()
		local venv_selector = require("venv-selector")
		return {
			changed_venv_hooks = { venv_selector.hooks.pyright },
		}
	end,
	keys = {
		{ "<Space>vs", "<cmd>VenvSelect<CR>" },
	},
}
