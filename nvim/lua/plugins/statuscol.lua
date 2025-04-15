return {
    "luukvbaal/statuscol.nvim",
    config = function()
        local ft_ignore = { "alpha", "neo-tree" }
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            ft_ignore = ft_ignore,
            segments = {
                { text = { "%s" }, click = "v:lua.ScSa" },
                { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                {
                    text = { builtin.lnumfunc, " " },
                    condition = { true, builtin.not_empty },
                    click = "v:lua.ScLa",
                },
            },
        })
        vim.api.nvim_create_autocmd("BufEnter", {
            callback = function()
                if vim.tbl_contains(ft_ignore, vim.bo.filetype) then
                    vim.opt_local.foldcolumn = "0"
                    vim.opt_local.foldenable = false
                end
            end,
        })
        -- FileType does not work
        -- vim.api.nvim_create_autocmd("FileType", {
        --     pattern = "neo-tree",
        --     callback = function()
        --         vim.opt_local.foldcolumn = "0"
        --         vim.opt_local.foldenable = false
        --     end,
        -- })
    end,
}
