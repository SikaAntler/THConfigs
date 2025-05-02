-- stylua: ignore start
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- stylua: ignore end

require("lazy").setup({
    -- Core
    require("plugins.catppuccin"),
    require("plugins.lsp"),
    require("plugins.blink"),
    require("plugins.conform"),
    require("plugins.treesitter"),
    -- Layout
    require("plugins.aerial"),
    require("plugins.alpha"),
    require("plugins.dropbar"),
    require("plugins.heirline"),
    require("plugins.gitsigns"),
    require("plugins.neo-tree"),
    require("plugins.statuscol"),
    -- Coding
    require("plugins.colorizer"),
    require("plugins.diffview"),
    require("plugins.flash"),
    require("plugins.illunimate"),
    require("plugins.oil"),
    require("plugins.pairs"),
    require("plugins.surround"),
    require("plugins.symbol-usage"),
    require("plugins.telescope"),
    require("plugins.toggleterm"),
    require("plugins.trouble"),
    -- Utils
    require("plugins.bufdelete"),
    require("plugins.im-select"),
    require("plugins.kitty"),
    require("plugins.lazydev"),
    require("plugins.neoscroll"),
    require("plugins.noice"),
    require("plugins.notify"),
    require("plugins.snacks"),
    require("plugins.which-key"),
    -- Dependencies
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
})
