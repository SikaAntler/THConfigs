return {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
        dashboard = {
            enabled = true,
            preset = {
                header = [[
┌─────────────────────────────────────────────────────────────┐
│┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐│
││󱊷  │! 1│@ 2│# 3│$ 4│% 5│^ 6│& 7│* 8│( 9│) 0│_ -│+ =│| \│~ `││
│├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴───┤│
││󰌒    │ Q │ W │ E │ R │ T │ Y │ U │ I │ O │ P │{ [│} ]│   󰌍 ││
│├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤│
││󰘴     │ A │ S │ D │ F │ G │ H │ J │ K │ L │: ;│" '│      󰌑 ││
│├──────┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴────┬───┤│
││󰘶       │ Z │ X │ C │ V │ B │ N │ M │< ,│> .│? /│    󰘶 │ Fn││
│└─────┬──┴┬──┴──┬┴───┴───┴───┴───┴───┴──┬┴───┴┬──┴┬─────┴───┘│
│ HHKB │ 󰘵 │  󰘳  │           󱁐           │  󰘳  │ 󰘵 │  Type-S  │
│      └───┴─────┴───────────────────────┴─────┴───┘          │
└─────────────────────────────────────────────────────────────┘
                仙之巅，傲世间，先有键盘后有天                 
                天不生我键盘侠，喷道万古如长夜                 
]],
                keys = {
                    { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
                    { icon = " ", key = "M", desc = "Mason", action = ":Mason" },
                    { icon = "󰈆 ", key = "q", desc = "Quit", action = ":q" },
                },
            },
        },
        image = { enabled = true },
        indent = {
            enabled = true,
            animate = {
                duration = { step = 5 },
            },
        },
        picker = {
            win = {
                input = {
                    keys = {
                        ["<Esc>"] = { "close", mode = { "n", "i" } },
                    },
                },
            },
        },
    },
    keys = {
        {
            "<Space>ff",
            function()
                require("snacks").picker.files()
            end,
        },
        {
            "<Space>fo",
            function()
                require("snacks").picker.recent()
            end,
        },
        {
            "<Space>fe",
            function()
                require("snacks").picker.explorer()
            end,
        },
        {
            "<Space>fw",
            function()
                require("snacks").picker.grep()
            end,
        },
        {
            "<Space>fr",
            function()
                require("snacks").picker.resume()
            end,
        },
        {
            "<Space><Space>",
            function()
                require("snacks").picker.buffers()
            end,
        },
        {
            "<Space>fh",
            function()
                require("snacks").picker.help({ layout = "dropdown" })
            end,
        },
        {
            "<Space>bd",
            function()
                require("snacks").bufdelete()
            end,
        },
    },
}
