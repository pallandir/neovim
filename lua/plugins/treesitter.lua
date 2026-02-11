return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local parsers = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"markdown",
			"markdown_inline",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"query",
			"vimdoc",
			"c",
			"go",
			"gomod",
			"rust",
			"python",
			"vue",
		}

		-- Install parsers
		require("nvim-treesitter").install(parsers)

		-- Enable treesitter highlighting for all filetypes with parsers
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})

		-- Enable treesitter-based folding (start with all folds open)
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99

		-- Incremental selection keymaps
		vim.keymap.set("n", "<C-space>", function()
			require("nvim-treesitter.incremental_selection").init_selection()
		end, { desc = "Init treesitter selection" })

		vim.keymap.set("v", "<C-space>", function()
			require("nvim-treesitter.incremental_selection").node_incremental()
		end, { desc = "Increment treesitter selection" })

		vim.keymap.set("v", "<bs>", function()
			require("nvim-treesitter.incremental_selection").node_decremental()
		end, { desc = "Decrement treesitter selection" })
	end,
}
