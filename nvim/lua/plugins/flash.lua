return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        modes = {
            char = {
                enabled = false,
            },
        },
    },
    keys = {
        {
            "f",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
        },
        {
            "F",
            mode = { "n", "x", "o" },
            function()
                require("flash").treesitter()
            end,
        },
    },
}
