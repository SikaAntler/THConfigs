return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			close_command = function(n)
				require("mini.bufremove").delete(n, false)
			end,
			right_mouse_command = function(n)
				require("mini.bufremove").delete(n, false)
			end,
			indicator = { style = "underline" },
			buffer_close_icon = "✗",
			diagnostics = "nvim_lsp",
			-- separator_style = { "|", "|" },
			separator_style = { "", "" },
			always_show_bufferline = true,
			offsets = {
				{
					filetype = "neo-tree",
					text = "Neo-tree",
					highlight = "Directory",
					text_align = "left",
				},
			},
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},
		},
	},
	keys = {
		{ "<C-h>", "<cmd>BufferLineCyclePrev<CR>" },
		{ "<C-l>", "<cmd>BufferLineCycleNext<CR>" },
	},
}
