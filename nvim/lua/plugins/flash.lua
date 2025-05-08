return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "ss",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
        },
        {
            "SS",
            mode = { "n", "x", "o" },
            function()
                require("flash").treesitter()
            end,
        },
    },
}
