local map = vim.keymap.set
local opt = { noremap = true, silent = true }

-- Search
map("n", "<Esc>", "<Cmd>nohlsearch<CR>", opt)

-- Save
map({ "n", "i" }, "<C-s>", "<Cmd>w<CR>", opt)

-- Move line
map("n", "<C-j>", "<Cmd>m+1<CR>V=", opt)
map("v", "<C-j>", ":m'>+1<CR>gv=gv", opt)
map("i", "<C-j>", "<Esc><Cmd>m+1<CR>V=gi", opt)
map("n", "<C-k>", "<Cmd>m-2<CR>V=", opt)
map("v", "<C-k>", ":m'<-2<CR>gv=gv", opt)
map("i", "<C-k>", "<Esc><Cmd>m-2<CR>V=gi", opt)

-- Move cursor
map({ "n", "v", "o" }, "<S-j>", "5j", opt)
map({ "n", "v", "o" }, "<S-k>", "5k", opt)
map({ "n", "v", "o" }, "<S-h>", "^", opt)
map({ "n", "v", "o" }, "<S-l>", "$", opt)

-- Select
map({ "n", "i" }, "<C-a>", "<Esc>ggVG", opt)
map({ "n", "i" }, "<D-a>", "<Esc>ggVG", opt)

-- Switch window
map({ "n", "i" }, "<A-h>", "<Esc><C-w>h", opt)
map({ "n", "i" }, "<A-j>", "<Esc><C-w>j", opt)
map({ "n", "i" }, "<A-k>", "<Esc><C-w>k", opt)
map({ "n", "i" }, "<A-l>", "<Esc><C-w>l", opt)
map({ "n", "i" }, "<A-w>", "<Esc><C-w>w", opt)

-- Buffer & Tabline
map("n", "<C-h>", "<Cmd>bprevious<CR>", opt)
map("n", "<C-l>", "<Cmd>bnext<CR>", opt)

-- ToggleTerm
map({ "n", "i" }, "<F6>", require("utils.terminal"), opt)
