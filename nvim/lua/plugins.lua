-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

require("lazy").setup({
	require("plugins.lsp"), -- LSP
	require("plugins.completion"), -- completion
	-- UI
	require("plugins.catppuccin"), -- theme
	-- require("plugins.lualine"), -- bottom status line
	require("plugins.heirline"),
	require("plugins.dashboard"), -- startup page
	require("plugins.dressing"), -- float window
	require("plugins.noice"),
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
	-- require("plugins.bufferline"), -- use ide-like tabs
	-- "echasnovski/mini.bufremove", --  keep layout when close tab on bufferline
	require("plugins.gitsigns"),
	require("plugins.treesitter"),
	require("plugins.toggleterm"),
	require("plugins.which-key"),
	require("plugins.neoscroll"),
	require("plugins.dropbar"),
	require("plugins.diffview"),
	require("plugins.bufdelete"),
	-- Utils
	require("plugins.lazydev"),
	"nvim-lua/plenary.nvim", -- useful functions library
	"nvim-tree/nvim-web-devicons",
	"MunifTanjim/nui.nvim",
	-- "mfussenegger/nvim-lint",
})

-- Linter
-- require("lint").linters_by_ft = { lua = { "cspell" } }
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	callback = function()
-- 		require("lint").try_lint()
-- 	end,
-- })

-- QML
-- vim.cmd("au BufRead,BufNewFile *.qml setfiletype qmljs")
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.qml",
	command = "setfiletype qmljs",
})
