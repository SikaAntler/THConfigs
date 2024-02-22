local cmp = require("cmp")
local symbol_map = {
	Text = "",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰇽",
	Variable = "󰂡",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
}

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	view = {
		entries = { "custom", selection_order = "near_cursor" },
	},

	window = {
		completion = {
			-- winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
			col_offset = -4,
			side_padding = 1,
			-- 1:left-top 2:top 3:right-top, 4:right
			-- 5:right-bottom, 6:bottom, 7:left-bottom, 8: left
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			scrollbar = "║",
		},
		documentation = cmp.config.window.bordered(),
	},

	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({
				mode = "symbol_text",
				maxwidth = function()
					return math.floor(0.45 * vim.o.columns)
				end,
				ellipsis_char = "...",
				show_labelDetails = true,
				symbol_map = symbol_map,
			})(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = (strings[1] or " ") .. " "
			kind.menu = "    ⟨" .. (strings[2] or "") .. "⟩"

			return kind
		end,
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
	}),

	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		-- ['<CR>'] = cmp.mapping.confirm(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				local entry = cmp.get_selected_entry()
				if not entry then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				end
				cmp.confirm()
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		["<C-e>"] = cmp.mapping.abort(),
	}),
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "cmdline" },
	}),
})
