return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	-- init = function()
	-- 	vim.g.lualine_laststatus = vim.o.laststatus
	-- 	if vim.fn.argc(-1) > 0 then
	-- 		vim.o.statusline = " "
	-- 	else
	-- 		vim.o.laststatus = 0
	-- 	end
	-- end,
	opts = function()
		local utils_python = require("utils.python")

		-- vim.o.laststatus = vim.g.lualine_laststatus

		return {
			-- +-------------------------------------------------+
			-- | A | B | C                             X | Y | Z |
			-- +-------------------------------------------------+
			options = {
				icons_enabled = true,
				theme = "auto",
				disabled_filetypes = { statusline = { "dashboard" } },
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename", "filesize" },
				lualine_x = { "encoding", "filetype", utils_python.python_env },
				lualine_y = { "progress" },
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = { "lazy", "mason", "neo-tree", "trouble" },
		}
	end,
}
