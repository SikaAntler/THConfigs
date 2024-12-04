local C = require("configs.heirline.components")
local conditions = require("heirline.conditions")
local icons = require("utils.icons")
local palette = require("catppuccin.palettes").get_palette("macchiato")
local utils = require("heirline.utils")

---@param child table
---@param space integer | nil
local RightPadding = function(child, space)
	local result = {
		condition = child.condition,
		child,
	}
	if space == nil then
		space = 2
	end
	for _ = 1, space do
		table.insert(result, C.Spacer)
	end
	return result
end

local Mode = {
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
		return { fg = palette.crust, bg = self.mode_colors[mode], bold = true }
	end,
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}

local Git = {
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
		hl = { fg = utils.get_highlight("diffRemoved").fg },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and (" ~" .. count)
		end,
		hl = { fg = utils.get_highlight("diffChanged").fg },
	},
}

local FileName = {
	provider = function(self)
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then
			return "[No Name]"
		end
		local max_precent
		if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
			max_precent = 0.7
		else
			max_precent = 0.5
		end
		if not conditions.width_percent_below(#filename, max_precent) then
			filename = vim.fn.pathshorten(filename)
		end
		return filename
	end,
	hl = { fg = palette.text },
}

local FileFlags = {
	-- {
	-- 	condition = function(self)
	-- 		return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
	-- 	end,
	-- 	provider = " " .. icons.modified_square,
	-- 	hl = { fg = palette.text },
	-- },
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

local File = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
	provider = "%<",
	C.FileIcon,
	FileName,
	FileFlags,
}

local Diagnostics = {
	condition = conditions.has_diagnostics,
	static = {
		error_icon = icons.diagnostic_error,
		warn_icon = icons.diagnostic_warn,
		info_icon = icons.diagnostic_info,
		hint_icon = icons.diagnostic_hint,
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

local FileInfo = {
	{ -- Encoding
		provider = function()
			local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
			return enc ~= "utf-8" and enc:upper()
		end,
		hl = { fg = palette.green },
	},
	{ -- format
		provider = function()
			local fmt = vim.bo.fileformat
			return fmt ~= "unix" and fmt:upper()
		end,
		hl = { fg = palette.green },
	},
}

local Language = {
	update = { "BufEnter", "LspAttach", "LspDetach" },
	{ -- LSP
		condition = conditions.lsp_attached,
		provider = function()
			local names = {}
			for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
				table.insert(names, server.name)
			end
			return " " .. table.concat(names, " ")
		end,
		hl = { fg = palette.pink, bold = true },
	},
	C.Spacer,
	{ -- Treesitter
		condition = function()
			return require("nvim-treesitter.parsers").has_parser()
		end,
		provider = function()
			local ts = require("nvim-treesitter.parsers").has_parser()
			return ts and " TS" or ""
		end,
		hl = { fg = palette.green, bold = true },
	},
}

local Cursor = { provider = "%(%l%):%c %(%P%)" }

return {
	RightPadding(Mode),
	RightPadding(Git),
	RightPadding(File),
	Diagnostics,
	C.Fill,
	RightPadding(FileInfo),
	RightPadding(Language),
	Cursor,
}
