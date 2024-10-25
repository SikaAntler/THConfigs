local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local palette = require("catppuccin.palettes").get_palette("macchiato")
local M = {}

M.Spacer = { provider = " " }
M.Fill = { provider = "%=" }
M.Ruler = { provider = "%(%l%):%c %(%P%)" }

-- ╭───────────────────────────────────────────╮
-- │                Statusline                 │
-- ╰───────────────────────────────────────────╯

M.RightPadding = function(child, space)
	local result = {
		condition = child.condition,
		child,
		M.Spacer,
	}
	if space ~= nil then
		for _ = 2, space do
			table.insert(result, M.Spacer)
		end
	end
	return result
end

M.Mode = {
	init = function(self)
		self.mode = vim.fn.mode(1)
	end,
	static = {
		mode_names = {
			n = "NORMAL",
			no = "?",
			nov = "?",
			noV = "?",
			["no\22"] = "?",
			niI = "INSERT",
			niR = "REPLACE",
			niV = "VISUAL",
			nt = "TERMINAL",
			ntT = "TERMINAL",
			v = "VISUAL",
			vs = "VISUAL",
			V = "V-LINE",
			Vs = "V-LINE",
			["\22"] = "V-BLOCK",
			["\22s"] = "V-BLOCK",
			s = "SELECT",
			S = "S-LINE",
			["\19"] = "S-BLOCK",
			i = "INSERT",
			ic = "INSERT-C",
			ix = "INSERT-X",
			R = "REPLACE",
			Rc = "REPLACE-C",
			Rx = "REPLACE-X",
			Rv = "REPLACE-V",
			Rvc = "REPLACE-VC",
			Rvx = "REPLACE-VX",
			c = "COMMAND",
			cr = "COMMAND-R",
			cv = "COMMAND-V",
			cvr = "COMMAND-VR",
			r = "R",
			rm = "RM",
			["r?"] = "R?",
			["!"] = "!",
			t = "TERMINAL",
		},
		mode_colors = {
			n = palette.blue,
			nt = palette.read,
			v = palette.mauve,
			V = palette.mauve,
			["\22"] = palette.mauve,
			s = palette.pink,
			S = palette.pink,
			["\19"] = palette.pink,
			i = palette.green,
			R = palette.peach,
			r = palette.peach,
			c = palette.red,
			["!"] = palette.red,
			t = palette.green,
		},
	},
	provider = function(self)
		return " %2(" .. self.mode_names[self.mode] .. "%) "
	end,
	hl = function(self)
		local mode = self.mode:sub(1, 1)
		return { fg = palette.base, bg = self.mode_colors[mode], bold = true }
	end,
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}

M.Git = {
	condition = conditions.is_git_repo,
	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changed = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,
	hl = { fg = palette.flamingo },
	{
		provider = function(self)
			return " " .. self.status_dict.head
		end,
		hl = { bold = true },
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and (" +" .. count)
		end,
		hl = { fg = utils.get_highlight("diffAdded").fg },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and (" -" .. count)
		end,
		hl = { fg = utils.get_highlight("diffDeleted").fg },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and (" ~" .. count)
		end,
		hl = { fg = utils.get_highlight("diffChanged").fg },
	},
}

local FileIcon = {
	init = function(self)
		local name = self.filename
		local ext = vim.fn.fnamemodify(name, ":e")
		self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(name, ext, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
}

local FileName = {
	provider = function(self)
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then
			return "[No Name]"
		end
		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.pathshorten(filename)
		end
		return filename
	end,
	hl = { fg = utils.get_highlight("Directory").fg },
}

local FileFlags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = "[+]",
		hl = { fg = palette.green },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = function()
			return " "
		end,
		hl = { fg = palette.green },
	},
}

M.FileNameBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
	provider = "%<",
	FileIcon,
	FileName,
	FileFlags,
}

M.Diagnostics = {
	condition = conditions.has_diagnostics,
	static = {
		-- error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
		error_icon = "􀁑 ",
		-- warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
		warn_icon = "􀇿 ",
		-- info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
		info_icon = "􀅵 ",
		-- hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
		hint_icon = "􁷖 ",
	},
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
	end,
	update = { "DiagnosticChanged", "BufEnter" },
	{
		provider = function(self)
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = "DiagnosticSignError",
	},
	{
		provider = function(self)
			return self.warns > 0 and (self.warn_icon .. self.warns .. " ")
		end,
		hl = "DiagnosticSignWarn",
	},
	{
		provider = function(self)
			return self.infos > 0 and (self.info_icon .. self.infos .. " ")
		end,
		hl = "DiagnosticSignInfo",
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = "DiagnosticSignHint",
	},
}

local LangServer = {
	condition = conditions.lsp_attached,
	provider = function()
		local names = {}
		for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return table.concat(names, " ")
	end,
}

local Treesitter = {
	condition = function()
		return require("nvim-treesitter.parsers").has_parser()
	end,
	provider = function()
		local ts = require("nvim-treesitter.parsers").has_parser()
		return " " .. (ts and "TS" or "")
	end,
}

M.Language = {
	update = { "BufEnter", "LspAttach", "LspDetach" },
	{ provider = "[" },
	LangServer,
	Treesitter,
	{ provider = "]" },
	hl = { fg = palette.surface1, bold = true },
}

local FileEncoding = {
	provider = function()
		local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
		return enc ~= "utf-8" and enc:upper()
	end,
	hl = { fg = palette.green },
}

local FileFormat = {
	provider = function()
		local fmt = vim.bo.fileformat
		return fmt ~= "unix" and fmt:upper()
	end,
	hl = { fg = palette.green },
}

M.FileInfo = {
	FileEncoding,
	FileFormat,
}

-- ╭───────────────────────────────────────────╮
-- │                  Tabline                  │
-- ╰───────────────────────────────────────────╯

local TablineFileName = {
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

local TablineFileFlags = {
	{
		condition = function(self)
			return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
		end,
		provider = " ",
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
			return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
				or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
		end,
		provider = function(self)
			if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
				return "  "
			else
				return ""
			end
		end,
		hl = { fg = palette.yellow },
	},
}

local TablineFileNameBlock = {
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
	FileIcon,
	TablineFileName,
	TablineFileFlags,
}

local TablineCloseButton = {
	condition = function(self)
		return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
	end,
	provider = " ✗",
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

-- local TablineBufferBlock = utils.surround({ "█", "█" }, function(self)
-- 	if self.is_active then
-- 		-- return utils.get_highlight("TabLineSel").bg
-- 		return nil
-- 	else
-- 		-- return utils.get_highlight("TabLine").bg
-- 		return nil
-- 	end
-- end, { TablineFileNameBlock, TablineCloseButton })
local TablineBufferBlock = {
	M.Spacer,
	TablineFileNameBlock,
	TablineCloseButton,
	M.Spacer,
}

M.BufferLine = utils.make_buflist(
	TablineBufferBlock,
	{ provider = "", hl = { fg = palette.overlay0 } },
	{ provider = "", hl = { fg = palette.overlay0 } }
)

M.TablineOffset = {
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

local Tabpage = {
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

local TabpageClose = {
	provider = "%999X  ✗%X",
	hl = "TabLine",
}

M.TabPages = {
	condition = function()
		return #vim.api.nvim_list_tabpages() >= 2
	end,
	M.Fill,
	utils.make_tablist(Tabpage),
	TabpageClose,
}

return M
