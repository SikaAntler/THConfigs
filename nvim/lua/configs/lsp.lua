require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = require("blink.cmp").get_lsp_capabilities()
local lspconfig = require("lspconfig")

-- setup language servers
lspconfig.basedpyright.setup({
    capabilities = capabilities,
    settings = {
        basedpyright = {
            disableOrganizedImport = true,
            analysis = {
                autoImportCompletions = false,
                inlayHints = { variableTypes = false },
                typeCheckingMode = "basic",
            },
        },
    },
})
lspconfig.bashls.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.powershell_es.setup({
    bundle_path = "~/PowerShellEditorServices",
    shell = "powershell.exe",
    capabilities = capabilities,
})
lspconfig.qmlls.setup({
    capabilities = capabilities,
    cmd = { "pyside6-qmlls", "qmlls" },
})
lspconfig.taplo.setup({ capabilities = capabilities })
lspconfig.yamlls.setup({ capabilities = capabilities })

-- inlay hint
vim.lsp.inlay_hint.enable()

-- Keymap
local map = vim.keymap.set
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opt = { buffer = ev.buf }
        map("n", "gD", vim.lsp.buf.declaration, opt)
        map("n", "<C-q>", vim.lsp.buf.hover, opt)
        map("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, opt)
        map("n", "<Space>rn", vim.lsp.buf.rename, opt)
        map({ "n", "v" }, "<Space>ca", vim.lsp.buf.code_action, opt)
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
