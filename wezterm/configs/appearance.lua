local wezterm = require("wezterm")
local platform = require("configs.platform")

return {
	-- Window
	window_decorations = platform.is_win and "INTEGRATED_BUTTONS|RESIZE" or "RESIZE",
	integrated_title_buttons = { "Hide", "Close" },
	window_background_opacity = platform.is_win and 1.0 or 0.9,
	text_background_opacity = 0.8,
	macos_window_background_blur = 20,
	win32_system_backdrop = "Auto",
	adjust_window_size_when_changing_font_size = false,
	window_padding = { left = 5, right = 10, top = 12, bottom = 7 },

	-- Font
	font_size = platform.is_win and 10.5 or 15,
	line_height = 1.2,
	font = wezterm.font_with_fallback({
		"Maple Mono NF CN",
		"JetBrains Mono",
	}),
	-- freetype_load_flags = "NO_HINTING"
	freetype_load_target = "Normal",
	color_scheme = "Catppuccin Macchiato",

	-- Cursor
	default_cursor_style = "SteadyBar",
	-- cursor_blink_rate = 300
	-- visual_bell = {
	-- 	fade_in_function = "EaseIn",
	-- 	fade_in_duration_ms = 250,
	-- 	fade_out_function = "EaseOut",
	-- 	fade_out_duration_ms = 250,
	-- 	target = "CursorColor",
	-- }

	-- Tab bar
	use_fancy_tab_bar = false,
	tab_max_width = platform.is_win and 35 or 25,
	hide_tab_bar_if_only_one_tab = true,
	show_new_tab_button_in_tab_bar = true,

	-- Scroll bar
	enable_scroll_bar = false,
}
