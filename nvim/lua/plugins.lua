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
	-- Core
	require("plugins.catppuccin"), -- theme
	require("plugins.lsp"),
	require("plugins.completion"),
	require("plugins.conform"),
	require("plugins.treesitter"),
	-- Layout
	require("plugins.aerial"),
	require("plugins.alpha"),
	-- require("plugins.dashboard"),
	require("plugins.dropbar"),
	require("plugins.fold"),
	require("plugins.heirline"),
	require("plugins.gitsigns"),
	require("plugins.neo-tree"),
	-- require("plugins.bufferline"),
	-- "echasnovski/mini.bufremove",
	-- require("plugins.lualine"),
	-- Coding
	require("plugins.comment"),
	require("plugins.diffview"),
	require("plugins.hlchunk"),
	require("plugins.illunimate"),
	require("plugins.pairs"),
	require("plugins.telescope"),
	require("plugins.toggleterm"),
	require("plugins.trouble"),
	require("plugins.venv-selector"),
	-- Utils
	require("plugins.bufdelete"),
	require("plugins.dressing"), -- float window
	require("plugins.image"),
	require("plugins.lazydev"),
	require("plugins.neoscroll"),
	require("plugins.noice"),
	require("plugins.notify"),
	require("plugins.which-key"),
	-- "mfussenegger/nvim-lint",
	-- Dependencies
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"MunifTanjim/nui.nvim",
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
