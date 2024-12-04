local dashboard = require("alpha.themes.dashboard")

local logo = {
	[[┌─────────────────────────────────────────────────────────────┐]],
	[[│┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐│]],
	[[││󱊷  │! 1│@ 2│# 3│$ 4│% 5│^ 6│& 7│* 8│( 9│) 0│_ -│+ =│| \│~ `││]],
	[[│├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴───┤│]],
	[[││󰌒    │ Q │ W │ E │ R │ T │ Y │ U │ I │ O │ P │{ [│} ]│   󰌍 ││]],
	[[│├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤│]],
	[[││󰘴     │ A │ S │ D │ F │ G │ H │ J │ K │ L │: ;│" '│      󰌑 ││]],
	[[│├──────┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴────┬───┤│]],
	[[││󰘶       │ Z │ X │ C │ V │ B │ N │ M │< ,│> .│? /│    󰘶 │ Fn││]],
	[[│└─────┬──┴┬──┴──┬┴───┴───┴───┴───┴───┴──┬┴───┴┬──┴┬─────┴───┘│]],
	[[│ HHKB │ 󰘵 │  󰘳  │           󱁐           │  󰘳  │ 󰘵 │  Type-S  │]],
	[[│      └───┴─────┴───────────────────────┴─────┴───┘          │]],
	[[└─────────────────────────────────────────────────────────────┘]],
	[[                仙之巅，傲世间，先有键盘后有天                 ]],
	[[                天不生我键盘侠，喷道万古如长夜                 ]],
}

dashboard.section.header.val = {}

local height = vim.api.nvim_win_get_height(0) - 8
height = math.floor(height / 2)
height = math.floor((height - #logo) / 2)
for _ = 1, height do
	table.insert(dashboard.section.header.val, "")
end
for _, value in ipairs(logo) do
	table.insert(dashboard.section.header.val, value)
end
for _ = 1, height do
	table.insert(dashboard.section.header.val, "")
end

dashboard.section.header.opts.hl = "Title"

dashboard.section.buttons.val = {
	dashboard.button("󱁐  e", "󰙅  Explorer"),
	dashboard.button("󱁐  f f", "󰈞  Find File"),
	dashboard.button("󱁐  f w", "󰈬  Find Word"),
	dashboard.button("󱁐  f o", "󰈢  Find Opened"),
	dashboard.button("q", "󰈆  Quit Neovim", "<Cmd>q<CR>"),
}

require("alpha").setup(dashboard.opts)
