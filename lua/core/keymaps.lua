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

-- tabs
keymap.set("n","<leader>to","<cmd>tabnew<CR>",{desc = "Open new tab"})
keymap.set("n","<leader>tx","<cmd>tabclose<CR>",{desc = "Close new tab"})
keymap.set("n", "<leader>tn","<cmd>tabn<CR>",{desc="Go to next tab"})
keymap.set("n", "<leader>tp","<cmd>tabp<CR>",{desc="Go to previous tab"})
keymap.set("n","<leader>tf","<cmd>tabnew<CR>",{desc="Open current buffer in a new tab"})

