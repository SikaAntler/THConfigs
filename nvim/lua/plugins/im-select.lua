return {
    "keaising/im-select.nvim",
    enabled = function()
        return vim.fn.executable("macism") == 1
    end,
    event = "BufReadPre",
    opts = {
        default_im_select = "com.apple.keylayout.US",
    },
}
