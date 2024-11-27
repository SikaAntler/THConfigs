return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"onsails/lspkind.nvim",
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_lua").load({
							paths = { "~/.config/nvim/lua/snippets" },
						})
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},
		"saadparwaiz1/cmp_luasnip",

		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		{ "hrsh7th/cmp-buffer", lazy = true },
		{
			"hrsh7th/cmp-cmdline",
			keys = { ":", "/", "?" },
			opts = function()
				local cmp = require("cmp")
				return {
					{
						type = "/",
						mapping = cmp.mapping.preset.cmdline(),
						sources = {
							{ name = "buffer" },
						},
					},
					{
						type = ":",
						mapping = cmp.mapping.preset.cmdline(),
						sources = cmp.config.sources({
							{ name = "path" },
						}, {
							{
								name = "cmdline",
								option = {
									ignore_cmds = { "Man", "!" },
								},
							},
						}),
					},
				}
			end,
			config = function(_, opts)
				local cmp = require("cmp")
				vim.tbl_map(function(val)
					cmp.setup.cmdline(val.type, val)
				end, opts)
			end,
		},
	},
	config = function()
		require("configs.completion")
	end,
}
