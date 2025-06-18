return {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "BufReadPost", "BufNewFile" },

    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
        appearance = { nerd_font_variant = "normal" },
        completion = {
            menu = {
                draw = {
                    columns = {
                        { "kind_icon" },
                        { "label", "label_description", gap = 1 },
                        { "kind" },
                    },
                },
                scrollbar = false,
            },
            documentation = {
                auto_show = true,
                window = { border = "rounded" },
            },
        },
        keymap = {
            preset = "super-tab",
            ["<C-u>"] = { "scroll_documentation_up" },
            ["<C-d>"] = { "scroll_documentation_down" },
        },
        signature = {
            enabled = true,
            window = {
                border = "rounded",
            },
        },
        sources = {
            default = { "snippets", "path", "lsp", "buffer" },
            providers = {
                snippets = { score_offset = 4 },
                path = { score_offset = 3 },
                lsp = { score_offset = 2 },
                buffer = { score_offset = 1 },
            },
        },
    },
}
