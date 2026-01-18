return {
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
		local capabilities = cmp_nvim_lsp.default_capabilities()

		local on_attach = function(client, bufnr)
			if client.name == "eslint" then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll",
				})
			end

			local opts = { buffer = bufnr, silent = true }

			vim.keymap.set(
				"n",
				"gR",
				"<cmd>Telescope lsp_references<CR>",
				vim.tbl_extend("force", opts, { desc = "LSP references" })
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
				vim.tbl_extend("force", opts, { desc = "LSP definitions" })
			)
			vim.keymap.set(
				"n",
				"gi",
				"<cmd>Telescope lsp_implementations<CR>",
				vim.tbl_extend("force", opts, { desc = "LSP implementations" })
			)
			vim.keymap.set(
				"n",
				"gt",
				"<cmd>Telescope lsp_type_definitions<CR>",
				vim.tbl_extend("force", opts, { desc = "LSP type definitions" })
			)

			vim.keymap.set(
				{ "n", "v" },
				"<leader>ca",
				vim.lsp.buf.code_action,
				vim.tbl_extend("force", opts, { desc = "Code actions" })
			)
			vim.keymap.set(
				"n",
				"<leader>rn",
				vim.lsp.buf.rename,
				vim.tbl_extend("force", opts, { desc = "Rename symbol" })
			)

			vim.keymap.set(
				"n",
				"<leader>D",
				"<cmd>Telescope diagnostics bufnr=0<CR>",
				vim.tbl_extend("force", opts, { desc = "Buffer diagnostics" })
			)
			vim.keymap.set(
				"n",
				"<leader>d",
				vim.diagnostic.open_float,
				vim.tbl_extend("force", opts, { desc = "Line diagnostics" })
			)

			vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
			vim.keymap.set(
				"n",
				"<leader>rs",
				"<cmd>LspRestart<CR>",
				vim.tbl_extend("force", opts, { desc = "Restart LSP" })
			)
		end

		vim.lsp.config("*", {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "",
				},
			},
			virtual_text = { prefix = "●" },
			update_in_insert = false,
			underline = true,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "if_many",
			},
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
					telemetry = { enable = false },
				},
			},
		})

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

		vim.lsp.config("ts_ls", {
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

		vim.lsp.config("vue_ls", {
			filetypes = { "vue", "javascript", "typescript" },
		})

		vim.lsp.enable({
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
		})
	end,
}
