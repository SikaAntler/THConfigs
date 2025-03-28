return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "<Space>?",
            function()
                require("which-key").show({ global = false })
            end,
        },
    },
}
