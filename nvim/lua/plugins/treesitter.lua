return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	build = ":TSUpdate",
	-- cmd = {'TSUpdateSync', 'TSUpdate', 'TSInstall'},
	opts = {
		ensure_installed = { "lua", "python", "qmldir", "qmljs" },
		highlight = { enable = true },
	},
	config = function(_, opts)
		if type(opts.ensure_installed) == "table" then
			---@type table<string, boolean>
			local added = {}
			opts.ensure_installed = vim.tbl_filter(function(lang)
				if added[lang] then
					return false
				end
				added[lang] = true
				return true
			end, opts.ensure_installed)
		end
		require("nvim-treesitter.configs").setup(opts)
	end,
}
