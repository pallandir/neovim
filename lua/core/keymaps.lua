vim.g.mapleader = " "
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

local keymap = vim.keymap
local term_buf = nil
local term_win = nil

keymap.set("i", "jk", "<ESC>:w<CR>", { desc = "Exit insert mode by pressing jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highligh" })
keymap.set("i", "<C-h>", "<Left>", { desc = "Move cursor to the left when in insert mode", noremap = true })
keymap.set("i", "<C-j>", "<Down>", { desc = "Move cursor down when in insert mode", noremap = true })
keymap.set("i", "<C-k>", "<Up>", { desc = "Move cursor up when in insert mode", noremap = true })
keymap.set("i", "<C-l>", "<Right>", { desc = "Move cursor to the right when in insert mode", noremap = true })

-- inc / dec numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment selected number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement selected number" })

-- split windows
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>e", { desc = "Split window equally" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close new tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in a new tab" })

-- term
vim.keymap.set({ "n", "t" }, "<leader>th", function()
	-- If terminal is open, close it
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.api.nvim_win_close(term_win, true)
		term_win = nil
		return
	end

	-- Calculate 40% screen height
	local height = math.floor(vim.o.lines * 0.4)

	-- Open horizontal split with that height
	vim.cmd(height .. "split")
	term_win = vim.api.nvim_get_current_win()

	-- Reuse existing terminal buffer or create a new one
	if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
		term_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_set_option_value("buflisted", false, { buf = term_buf })

		-- Set the buffer in the window first
		vim.api.nvim_win_set_buf(term_win, term_buf)

		-- Then start the terminal
		vim.fn.termopen(vim.o.shell, {
			on_exit = function()
				term_buf = nil
				term_win = nil
			end,
		})
	else
		-- Buffer exists, just set it in the window
		vim.api.nvim_win_set_buf(term_win, term_buf)
	end

	vim.cmd("startinsert")
end, { desc = "Toggle horizontal terminal (40%)", noremap = true, silent = true })

-- OpenCode terminal (vertical split)
local opencode_buf = nil
local opencode_win = nil

vim.keymap.set("n", "<leader>oo", function()
	if opencode_win and vim.api.nvim_win_is_valid(opencode_win) then
		vim.api.nvim_win_close(opencode_win, true)
		opencode_win = nil
		return
	end

	local width = math.floor(vim.o.columns * 0.4)
	vim.cmd(width .. "vsplit")
	opencode_win = vim.api.nvim_get_current_win()

	if not opencode_buf or not vim.api.nvim_buf_is_valid(opencode_buf) then
		opencode_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_set_option_value("buflisted", false, { buf = opencode_buf })
		vim.api.nvim_win_set_buf(opencode_win, opencode_buf)
		vim.fn.termopen("opencode", {
			on_exit = function()
				opencode_buf = nil
				opencode_win = nil
			end,
		})
	else
		vim.api.nvim_win_set_buf(opencode_win, opencode_buf)
	end

	vim.cmd("startinsert")
end, { desc = "Toggle OpenCode terminal", noremap = true, silent = true })
