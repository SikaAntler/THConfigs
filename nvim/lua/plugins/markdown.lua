return {
    "MeanderingProgrammer/render-markdown.nvim",
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        heading = {
            icons = { " 󰼏 ", " 󰎨 ", " 󰼑 ", " 󰎲 ", " 󰼓 ", " 󰎴 " },
            render_modes = true,
        },
        code = {
            position = "right",
            width = "block",
            left_pad = 1,
            right_pad = 1,
            min_width = 100,
            border = "thin",
        },
        sign = { enabled = false },
    },
}
