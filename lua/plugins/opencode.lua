return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      input = { enabled = true },
      picker = { enabled = true },
      terminal = { enabled = true },
    },
  },
  {
    "nickjvandyke/opencode.nvim",
    lazy = false,
    dependencies = {
      "folke/snacks.nvim",
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        provider = {
          enabled = "snacks",
        },
      }

      -- Required for buffer reload on file edits
      vim.o.autoread = true

      -- Keymaps
      -- Toggle opencode terminal
      vim.keymap.set({ "n", "t" }, "<leader>ot", function()
        require("opencode").toggle()
      end, { desc = "Opencode: Toggle" })

      -- Open selector (prompts, commands)
      vim.keymap.set({ "n", "x" }, "<leader>oo", function()
        require("opencode").select()
      end, { desc = "Opencode: Select" })

      -- Ask opencode with context
      vim.keymap.set({ "n", "x" }, "<leader>oa", function()
        require("opencode").ask()
      end, { desc = "Opencode: Ask" })

      -- Operator mode for applying prompts to ranges
      vim.keymap.set("n", "<leader>op", function()
        return require("opencode").operator("@this ")
      end, { desc = "Opencode: Operator", expr = true })

      -- Quick actions using built-in prompts
      vim.keymap.set({ "n", "x" }, "<leader>of", function()
        require("opencode").prompt("fix")
      end, { desc = "Opencode: Fix diagnostics" })

      vim.keymap.set({ "n", "x" }, "<leader>oe", function()
        require("opencode").prompt("explain")
      end, { desc = "Opencode: Explain" })

      vim.keymap.set({ "n", "x" }, "<leader>or", function()
        require("opencode").prompt("review")
      end, { desc = "Opencode: Review" })

      -- Scroll opencode
      vim.keymap.set("n", "<leader>ou", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "Opencode: Scroll up" })

      vim.keymap.set("n", "<leader>od", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "Opencode: Scroll down" })
    end,
  },
}
