return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", 
              arrow_open = "", 
            },
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    local keymap = vim.keymap 

    keymap.set("n", "<leader>nn", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) 
    keymap.set("n", "<leader>nf", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) 
    keymap.set("n", "<leader>nc", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) 
    keymap.set("n", "<leader>nr", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) 
  end
}
