local function is_available(name, bufnr)
    return require("conform").get_formatter_info(name, bufnr).available
end

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
            cmake = { "gersemi" },
            cpp = { "clang-format" },
            json = { "jq" },
            lua = { "stylua" },
            python = function(bufnr)
                if
                    is_available("ruff_format", bufnr)
                    and is_available("ruff_organize_imports", bufnr)
                then
                    return { "ruff_format", "ruff_organize_imports" }
                else
                    return { "isort", "black" }
                end
            end,
            toml = { "taplo" },
            yaml = { "yamlfmt" },
        },
        formatters = {
            jq = { args = { "--indent", "2" } },
            yamlfmt = { args = { "-formatter", "retain_line_breaks_single=true", "-" } },
        },
    },
}
