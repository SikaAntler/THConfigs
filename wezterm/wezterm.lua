local wezterm = require("wezterm")

local cfg = wezterm.config_builder()

local function append(opts)
	for k, v in pairs(opts) do
		cfg[k] = v
	end
end

append(require("configs.shell"))
append(require("configs.appearance"))
require("events.tab-title")

return cfg
