return {
    "kevinhwang91/nvim-ufo",
    -- event = "BufEnter",
    dependencies = {
        "kevinhwang91/promise-async",
        {
            "luukvbaal/statuscol.nvim",
            config = function()
                local builtin = require("statuscol.builtin")
                local ft_ignore = { "alpha", "dashboard", "neo-tree" }
                require("statuscol").setup({
                    ft_ignore = ft_ignore,
                    segments = {
                        { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
                        { text = { "%s" }, click = "v:lua.ScSa" },
                        {
                            text = { builtin.lnumfunc, " " },
                            condition = { true, builtin.not_empty },
                            click = "v:lua.ScLa",
                        },
                    },
                })
                vim.api.nvim_create_autocmd("BufEnter", { -- FileType does not work for neo-tree
                    callback = function()
                        if vim.tbl_contains(ft_ignore, vim.bo.filetype) then
                            vim.opt_local.foldcolumn = "0"
                            vim.opt_local.foldenable = false
                        end
                    end,
                })
            end,
        },
    },
    config = function()
        require("configs.fold")
    end,
}
