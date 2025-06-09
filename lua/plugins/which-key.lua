return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      delay = 500,
      preset = "helix",
      show_help = true,
    })
  end,
}
