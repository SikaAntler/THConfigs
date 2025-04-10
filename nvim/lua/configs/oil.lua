function _G.get_oil_winbar()
    local bnfnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = require("oil").get_current_dir(bnfnr)
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        return vim.api.nvim_buf_get_name(0)
    end
end

---@module "oil"
---@type oil.SetupOpts
local opts = {
    default_file_explorer = true,
    columns = { "icon" },
    win_options = {
        winbar = "%!v:lua.get_oil_winbar()",
    },
    keymaps = {
        ["-"] = "actions.close",
        ["<BS>"] = "actions.parent",
    },
    use_default_keymaps = true,
}

require("oil").setup(opts)

vim.keymap.set("n", "-", "<Cmd>Oil<CR>")
