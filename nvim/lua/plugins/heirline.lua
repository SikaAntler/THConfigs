return {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    config = function()
        require("heirline").setup({
            statusline = require("configs.heirline.statusline"),
            tabline = require("configs.heirline.tabline"),
        })
        vim.o.showtabline = 2
        vim.cmd(
            [[au FileType * if index(['wipe', 'delete'], &bufhidden) >=0 | set nobuflisted | endif]]
        )
    end,
}
