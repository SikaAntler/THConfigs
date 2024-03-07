local M = {}
local Path = require("plenary.path")
local platform = require("utils.platform")

local _venv_path
local _venv_python

function M.venv_changed(venv_path, venv_python)
	_venv_path = venv_path
	_venv_python = venv_python
end

if platform.is_macos then
	M.conda_envs = "~/opt/miniconda3/envs"
	M.parent_dir = "bin"
elseif platform.is_linux then
	M.conda_envs = "~/miniconda3/envs"
	M.parent_dir = ""
end

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

local get_conda_version = function(venv)
	local conda_meta = venv / "conda-meta"
	local files = vim.fn.readdir(Path.__tostring(conda_meta))
	for _, filename in ipairs(files) do
		if string.sub(filename, 1, 6) == "python" then
			for part in string.gmatch(filename, "[^-]+") do
				if string.find(part, "3") then
					return part
				end
			end
		end
	end
	return "3"
end

function M.python_env()
	if vim.bo.filetype ~= "python" then
		return ""
	end

	-- local venv = os.getenv("VIRTUAL_ENV")

	if _venv_path == nil or _venv_python == nil then
		return ""
	end

	local venv = Path:new(_venv_path)
	local prefix, version, project
	if _venv_path:find("miniconda3") then
		prefix = "conda"
		version = get_conda_version(venv)
		project = venv:_split()
		project = project[#project]
	else
		prefix = "venv"
		version = get_venv_version(venv)
		project = venv:_split()
		project = project[#project - 1]
	end

	return string.format("%s: %s (%s)", prefix, version, project)
end

return M
