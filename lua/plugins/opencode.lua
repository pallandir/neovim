return {
  "sudo-tee/opencode.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
  },
  config = function()
    require("opencode").setup({
      preferred_picker = "fzf",
      preferred_completion = "nvim-cmp",
      default_mode = "plan",
      ui = {
        position = "right",
        window_width = 0.40,
      },
      keymap = {
        input_window = {
          ["<Esc>"] = false,
          ["<C-q>"] = { "close" },
          ["<C-c>"] = { "cancel" },
          ["<CR>"] = { "submit_input_prompt", mode = { "n", "i" } },
          ["<M-m>"] = { "switch_mode" }, -- Alt+M to switch between plan/build
        },
        output_window = {
          ["<Esc>"] = false,
          ["<C-q>"] = { "close" },
          ["<C-c>"] = { "cancel" },
        },
      },
    })
  end,
}
