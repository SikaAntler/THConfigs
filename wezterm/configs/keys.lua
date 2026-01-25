local action = require("wezterm").action

---@param mods1 string|nil
---@param key1 string
---@param mods2 string|nil
---@param key2 string
---@return table
local function map(mods1, key1, mods2, key2)
	return {
		mods = mods1,
		key = key1,
		action = action.SendKey({ mods = mods2, key = key2 }),
	}
end

---@param mods string
---@param key string
---@param seq string
---@return table
local function sequence(mods, key, seq)
	local actions = {}
	for c in seq:gmatch(".") do
		table.insert(actions, action.SendKey({ key = c }))
	end
	return { mods = mods, key = key, action = action.Multiple(actions) }
end

---@param key string
---@return table
local function tmux_new_window(key)
	return {
		mods = "ALT",
		key = key,
		action = action.Multiple({
			action.SendKey({ mods = "ALT", key = "m" }),
			action.SendKey({ key = "c" }),
		}),
	}
end

---@param key string
---@return table
local function tmux_select_window(key)
	return {
		mods = "ALT",
		key = key,
		action = action.Multiple({
			action.SendKey({ mods = "ALT", key = "m" }),
			action.SendKey({ key = key }),
		}),
	}
end

---@param key1 string
---@param key2 string
---@return table
local function tmux_select_pane(key1, key2)
	return map("ALT|SHIFT", key1, "ALT|SHIFT", key2)
end

-- ---@param mods string|nil
-- ---@param key string
-- local function disable(mods, key)
-- 	return {
-- 		mods = mods,
-- 		key = key,
-- 		action = action.DisableDefaultAssignment,
-- 	}
-- end

---@param key integer
local function wezterm_activate_tab(key)
	return {
		mods = "CTRL",
		key = tostring(key),
		action = action.ActivateTab(key - 1),
	}
end

return {
	keys = {
		-- neovim
		map("CTRL", "`", nil, "F5"),
		sequence("CTRL", "/", "gccj"),

		-- tmux
		tmux_new_window("t"),
		tmux_select_window("1"),
		tmux_select_window("2"),
		tmux_select_window("3"),
		tmux_select_window("4"),
		tmux_select_window("5"),
		tmux_select_window("6"),
		tmux_select_window("7"),
		tmux_select_window("8"),
		tmux_select_window("9"),
		tmux_select_pane("h", "LeftArrow"),
		tmux_select_pane("j", "DownArrow"),
		tmux_select_pane("k", "UpArrow"),
		tmux_select_pane("l", "RightArrow"),

		-- wezterm
		wezterm_activate_tab(1),
		wezterm_activate_tab(2),
		wezterm_activate_tab(3),
		wezterm_activate_tab(4),
		wezterm_activate_tab(5),
		wezterm_activate_tab(6),
		wezterm_activate_tab(7),
		wezterm_activate_tab(8),
		wezterm_activate_tab(9),
	},
}
