local platform = require("configs.platform")

local shell
if platform.is_win then
	shell = "powershell"
elseif platform.is_macos then
	shell = "/bin/zsh"
else
	shell = "bash"
end

return {
	default_prog = { shell, "-l" },
}
