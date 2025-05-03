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
    elseif system.is_macos then
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
    if vim.fn.executable("python") ~= 0 then
        cmd = "python"
    else
        msg = "command not found: python"
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
    local ft = vim.bo.filetype
    local name = vim.fn.expand("%:t")
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
