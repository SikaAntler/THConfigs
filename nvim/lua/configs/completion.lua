local luasnip = require("luasnip")
luasnip.config.setup({})

-- local symbol_map = {
-- 	Text = "",
-- 	Method = "󰆧",
-- 	Function = "󰊕",
-- 	Constructor = "",
-- 	Field = "󰇽",
-- 	Variable = "󰂡",
-- 	Class = "󰠱",
-- 	Interface = "",
-- 	Module = "",
-- 	Property = "󰜢",
-- 	Unit = "",
-- 	Value = "󰎠",
-- 	Enum = "",
-- 	Keyword = "󰌋",
-- 	Snippet = "",
-- 	Color = "󰏘",
-- 	File = "󰈙",
-- 	Reference = "",
-- 	Folder = "󰉋",
-- 	EnumMember = "",
-- 	Constant = "󰏿",
-- 	Struct = "",
-- 	Event = "",
-- 	Operator = "󰆕",
-- }

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	-- view = {
	-- 	entries = { "custom", selection_order = "near_cursor" },
	-- },

	-- window = {
	-- 	completion = {
	-- 		-- winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
	-- 		col_offset = -4,
	-- 		side_padding = 1,
	-- 		-- 1:left-top 2:top 3:right-top, 4:right
	-- 		-- 5:right-bottom, 6:bottom, 7:left-bottom, 8: left
	-- 		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	-- 		scrollbar = "║",
	-- 	},
	-- 	documentation = cmp.config.window.bordered(),
	-- },
	window = {
		completion = {
			winhighlight = "Normal:CmpNormal,FloatBorder:CmpFloatBorder,CursorLine:CmpCursorLine,Search:None",
			side_padding = 1,
		},
		documentation = cmp.config.window.bordered({
			winhighlight = "Normal:CmpNormalDoc,FloatBorder:CmpFloatBorder,CursorLine:CmpCursorLine,Search:None",
		}),
	},
	completion = { completeopt = "menu,menuone,noinsert" },

	-- formatting = {
	-- 	fields = { "kind", "abbr", "menu" },
	-- 	format = function(entry, vim_item)
	-- 		local kind = require("lspkind").cmp_format({
	-- 			mode = "symbol_text",
	-- 			maxwidth = function()
	-- 				return math.floor(0.45 * vim.o.columns)
	-- 			end,
	-- 			ellipsis_char = "...",
	-- 			show_labelDetails = true,
	-- 			symbol_map = symbol_map,
	-- 		})(entry, vim_item)
	-- 		local strings = vim.split(kind.kind, "%s", { trimempty = true })
	-- 		kind.kind = (strings[1] or " ") .. " "
	-- 		kind.menu = "    ⟨" .. (strings[2] or "") .. "⟩"
	--
	-- 		return kind
	-- 	end,
	-- },
	formatting = {
		format = require("lspkind").cmp_format({ maxwidth = 30, ellipsis_char = "   " }),
		expandable_indicator = true,
		fields = { "abbr", "kind", "menu" },
	},

	sources = {
		{ name = "luasnip", priority = 1000 },
		{ name = "nvim_lsp", priority = 800 },
		{ name = "path", priority = 600 },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					local buf = vim.api.nvim_get_current_buf()
					local btye_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
					if btye_size > 1024 * 1024 then -- 1 MB max
						return {}
					end
					return { buf }
				end,
			},
			priority = 400,
		},
		{
			name = "lazydev",
			-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
			group_index = 0,
		},
		{ name = "nvim_lsp_signature_help" },
	},

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
