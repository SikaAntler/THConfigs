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
    -- virtual_text = {
    --     prefix = function(diagnostic)
    --         if diagnostic.severity == vim.diagnostic.severity.ERROR then
    --             return icons.diagnostic.ERROR
    --         elseif diagnostic.severity == vim.diagnostic.severity.WARN then
    --             return icons.diagnostic.WARN
    --         elseif diagnostic.severity == vim.diagnostic.severity.INFO then
    --             return icons.diagnostic.INFO
    --         else
    --             return icons.diagnostic.HINT
    --         end
    --     end,
    -- },
})
