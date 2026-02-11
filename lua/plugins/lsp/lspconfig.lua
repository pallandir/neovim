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
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Configure LSP keybindings on attach
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)

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
			end,
		})

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
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})

		-- Configure servers
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
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
			capabilities = capabilities,
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
			capabilities = capabilities,
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
			capabilities = capabilities,
			before_init = function(_, config)
				local venv = vim.fn.getcwd() .. "/.venv"
				if vim.fn.isdirectory(venv) == 1 then
					config.settings.python.pythonPath = venv .. "/bin/python"
				end
			end,
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						useLibraryCodeForTypes = true,
						typeCheckingMode = "basic",
					},
					venvPath = ".",
					venv = ".venv",
				},
			},
		})

		vim.lsp.config("ruff", { capabilities = capabilities })

		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
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

		vim.lsp.config("eslint", { capabilities = capabilities })
		vim.lsp.config("html", { capabilities = capabilities })
		vim.lsp.config("cssls", { capabilities = capabilities })
		vim.lsp.config("jsonls", { capabilities = capabilities })

		vim.lsp.config("tailwindcss", {
			capabilities = capabilities,
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

		vim.lsp.config("emmet_ls", {
			capabilities = capabilities,
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

		vim.lsp.config("dockerls", { capabilities = capabilities })

		vim.lsp.config("vue_ls", {
			capabilities = capabilities,
			filetypes = { "vue", "javascript", "typescript" },
		})

		-- Enable all servers
		local servers = {
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
		}

		for _, server in ipairs(servers) do
			vim.lsp.enable(server)
		end
	end,
}
