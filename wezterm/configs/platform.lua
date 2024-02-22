local wezterm = require("wezterm")

return {
	is_win = wezterm.target_triple == "x86_64-pc-windows-msvc",
	is_macos = wezterm.target_triple == "aarch64-apple-darwin",
	is_linux = wezterm.target_triple == "x86_64-unknown-linux-gnu",
}
