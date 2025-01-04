require("neo-tree").setup({
	close_if_last_window = true,
	enable_git_status = true,
	enable_diagnostics = true,
	sort_case_insensitive = true,
	default_component_configs = {
		-- modified = { symbol = icons.modified_square, highlight = palette.text },
		modified = { symbol = "" },
		git_status = {
			symbols = {
				-- Change type
				added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "✖", -- this can only be used in the git_status source
				renamed = "󰁕", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
		},
	},
	window = {
		mappings = {
			["<Tab>"] = function(state)
				local node = state.tree:get_node()
				if require("neo-tree.utils").is_expandable(node) then
					state.commands["toggle_node"](state)
				else
					state.commands["open"](state)
					vim.cmd("Neotree")
				end
			end,
		},
	},
	filesystem = {
		use_libuv_file_watcher = true,
		filtered_items = {
			hide_gitignored = false,
		},
	},
})
