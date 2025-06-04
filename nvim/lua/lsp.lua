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

        -- Inlay hint
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable()
            map("<Space>ih", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "Inlay Hint")
        end
    end,
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
