return {
	"shellRaining/hlchunk.nvim",
	event = "UIEnter",
	opts = {
		chunk = { enable = false },
		indent = {
			support_filetyes = {
				"*.lua",
			},
		},
		line_num = { enable = false },
		blank = { enable = false },
	},
}
