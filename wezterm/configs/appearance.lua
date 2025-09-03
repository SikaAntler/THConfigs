local wezterm = require("wezterm")
local platform = require("configs.platform")

local WP = 7

return {
	-- Window
	window_decorations = platform.is_win and "INTEGRATED_BUTTONS|RESIZE" or "RESIZE",
	integrated_title_buttons = { "Hide", "Close" },
	window_background_opacity = platform.is_win and 1.0 or 0.9,
	macos_window_background_blur = 20,
	win32_system_backdrop = "Auto",
	adjust_window_size_when_changing_font_size = false,
	window_padding = { left = WP, right = WP, top = WP, bottom = WP },

	-- Font
	font_size = platform.is_win and 10 or 15,
	line_height = 1.15,
	font = wezterm.font_with_fallback({
		{ family = "Maple Mono NF CN", weight = "Light" },
		"JetBrains Mono",
	}),

	-- Color Scheme
	color_scheme = "Catppuccin Macchiato",

	-- Cursor
	default_cursor_style = "SteadyBar",

	-- Tab bar
	use_fancy_tab_bar = false,
	tab_max_width = platform.is_win and 35 or 25,
	hide_tab_bar_if_only_one_tab = true,
	show_new_tab_button_in_tab_bar = true,

	-- Scroll bar
	enable_scroll_bar = false,
}
