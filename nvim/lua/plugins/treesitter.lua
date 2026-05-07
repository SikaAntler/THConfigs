return {
    "neovim-treesitter/nvim-treesitter",
    dependencies = { "neovim-treesitter/treesitter-parser-registry" },
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
