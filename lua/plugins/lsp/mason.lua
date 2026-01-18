return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"gopls",
				"pyright",
				"ruff",
				"ts_ls",
				"eslint",
				"html",
				"cssls",
				"jsonls",
				"tailwindcss",
				"emmet_ls",
				"dockerls",
				"vue_ls",
			},
			automatic_enable = true,
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"folke/neodev.nvim",
			{ "antosha417/nvim-lsp-file-operations", config = true },
		},
	},
}
