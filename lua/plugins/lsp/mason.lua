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
				"volar",
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"prettier",
				"stylua",
				"black",
				"gofumpt",
				"goimports",
				"eslint_d",
			},
			auto_update = false,
			run_on_start = true,
		},
	},
}
