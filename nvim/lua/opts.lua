-- Clipboard
-- If using Neovim under SSH, using OSC 52
vim.opt.clipboard:append("unnamedplus")
-- if vim.fn.exists("$SSH_TTY") == 1 then
-- 	vim.g.clipboard = {
-- 		name = "OSC 52",
-- 		copy = {
-- 			["+"] = require("vim.ui.clipboard.osc52").copy("+"),
-- 			["*"] = require("vim.ui.clipboard.osc52").copy("*"),
-- 		},
-- 		paste = {
-- 			["+"] = require("vim.ui.clipboard.osc52").paste("+"),
-- 			["*"] = require("vim.ui.clipboard.osc52").paste("*"),
-- 		},
-- 	}
-- end

-- Mouse
vim.o.mouse = "a"

-- Char
vim.o.list = false

-- Cursor
vim.wo.cursorline = true

-- <Tab>
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.smartindent = true

-- Line
vim.o.number = true
-- vim.o.relativenumber = true
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
vim.o.wrap = true

-- Search
vim.o.incsearch = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

-- File
vim.o.encoding = "UTF-8"
vim.o.fileencoding = "UTF-8"
vim.o.autoread = true

-- Complete
-- vim.o.completeopt = 'menuone,preview'

-- Comments
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "r", "o" })
	end,
})
-- vim.o.formatoptions = vim.o.formatoptions:gsub('tc', '')

-- Virtual text
vim.o.virtualedit = "block"

-- Statusline
vim.opt.laststatus = 3
-- vim.o.cmdheight = 1

-- Bufferline
vim.opt.termguicolors = true
vim.opt.mousemoveevent = true
