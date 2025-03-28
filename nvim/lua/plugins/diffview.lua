return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
        { "<Space>do", "<Cmd>DiffviewOpen<CR>" },
        { "<Space>dc", "<Cmd>DiffviewClose<CR>" },
        { "<Space>dh", "<Cmd>DiffviewFileHistory %<CR>" },
    },
}
