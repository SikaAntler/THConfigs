return {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
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
    },
}
