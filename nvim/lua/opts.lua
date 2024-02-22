-- Clipboard
vim.o.clipboard = "unnamedplus"

-- Mouse
vim.o.mouse = "a"

-- Char
vim.o.list = false

-- Cursor
vim.wo.cursorline = true

-- Tab
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.smartindent = true

-- Line
vim.o.number = true
vim.o.relativenumber = true
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
