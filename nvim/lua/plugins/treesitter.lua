return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            ensure_installed = {
                "bash",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "qmldir",
                "qmljs",
                "yaml",
            },
            auto_install = true,
            highlight = { enable = true },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
    },
}
