return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "bash",
            "cmake",
            "cpp",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "qmljs",
            "xml",
            "yaml",
        },
        auto_install = true,
        highlight = { enable = true },
    },
}
