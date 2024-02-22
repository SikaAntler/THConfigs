local M = {}
local Path = require("plenary.path")

local get_venv_version = function(venv)
	local file = venv / "pyvenv.cfg"
	file = io.open(file.filename, "r")
	if file == nil then
		return ""
	end
	for line in file:lines() do
		local _, end_pos = string.find(line, "version_info")
		if end_pos ~= nil then
			local version = string.sub(line, end_pos + 4, #line)
			local parts = {}
			for part in string.gmatch(version, "[^.]+") do
				table.insert(parts, part)
				if #parts == 3 then
					break
				end
			end
			return table.concat(parts, ".")
		end
	end
end

function M.python_env()
	if vim.bo.filetype ~= "python" then
		return ""
	end

	local venv = os.getenv("VIRTUAL_ENV")
	if venv == nil then
		return ""
	else
		venv = Path:new(venv)
		local version = get_venv_version(venv)
		local project = venv:parent():_split()
		project = project[#project]
		return string.format("%s (%s)", version, project)
	end
end

return M
