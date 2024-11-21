local M = {}

M.Spacer = { provider = " " }

M.Fill = { provider = "%=" }

M.FileIcon = {
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

return M
