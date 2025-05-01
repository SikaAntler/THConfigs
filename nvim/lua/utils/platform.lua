local platform = vim.loop.os_uname().sysname

M = {
    is_linux = platform == "Linux",
    is_macos = platform == "Darwin",
    is_windows = platform == "Windows",
}

return M
