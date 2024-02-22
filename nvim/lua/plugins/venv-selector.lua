return {
	"linux-cultist/venv-selector.nvim",
	events = "VeryLazy",
	opts = function()
		local venv_selector = require("venv-selector")
		local utils_python = require("utils.python")
		return {
			changed_venv_hooks = { venv_selector.hooks.pyright, utils_python.venv_changed },
		}
	end,
	keys = {
		{ "<Space>vs", "<cmd>VenvSelect<CR>" },
	},
}
