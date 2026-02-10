return {
  "sudo-tee/opencode.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>og", "<cmd>OpenCodeToggle<cr>", desc = "Toggle OpenCode" },
    { "<leader>oi", "<cmd>OpenCodeInput<cr>", desc = "OpenCode Input" },
    { "<leader>od", "<cmd>OpenCodeDiff<cr>", desc = "OpenCode Diff" },
  },
  opts = {
    position = "right",
    window_width = 0.40,
    default_mode = "plan",
  },
}
