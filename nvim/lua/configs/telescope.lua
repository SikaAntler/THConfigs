local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        -- sorting_strategy = "ascending",
        mappings = {
            i = {
                ["<Esc>"] = actions.close,
            },
        },
    },
})

if vim.fn.executable("make") == 1 then
    require("telescope").load_extension("fzf")
end

require("telescope").load_extension("live_grep_args")
