return {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
        { "<Space>xx", "<Cmd>Trouble diagnostics toggle<CR>" },
        { "<Space>xX", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>" },
    },
}
