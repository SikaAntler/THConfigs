return {
    "stevearc/conform.nvim",
    keys = {
        {
            "<C-A-l>",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = { "n", "i" },
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            cpp = { "clang-format" },
            json = { "jq" },
            lua = { "stylua" },
            python = { "isort", "black" },
            toml = { "taplo" },
            yaml = { "yamlfmt" },
        },
        formatters = {
            yamlfmt = { args = { "-formatter", "retain_line_breaks_single=true", "-" } },
        },
    },
}
