local components = require("configs.heirline.components")
local icons = require("utils.icons")
local palette = require("catppuccin.palettes").get_palette("macchiato")
local utils = require("heirline.utils")

local NeoTreeOffset = {
	condition = function(self)
		local win = vim.api.nvim_tabpage_list_wins(0)[1]
		local bufnr = vim.api.nvim_win_get_buf(win)
		self.winid = win

		if vim.bo[bufnr].filetype == "neo-tree" then
			self.title = " Project"
			return true
		end
	end,
	provider = function(self)
		local title = self.title
		local width = vim.api.nvim_win_get_width(self.winid)
		return title .. string.rep(" ", width - #title)
	end,
	hl = function()
		return "Directory"
	end,
}

local FileName = {
	provider = function(self)
		local fname = self.filename
		fname = fname == "" and "[No Name]" or vim.fn.fnamemodify(fname, ":t")
		return fname
	end,
	hl = function(self)
		if self.is_active then
			return { fg = palette.text, bold = true }
		else
			return { fg = palette.overlay1, italic = true }
		end
	end,
}

local FileFlags = {
	{
		condition = function(self)
			return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
		end,
		provider = " " .. icons.modified_dot,
		hl = function(self)
			if self.is_active then
				return { fg = palette.text, bold = true }
			else
				return { fg = palette.overlay1, italic = true }
			end
		end,
	},
	{
		condition = function(self)
			local modifiable = vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
			local readonly = vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
			return not modifiable or readonly
		end,
		provider = function(self)
			if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
				return " " .. icons.terminal
			else
				return " " .. icons.readonly
			end
		end,
		hl = { fg = palette.text },
	},
}

local FileNameBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(self.bufnr)
	end,
	on_click = {
		callback = function(_, minwid, _, button)
			if button == "m" then
				vim.schedule(function()
					require("bufdelete").bufdelete(minwid)
				end)
			else
				vim.api.nvim_win_set_buf(0, minwid)
			end
		end,
		minwid = function(self)
			return self.bufnr
		end,
		name = "heirline_tabline_buffer_callback",
	},
	components.FileIcon,
	FileName,
	FileFlags,
}

local CloseButton = {
	condition = function(self)
		return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
	end,
	provider = " " .. icons.close,
	hl = function(self)
		if self.is_active then
			return { fg = palette.text, bold = true }
		else
			return { fg = palette.overlay1, italic = true }
		end
	end,
	on_click = {
		callback = function(_, minwid)
			vim.schedule(function()
				require("bufdelete").bufdelete(minwid)
				-- vim.cmd.redrawtabline()
			end)
		end,
		minwid = function(self)
			return self.bufnr
		end,
		name = "heirline_tabline_close_buffer_callback",
	},
}

local BufferBlock = {
	components.Spacer,
	FileNameBlock,
	CloseButton,
	components.Spacer,
}

local BufferLine = utils.make_buflist(
	BufferBlock,
	{ provider = "", hl = { fg = palette.overlay0 } },
	{ provider = "", hl = { fg = palette.overlay0 } }
)

local Page = {
	provider = function(self)
		return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
	end,
	hl = function(self)
		if not self.is_active then
			return "TabLine"
		else
			return "TabLineSel"
		end
	end,
}

local PageClose = {
	provider = "%999X  ✗%X",
	hl = "TabLine",
}

local TabPages = {
	condition = function()
		return #vim.api.nvim_list_tabpages() >= 2
	end,
	components.Fill,
	utils.make_tablist(Page),
	PageClose,
}

return { NeoTreeOffset, BufferLine, TabPages }
