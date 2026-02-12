return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
  },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    lualine.setup({
      options = {
        theme = "catppuccin",
        globalstatus = true,
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "alpha", "NvimTree" },
        },
      },
      sections = {
        lualine_a = {
          { "mode" },
        },
        lualine_b = {
          { "branch", icon = "" },
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" },
          },
          {
            "diff",
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
            symbols = { added = "+", modified = "~", removed = "-" },
            colored = true,
            diff_color = {
              added = { fg = "#a6e3a1" },
              modified = { fg = "#f9e2af" },
              removed = { fg = "#f38ba8" },
            },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
            colored = true,
          },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            icon = "󰏔",
            color = { fg = "#fab387" },
          },
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then
                return ""
              end
              local names = {}
              for _, client in ipairs(clients) do
                table.insert(names, client.name)
              end
              return " " .. table.concat(names, ", ")
            end,
            color = { fg = "#89b4fa" },
          },
        },
        lualine_y = {
          { "filetype" },
          { "encoding", fmt = function(str) return str ~= "utf-8" and str or "" end },
          { "progress" },
        },
        lualine_z = {
          { "location" },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
