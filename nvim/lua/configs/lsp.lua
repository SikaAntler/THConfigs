require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"basedpyright",
		"lua_ls",
		"taplo",
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
lspconfig.lua_ls.setup({ capabilities = capabilities, handlers = handlers })
lspconfig.basedpyright.setup({
	capabilities = capabilities,
	handlers = handlers,
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "basic",
			},
		},
	},
})

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
		map("n", "gd", vim.lsp.buf.definition, opt)
		map("n", "<C-q>", vim.lsp.buf.hover, opt)
		map("n", "gi", vim.lsp.buf.implementation, opt)
		-- map("n", "<C-k>", vim.lsp.buf.signature_help, opt)
		map("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, opt)
		map("n", "<Space>D", vim.lsp.buf.type_definition, opt)
		map("n", "<Space>rn", vim.lsp.buf.rename, opt)
		map({ "n", "v" }, "<Space>ca", vim.lsp.buf.code_action, opt)
		map("n", "gr", vim.lsp.buf.references, opt)
	end,
})

-- Diagnostic
-- map("n", "<Space>e", vim.diagnostic.open_float)
-- map("n", "[d", vim.diagnostic.goto_prev)
-- map("n", "]d", vim.diagnostic.goto_next)
-- map("n", "<Space>q", vim.diagnostic.setloclist)

-- Diagnostic levels: E(ERROR), W(WARN), I(INFO), H(HINT)
-- vim.diagnostic.config({
-- 	virtual_text = {
-- 		severity = vim.diagnostic.severity.ERROR,
-- 	},
-- 	signs = {
-- 		severity = { min = vim.diagnostic.severity.WARN },
-- 	},
-- 	underline = {
-- 		severity = { max = vim.diagnostic.severity.INFO },
-- 	},
-- })

-- Sign symbols
-- vim.fn.sign_define("DiagnosticSignError", { text = "󰅚", texthl = "DiagnosticSignError" })
-- vim.fn.sign_define("DiagnosticSignWarn", { text = "󰀪", texthl = "DiagnosticSignWarn" })
-- vim.fn.sign_define("DiagnosticSignInfo", { text = "󰋽", texthl = "DiagnosticSignInfo" })
-- vim.fn.sign_define("DiagnosticSignHint", { text = "󰌶", texthl = "DiagnosticSignHint" })
-- vim.fn.sign_define("DiagnosticSignOk", { text = "✔", texthl = "DiagnosticSignOk" })
-- vim.cmd([[
--     highlight DiagnosticSignError guifg=#f38ba8
--     highlight DiagnosticSignWarn guifg=#f9e2af
--     highlight DiagnosticSignWarn guifg=#94e2d5
-- ]])
