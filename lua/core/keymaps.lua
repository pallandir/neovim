vim.g.mapleader = " "

local function get_python3_host()
  local nvim_venv = vim.fn.stdpath("data") .. "/python-venv/bin/python"
  if vim.fn.executable(nvim_venv) == 1 then
    return nvim_venv
  end
  if vim.fn.has("mac") == 1 then
    if vim.fn.executable("/opt/homebrew/bin/python3") == 1 then
      return "/opt/homebrew/bin/python3"
    elseif vim.fn.executable("/usr/local/bin/python3") == 1 then
      return "/usr/local/bin/python3"
    end
  end
  return vim.fn.exepath("python3")
end
vim.g.python3_host_prog = get_python3_host()

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>:w<CR>", { desc = "Exit insert mode by pressing jk" })
keymap.set("n", "<leader>nc", ":nohl<CR>", { desc = "Clear search highlight" })
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

-- Terminal mode escape mappings
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", noremap = true, silent = true })
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Window commands from terminal", noremap = true, silent = true })

-- Git (mini.git)
keymap.set("n", "<leader>gs", "<cmd>lua MiniGit.show_at_cursor()<CR>", { desc = "Git show at cursor" })
keymap.set("n", "<leader>gb", "<cmd>lua MiniGit.blame_line()<CR>", { desc = "Git blame line" })

-- Notifications (mini.notify)
keymap.set("n", "<leader>nd", "<cmd>lua MiniNotify.clear()<CR>", { desc = "Dismiss notifications" })
keymap.set("n", "<leader>nh", "<cmd>lua MiniNotify.show_history()<CR>", { desc = "Notification history" })
