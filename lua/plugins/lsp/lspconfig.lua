return {
	-- 📦 Mason: Package manager for LSP servers
	{
		"williamboman/mason.nvim",
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

	-- 🛠️ Mason-LSPConfig: Bridges Mason and nvim-lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			-- The list of servers to auto-install (Mason will handle the installation)
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"gopls",
				"pyright",
				"ruff_lsp",
				"tsserver",
				"eslint",
				"html",
				"cssls",
				"jsonls",
				"tailwindcss",
				"emmet_ls",
				"dockerls",
				"volar",
			},
			-- This tells mason-lspconfig to automatically enable all installed servers
			-- using the native Nvim API (vim.lsp.enable)
			automatic_installation = true,
			-- Use the new setup_handlers to enable servers
			setup_handlers = {
				-- Default handler for all servers not explicitly configured below
				function(server_name)
					-- Call vim.lsp.enable to activate the server for its filetypes.
					-- nvim-lspconfig provides the base config via runtimepath.
					vim.lsp.enable(server_name)
				end,
			},
		},
	},

	-- ⚙️ LSPConfig: Provides default configurations and applies custom settings
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Enhanced capabilities for autocompletion (passed to ALL servers)
			local capabilities = cmp_nvim_lsp.default_capabilities()

			-- Function to setup keybindings when LSP attaches to buffer (on_attach)
			-- This function will be applied globally to all servers via the '*' config.
			local on_attach = function(client, bufnr)
				-- Client-specific logic (e.g., auto-fix on save for ESLint)
				if client.name == "eslint" then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end

				local opts = { buffer = bufnr, silent = true }

				-- Navigation
				vim.keymap.set(
					"n",
					"gR",
					"<cmd>Telescope lsp_references<CR>",
					vim.tbl_extend("force", opts, { desc = "Show LSP references" })
				)
				vim.keymap.set(
					"n",
					"gD",
					vim.lsp.buf.declaration,
					vim.tbl_extend("force", opts, { desc = "Go to declaration" })
				)
				vim.keymap.set(
					"n",
					"gd",
					"<cmd>Telescope lsp_definitions<CR>",
					vim.tbl_extend("force", opts, { desc = "Show LSP definitions" })
				)
				vim.keymap.set(
					"n",
					"gi",
					"<cmd>Telescope lsp_implementations<CR>",
					vim.tbl_extend("force", opts, { desc = "Show LSP implementations" })
				)
				vim.keymap.set(
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					vim.tbl_extend("force", opts, { desc = "Show LSP type definitions" })
				)

				-- Actions
				vim.keymap.set(
					{ "n", "v" },
					"<leader>ca",
					vim.lsp.buf.code_action,
					vim.tbl_extend("force", opts, { desc = "See available code actions" })
				)
				vim.keymap.set(
					"n",
					"<leader>rn",
					vim.lsp.buf.rename,
					vim.tbl_extend("force", opts, { desc = "Smart rename" })
				)

				-- Diagnostics
				vim.keymap.set(
					"n",
					"<leader>D",
					"<cmd>Telescope diagnostics bufnr=0<CR>",
					vim.tbl_extend("force", opts, { desc = "Show buffer diagnostics" })
				)
				vim.keymap.set(
					"n",
					"<leader>d",
					vim.diagnostic.open_float,
					vim.tbl_extend("force", opts, { desc = "Show line diagnostics" })
				)
				vim.keymap.set(
					"n",
					"[d",
					vim.diagnostic.goto_prev,
					vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" })
				)
				vim.keymap.set(
					"n",
					"]d",
					vim.diagnostic.goto_next,
					vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" })
				)

				-- Documentation
				vim.keymap.set(
					"n",
					"K",
					vim.lsp.buf.hover,
					vim.tbl_extend("force", opts, { desc = "Show documentation for what is under cursor" })
				)

				-- Utility: Updated command to use the new native LspRestart alias
				vim.keymap.set(
					"n",
					"<leader>rs",
					":LspRestart<CR>",
					vim.tbl_extend("force", opts, { desc = "Restart LSP" })
				)
			end

			-- === 1. Global/Catch-all Configuration (New Native API) ===
			-- Use vim.lsp.config('*', {...}) to set capabilities and on_attach for all servers.
			-- This is the recommended way to handle common settings.
			vim.lsp.config("*", {
				on_attach = on_attach,
				capabilities = capabilities,
				-- Optionally add flags like debounce settings for all servers here:
				-- flags = {
				-- 	debounce_text_changes = 150,
				-- },
			})

			-- Configure diagnostic signs (This remains the same, as it's a native Nvim feature)
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
				virtual_text = {
					prefix = "●",
				},
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			-- === 2. Custom Server Overrides (New Native API) ===
			-- Only define configurations for servers where you need to override the defaults.
			-- The global on_attach/capabilities from vim.lsp.config('*') will be merged in.

			-- Custom setup for Lua (lua_ls)
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- Custom setup for Rust (rust_analyzer)
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
						checkOnSave = {
							command = "clippy",
							allFeatures = true,
						},
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
					},
				},
			})

			-- Custom setup for Go (gopls)
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							shadow = true,
						},
						staticcheck = true,
						gofumpt = true,
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
			})

			-- Custom setup for Python (pyright)
			vim.lsp.config("pyright", {
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = true,
							typeCheckingMode = "basic",
						},
					},
				},
			})

			-- Custom setup for TypeScript/JavaScript (tsserver)
			vim.lsp.config("tsserver", {
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
				},
			})

			-- Custom setup for Emmet (emmet_ls)
			vim.lsp.config("emmet_ls", {
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
				},
			})

			-- Custom setup for Tailwind (tailwindcss)
			vim.lsp.config("tailwindcss", {
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							},
						},
					},
				},
			})

			-- Custom setup for Vue (volar)
			vim.lsp.config("volar", {
				filetypes = { "vue", "typescript", "javascript" },
			})

			-- NOTE: ruff_lsp, eslint, html, cssls, jsonls, and dockerls use the default
			-- config provided by nvim-lspconfig and automatically inherit the global
			-- on_attach and capabilities set in vim.lsp.config('*').
		end,
	},
}
