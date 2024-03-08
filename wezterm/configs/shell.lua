local platform = require("configs.platform")

local shell
if platform.is_win then
	shell = { "powershell" }
elseif platform.is_macos then
	shell = { "zsh", "-l" }
else
	shell = { "bash", "-l" }
end

return {
	default_prog = shell,
}
