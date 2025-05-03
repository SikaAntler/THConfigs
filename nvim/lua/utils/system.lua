local system = vim.uv.os_uname().sysname

return {
    system = system,
    is_linux = system == "Linux",
    is_macos = system == "Darwin",
    is_windows = system == "Windows",
}
