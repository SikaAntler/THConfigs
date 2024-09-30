local map = vim.keymap.set
local opt = { noremap = true, silent = true }

-- <Esc>
map("i", "jk", "<Esc>", opt)

-- Save
map("n", "<C-s>", ":w<CR>", opt)
-- map("n", "<C-q>", ":wq<CR>", opt)

-- Move line
map("n", "<C-j>", ":m+1<CR>", opt)
map("v", "<C-j>", ":m'>+1<CR>gv", opt)
map("i", "<C-j>", "<Esc>:m+1<CR>gi", opt)
map("n", "<C-k>", ":m-2<CR>", opt)
map("v", "<C-k>", ":m'<-2<CR>gv", opt)
map("i", "<C-k>", "<Esc>:m-2<CR>gi", opt)

-- Move cursor
map({ "n", "v", "o" }, "<S-j>", "5j", opt)
map({ "n", "v", "o" }, "<S-k>", "5k", opt)
map({ "n", "v", "o" }, "<S-h>", "^", opt)
map({ "n", "v", "o" }, "<S-l>", "$", opt)

-- Select
map("n", "<C-a>", "ggVG", opt)

-- Python
-- map("n", "<C-F10>", ":! python %<CR>", opt)

-- Switch window
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)
map("n", "<A-w>", "<C-w>w", opt)

-- ToggleTerm
map({ "n", "i" }, "<F6>", '<Esc><Cmd>w<CR><Cmd>TermExec cmd="python %"<CR>')
