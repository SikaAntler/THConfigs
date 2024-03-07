-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Mason
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"mfussenegger/nvim-lint",
	-- Complete
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
	},
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"onsails/lspkind.nvim",
	-- UI
	require("plugins.catppuccin"), -- theme
	require("plugins.lualine"), -- bottom status line
	require("plugins.dashboard"), -- startup page
	require("plugins.dressing"), -- float window
	-- Utils
	-- "nvim-lua/plenary.nvim", -- useful functions library
	require("plugins.conform"), -- reformat codes
	require("plugins.pairs"), -- pairs for (),[],{}...
	require("plugins.comment"), -- switch comment/code for quick
	require("plugins.illunimate"), -- highlight for same things
	require("plugins.hlchunk"), -- show code fields
	require("plugins.neo-tree"), -- file explorer
	require("plugins.trouble"), -- make issues more clarified
	require("plugins.aerial"), -- class/function/variables outlines
	require("plugins.telescope"), -- fuzzy search for files
	require("plugins.venv-selector"), -- select python venv inside neovim
	require("plugins.bufferline"), -- use ide-like tabs
	"echasnovski/mini.bufremove", --  keep layout when close tab on bufferline
	require("plugins.gitsigns"),
})

-- Mason
require("mason").setup()

-- LSP
require("plugins.lsp")

-- Complete
require("plugins.nvim-cmp")

-- Linter
-- require("lint").linters_by_ft = { lua = { "cspell" } }
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	callback = function()
-- 		require("lint").try_lint()
-- 	end,
-- })
