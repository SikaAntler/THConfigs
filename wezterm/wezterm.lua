local wezterm = require("wezterm")

local config = wezterm.config_builder()

local function append(opts)
	for k, v in pairs(opts) do
		config[k] = v
	end
end

append(require("configs.shell"))
append(require("configs.appearance"))
append(require("configs.keys"))
require("events.tab-title")

return config
