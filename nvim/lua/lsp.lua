vim.lsp.enable("basedpyright")
vim.lsp.enable("bashls")
vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("qmlls")
vim.lsp.enable("taplo")
vim.lsp.enable("yamlls")

-- Keymap
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("Lsp", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", function()
            local params = vim.lsp.util.make_position_params(0, "utf-8")
            vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, _, _)
                if not result or vim.tbl_isempty(result) then
                    vim.notify("No definition found", vim.log.levels.INFO)
                else
                    require("telescope.builtin").lsp_definitions()
                end
            end)
        end, "Goto Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("gi", vim.lsp.buf.implementation, "Goto Implementation")
        map("gr", function()
            require("telescope.builtin").lsp_references()
        end, "Goto References")
        map("<Space>h", vim.lsp.buf.hover, "Hover")
        map("<Space>rn", vim.lsp.buf.rename, "Rename")
        map("<Space>ca", vim.lsp.buf.code_action, "Code Action")

        -- lsp client
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
            return
        end

        -- inlay hint
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable()
            map("<Space>ih", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "Inlay Hint")
        end

        -- jump to function header
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentSymbol) then
            local function request()
                local params = { textDocument = vim.lsp.util.make_text_document_params() }
                local responses = vim.lsp.buf_request_sync(0, "textDocument/documentSymbol", params)
                return responses or {}
            end

            local function find_symbol(symbols, line)
                for _, s in ipairs(symbols) do
                    local range = s.range or (s.localtion and s.location.range)
                    if range and line >= range.start.line and line <= range["end"].line then
                        if s.children then
                            local child = find_symbol(s.children, line)
                            if child then
                                return child
                            end
                        end
                        return s
                    end
                end
            end

            map("[f", function()
                local pos = vim.api.nvim_win_get_cursor(0)
                local line = pos[1] - 1 -- 1-indexed in nvim and 0-indexed in lsp
                for _, response in pairs(request()) do
                    local symbol = find_symbol(response.result or {}, line)
                    if symbol and symbol.range then
                        vim.cmd("normal! m'")
                        vim.api.nvim_win_set_cursor(0, { symbol.range.start.line + 1, 0 })
                        return
                    end
                end
            end, "Jump to function header")

            map("]f", function()
                local pos = vim.api.nvim_win_get_cursor(0)
                local line = pos[1] - 1
                for _, response in pairs(request()) do
                    local symbol = find_symbol(response.result or {}, line)
                    if symbol and symbol.range then
                        vim.cmd("normal! m'")
                        vim.api.nvim_win_set_cursor(0, { symbol.range["end"].line + 1, 0 })
                        return
                    end
                end
            end, "Jump to function footer")
        end
    end,
})

vim.api.nvim_create_user_command("LspLog", function()
    vim.cmd(string.format("tabnew %s", vim.lsp.get_log_path()))
end, {
    desc = "Open the Nvim LSP client log",
})

local complete_client = function(arg)
    return vim.iter(vim.lsp.get_clients())
        :map(function(client)
            return client.name
        end)
        :filter(function(name)
            return name:sub(1, #arg) == arg
        end)
        :totable()
end

local complete_config = function(arg)
    return vim.iter(vim.api.nvim_get_runtime_file(("lsp/%s*.lua"):format(arg), true))
        :map(function(path)
            local file_name = path:match("[^/]*.lua$")
            return file_name:sub(0, #file_name - 4)
        end)
        :totable()
end

vim.api.nvim_create_user_command("LspStart", function(info)
    if vim.lsp.config[info.args] == nil then
        vim.notify(("Invalid server name '%s'"):format(info.args))
        return
    end

    vim.lsp.enable(info.args)
end, {
    desc = "Enable and launch a languager server",
    nargs = "?",
    complete = complete_config,
})

vim.api.nvim_create_user_command("LspRestart", function(info)
    for _, name in ipairs(info.fargs) do
        if vim.lsp.config[name] == nil then
            vim.notify(("Invalid server name '%s'"):format(info.args))
        else
            vim.lsp.enable(name, false)
        end
    end

    local timer = assert(vim.uv.new_timer())
    timer:start(500, 0, function()
        for _, name in ipairs(info.fargs) do
            vim.schedule_wrap(function(x)
                vim.lsp.enable(x)
            end)(name)
        end
    end)
end, {
    desc = "Restart the given client(s)",
    nargs = "+",
    complete = complete_client,
})

vim.api.nvim_create_user_command("LspStop", function(info)
    for _, name in ipairs(info.fargs) do
        if vim.lsp.config[name] == nil then
            vim.notify(("Invalid server name '%s'"):format(info.args))
        else
            vim.lsp.enable(name, false)
        end
    end
end, {
    desc = "Disable and stop the given client(s)",
    nargs = "+",
    complete = complete_client,
})

local icons = require("utils.icons")
vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostic.ERROR,
            [vim.diagnostic.severity.WARN] = icons.diagnostic.WARN,
            [vim.diagnostic.severity.INFO] = icons.diagnostic.INFO,
            [vim.diagnostic.severity.HINT] = icons.diagnostic.HINT,
        },
    },
})
