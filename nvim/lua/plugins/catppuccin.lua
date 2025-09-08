return {
    "catppuccin/nvim",
    name = "catppuccin",
    prioroty = 1000,
    init = function()
        vim.cmd.colorscheme("catppuccin-macchiato")
    end,
    opts = {
        transparent_background = true,
        float = {
            transparent = true,
            solid = true,
        },
        styles = {
            comments = {},
        },
        highlight_overrides = {
            macchiato = function(mocha)
                return {
                    LineNr = { fg = mocha.subtext1 },
                    LineNrAbove = { fg = mocha.overlay2 },
                    LineNrBelow = { fg = mocha.overlay2 },
                }
            end,
        },
        integrations = {
            aerial = true,
            alpha = true,
            blink_cmp = true,
            diffview = true,
            dropbar = { enabled = true, color_mode = true },
            flash = true,
            gitsigns = true,
            illuminate = { enabled = true, lsp = false },
            lsp_trouble = true,
            mason = true,
            neotree = true,
            noice = true,
            notify = true,
            nvim_surround = true,
            snacks = { enabled = true, indent_scope_color = "pink" },
            telescope = { enabled = true },
            treesitter = true,
            treesitter_context = true,
            which_key = true,
        },
    },
}
