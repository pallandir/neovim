vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i","jk", "<ESC>", {desc = "Exit insert mode by pressing jk"})
keymap.set("n", "<leader>nh", ":nohl<CR>", {desc = "Clear search highligh"})

-- inc / dec numbers
keymap.set("n","<leader>+","<C-a>", {desc = "Increment selected number"})
keymap.set("n","<leader>-","<C-x>", {desc = "Decrement selected number"})

-- split windows
keymap.set("n","<leader>sv", "<C-w>v", {desc = "Split window vertically"})
keymap.set("n","<leader>sh", "<C-w>s", {desc = "Split window horizontally"})
keymap.set("n","<leader>se", "<C-w>e", {desc = "Split window equally"})
keymap.set("n","<leader>sx", "<cmd>close<CR>", {desc = "Close current split"})

