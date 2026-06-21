local function handle_whitespaces(filename)
    if filename:find("%s") then
        return '"' .. filename .. '"'
    else
        return filename
    end
end

local function handle_cpp(name)
    local msg, compiler
    local out = vim.fn.expand("%:t:r") .. ".out"
    out = handle_whitespaces(out)

    local system = require("utils.system")
    if system.is_linux then
        compiler = "g++"
    elseif system.is_macos then
        compiler = "clang++"
    elseif system.is_windows then
        if vim.fn.executable("cl") ~= 0 then
            compiler = "cl"
        elseif vim.fn.executable("g++") ~= 0 then
            compiler = "g++"
        else
            msg = "compiler not found: cl or g++"
        end
    else
        msg = "unknown system: " .. system
    end

    local arg = name .. " -o " .. out .. " && ./" .. out

    return msg, compiler, arg
end

local function handle_python(name)
    local msg, cmd

    local venv_existed = false
    local root = vim.fs.root(0, { ".git", "pyproject.toml", "setup.py" })
    if root then
        local venv = root .. "/.venv"
        if vim.fn.isdirectory(venv) == 1 then
            venv_existed = true
        end
    end

    if vim.fn.executable("uv") ~= 0 and venv_existed then
        cmd = "uv run"
    elseif vim.fn.executable("python3") ~= 0 then
        cmd = "python3"
    else
        msg = "command not found: python3"
    end

    return msg, cmd, name
end

local function handle_sh(name)
    return nil, "$SHELL", name
end

local ft_to_func = {
    cpp = handle_cpp,
    python = handle_python,
    sh = handle_sh,
}

return function()
    -- check whether the buffer is modified
    if vim.bo.modified then
        vim.cmd("write")
        if vim.bo.modified then -- handle error
            return
        end
    end

    local ft = vim.bo.filetype
    local name = vim.api.nvim_buf_get_name(0)
    name = handle_whitespaces(name)
    local msg, cmd, arg

    local func = ft_to_func[ft]
    if func then
        msg, cmd, arg = func(name)
        if msg then
            vim.notify(msg)
        else
            require("toggleterm").exec(cmd .. " " .. arg)
        end
    else
        vim.notify("filetype " .. ft .. " has not been supported")
    end
end
