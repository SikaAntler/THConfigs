-- return {
--     "brenoprata10/nvim-highlight-colors",
--     event = "VeryLazy",
--     opts = {},
-- }

return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        user_default_options = {
            names = false,
            RRGGBBAA = true,
            AARRGGBB = true,
        },
    },
}
