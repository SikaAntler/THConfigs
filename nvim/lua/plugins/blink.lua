return {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            event = "VeryLazy",
            dependencies = {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_lua").load({
                        paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
                    })
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
    },

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
        sources = { default = { "snippets", "path", "lsp", "buffer" } },
        snippets = { preset = "luasnip" },
    },
}
