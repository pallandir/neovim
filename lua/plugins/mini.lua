return {
	{
		"echasnovski/mini.nvim",
		version = "*",
		event = "VeryLazy",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			-- Autopairs replacement
			require("mini.pairs").setup()

			-- Comment replacement (with treesitter support)
			require("mini.comment").setup({
				options = {
					custom_commentstring = function()
						return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
					end,
				},
			})

			-- Surround replacement
			require("mini.surround").setup()

			-- Indentscope (replaces indent-blankline)
			require("mini.indentscope").setup({
				symbol = "│",
				options = { try_as_border = true },
			})

			-- Enhanced text objects
			require("mini.ai").setup({
				n_lines = 500,
				custom_textobjects = {
					o = require("mini.ai").gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
					a = require("mini.ai").gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
				},
			})

			-- Git diff integration
			require("mini.diff").setup({
				view = {
					style = "sign",
					signs = { add = "▎", change = "▎", delete = "" },
				},
				mappings = {
					apply = "gh",
					reset = "gH",
					textobject = "gh",
					goto_first = "[H",
					goto_prev = "[h",
					goto_next = "]h",
					goto_last = "]H",
				},
			})

			-- Git commands
			require("mini.git").setup()

			-- Notifications
			require("mini.notify").setup()
			vim.notify = require("mini.notify").make_notify()
		end,
	},
}
