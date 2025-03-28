return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    keys = {
        { "<Space>ff", "<Cmd>Telescope find_files<CR>" },
        { "<Space>fw", "<Cmd>Telescope live_grep_args<CR>" },
        { "<Space>fb", "<Cmd>Telescope buffers<CR>" },
        { "<Space>fo", "<Cmd>Telescope oldfiles<CR>" },
        { "<Space>fd", "<Cmd>Telescope diagnostics<CR>" },
        { "<Space>fk", "<Cmd>Telescope keymaps<CR>" },
        { "<Space>fr", "<Cmd>Telescope resume<CR>" },
        { "<Space>D", "<Cmd>Telescope lsp_type_definitions<CR>" },
        { "gd", "<Cmd>Telescope lsp_definitions<CR>" },
        { "gi", "<Cmd>Telescope lsp_implementations<CR>" },
        { "gr", "<Cmd>Telescope lsp_references<CR>" },
    },
    config = function()
        require("configs.telescope")
    end,
}
