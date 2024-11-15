require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"basedpyright",
		"bashls",
		"lua_ls",
		"taplo",
		"yamlls",
	},
})

vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

local lspconfig = require("lspconfig")
local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	["textDocument/documentHighlight"] = vim.lsp.with(vim.lsp.handlers.document_highlight, { border = border }),
}
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.basedpyright.setup({
	capabilities = capabilities,
	handlers = handlers,
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
lspconfig.bashls.setup({ capabilities = capabilities, handlers = handlers })
lspconfig.lua_ls.setup({ capabilities = capabilities, handlers = handlers })
lspconfig.taplo.setup({ capabilities = capabilities, handlers = handlers })
lspconfig.yamlls.setup({ capabilities = capabilities, handlers = handlers })

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
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.diagnostic_error,
			[vim.diagnostic.severity.WARN] = icons.diagnostic_warn,
			[vim.diagnostic.severity.INFO] = icons.diagnostic_info,
			[vim.diagnostic.severity.HINT] = icons.diagnostic_hint,
		},
	},
})
