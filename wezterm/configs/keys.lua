local action = require("wezterm").action

---@param mods string
---@param key string
---@param send string
---@return table
local function send_key(mods, key, send)
	return { mods = mods, key = key, action = action.SendKey({ key = send }) }
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
local function tmux(key)
	return {
		mods = "CTRL",
		key = key,
		action = action.Multiple({
			action.SendKey({ mods = "ALT", key = "m" }),
			action.SendKey({ key = key }),
		}),
	}
end

return {
	keys = {
		-- neovim
		sequence("CTRL", "/", "gccj"),
		send_key("CTRL", "`", "F5"),

		-- tmux
		tmux("1"),
		tmux("2"),
		tmux("3"),
		tmux("4"),
		tmux("5"),
		tmux("6"),
		tmux("7"),
		tmux("8"),
		tmux("9"),
	},
}
