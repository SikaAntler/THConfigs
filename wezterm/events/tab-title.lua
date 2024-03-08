local wezterm = require("wezterm")

local colors = {
	-- Based on Mocha
	default = {
		bg = "#6c7086", -- Overlay 0
		fg = "#232634", -- Frappe Crust
	},
	active = {
		bg = "#cba6f7", -- Mauve
		fg = "#11111b", -- Crust
	},
	hover = {
		bg = "#b4befe", -- Lavender
		fg = "#181926", -- Macchiato Crust
	},
}

local function process_name(name)
	name = name:gsub("(.*[/\\])(.*)", "%2")
	name = name:gsub("%.exe$", "")
	name = name:gsub("%.EXE$", "")
	return name
end

local function tab_title(tab)
	local title
	if title and #title > 0 then
		title = tab.tab_title
	else
		title = tab.active_pane.title
		-- title = tab.active_pane.foreground_process_name
		-- title = tab.window_title
	end

	local index = tab.tab_index + 1
	title = process_name(title)

	return index .. ":" .. title
end

local function tab_has_unseen_output(panes)
	local has_unseen_output = false
	for _, pane in ipairs(panes) do
		if pane.has_unseen_output then
			has_unseen_output = true
			break
		end
	end
	return has_unseen_output
end

local tab_components

local function insert_tab_components(bg, fg, attr, text)
	table.insert(tab_components, { Background = { Color = bg } })
	table.insert(tab_components, { Foreground = { Color = fg } })
	table.insert(tab_components, { Attribute = attr })
	table.insert(tab_components, { Text = text })
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local left_bg = colors.active.fg
	local left_fg = colors.default.bg
	local background = colors.default.bg
	local foreground = colors.default.fg
	local right_bg = colors.active.fg
	local right_fg = colors.default.bg

	if tab.is_active then
		left_bg = colors.active.fg
		left_fg = colors.active.bg
		background = colors.active.bg
		foreground = colors.active.fg
		right_bg = colors.active.fg
		right_fg = colors.active.bg
	elseif hover then
		left_bg = colors.active.fg
		left_fg = colors.hover.bg
		background = colors.hover.bg
		foreground = colors.hover.fg
		right_bg = colors.active.fg
		right_fg = colors.hover.bg
	end

	local title = tab_title(tab)
	local has_unseen_output = tab_has_unseen_output(tab.panes)
	-- local offset = has_unseen_output and 4 or 3
	title = wezterm.truncate_right(title, max_width - 2)
	-- title = wezterm.truncate_right(title, config.tab_max_width - offset)

	tab_components = {}

	-- Left symbol
	insert_tab_components(left_bg, left_fg, { Intensity = "Bold" }, "")

	-- Title
	insert_tab_components(background, foreground, { Intensity = "Bold" }, title)

	-- Unseen output alert
	if has_unseen_output then
		insert_tab_components(background, "#ffa066", { Intensity = "Bold" }, " 🔔")
	end

	-- Right symbol
	insert_tab_components(right_bg, right_fg, { Intensity = "Bold" }, "")

	--  

	return tab_components
end)
