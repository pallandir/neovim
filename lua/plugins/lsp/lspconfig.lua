return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
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
				"<cmd>FzfLua lsp_references<CR>",
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
				"<cmd>FzfLua lsp_definitions<CR>",
				vim.tbl_extend("force", opts, { desc = "LSP definitions" })
			)
			vim.keymap.set(
				"n",
				"gi",
				"<cmd>FzfLua lsp_implementations<CR>",
				vim.tbl_extend("force", opts, { desc = "LSP implementations" })
			)
			vim.keymap.set(
				"n",
				"gt",
				"<cmd>FzfLua lsp_typedefs<CR>",
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
				"<cmd>FzfLua diagnostics_document<CR>",
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

		local signs = { Error = "", Warn = "", Hint = "", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.diagnostic.config({
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

		local default_opts = {
			on_attach = on_attach,
			capabilities = capabilities,
		}

		lspconfig.lua_ls.setup(vim.tbl_extend("force", default_opts, {
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
		}))

		lspconfig.rust_analyzer.setup(vim.tbl_extend("force", default_opts, {
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
		}))

		lspconfig.gopls.setup(vim.tbl_extend("force", default_opts, {
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
		}))

		lspconfig.pyright.setup(vim.tbl_extend("force", default_opts, {
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
		}))

		lspconfig.ruff.setup(default_opts)

		lspconfig.ts_ls.setup(vim.tbl_extend("force", default_opts, {
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
		}))

		lspconfig.eslint.setup(default_opts)
		lspconfig.html.setup(default_opts)
		lspconfig.cssls.setup(default_opts)
		lspconfig.jsonls.setup(default_opts)

		lspconfig.tailwindcss.setup(vim.tbl_extend("force", default_opts, {
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
		}))

		lspconfig.emmet_ls.setup(vim.tbl_extend("force", default_opts, {
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
		}))

		lspconfig.dockerls.setup(default_opts)

		lspconfig.volar.setup(vim.tbl_extend("force", default_opts, {
			filetypes = { "vue", "javascript", "typescript" },
		}))
	end,
}
