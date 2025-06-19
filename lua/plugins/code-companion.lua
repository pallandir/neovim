return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("codecompanion").setup({

			adapters = {
				anthropic = function()
					return require("codecompanion.adapters").extend("anthropic", {
						env = {
							api_key = "ANTHROPIC_API_KEY",
						},
					})
				end,
				openai = function()
					return require("codecompanion.adapters").extend("openai", {
						env = {
							api_key = "OPENAI_API_KEY",
						},
					})
				end,
			},

			default_adapter = "openai",

			strategies = {

				chat = {
					adapter = "openai",
					keymaps = {
						send = {
							modes = { n = "<CR>", i = "<C-s>" },
							index = 1,
							callback = "keymaps.send",
							description = "Send",
						},
						regenerate = {
							modes = { n = "gr" },
							index = 2,
							callback = "keymaps.regenerate",
							description = "Regenerate",
						},
						close = {
							modes = { n = "q" },
							index = 3,
							callback = "keymaps.close",
							description = "Close",
						},
					},
				},

				inline = {
					adapter = "openai",
					keymaps = {
						accept = {
							modes = { n = "ga" },
							callback = "keymaps.accept",
							description = "Accept suggestion",
						},
						reject = {
							modes = { n = "gr" },
							callback = "keymaps.reject",
							description = "Reject suggestion",
						},
					},
				},
			},

			prompt_library = {
				["Code review"] = {
					strategy = "chat",
					description = "Review the current buffer for code quality, bugs, and improvements",
					opts = {
						placement = "chat",
						type = "chat",
						start_in_insert_mode = false,
						short_name = "code_review",
					},
					prompts = {
						{
							role = "system",
							content = function()
								return table.concat({
									"You are an expert code reviewer. Please review the following code for:",
									"1. Code quality and best practices",
									"2. Potential bugs or issues",
									"3. Performance improvements",
									"4. Security concerns",
									"5. Readability and maintainability",
									"6. Suggestions for improvement",
									"",
									"Provide specific, actionable feedback with examples where appropriate.",
								}, "\n")
							end,
						},
						{
							role = "user",
							content = function()
								local buf = vim.api.nvim_get_current_buf()
								local content = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")
								local ft = vim.bo.filetype
								return ("Please review this %s code:\n\n```%s\n%s\n```"):format(ft, ft, content)
							end,
						},
					},
				},
				["Explain code"] = {
					strategy = "chat",
					description = "Explain what the selected code does",
					opts = {
						placement = "chat",
						type = "chat",
						user_prompt = false,
						stop_context_insertion = false,
						short_name = "explain_code",
					},
					prompts = {
						{
							role = "user",
							content = function()
								local selection = require("codecompanion.helpers.actions").get_selection()
								return "Please explain what this code does:\n\n```\n" .. selection .. "\n```"
							end,
						},
					},
				},
				["Optimize code"] = {
					strategy = "inline",
					description = "Suggest optimizations for the selected code",
					opts = {
						placement = "inline",
						type = "inline",
						diff = true,
						auto_submit = true,
						short_name = "optimize_code",
					},
					prompts = {
						{
							role = "system",
							content = "You are an expert programmer. Optimize the following code for performance, readability, and maintainability. Return only the optimized code without explanations.",
						},
						{
							role = "user",
							content = function()
								return require("codecompanion.helpers.actions").get_selection()
							end,
						},
					},
				},
				["Fix bugs"] = {
					strategy = "inline",
					description = "Find and fix potential bugs in the code",
					opts = {
						placement = "inline",
						type = "inline",
						diff = true,
						auto_submit = true,
						short_name = "fix_bugs",
					},
					prompts = {
						{
							role = "system",
							content = "You are an expert debugger. Fix any bugs or potential issues in the following code. Return only the corrected code without explanations.",
						},
						{
							role = "user",
							content = function()
								return require("codecompanion.helpers.actions").get_selection()
							end,
						},
					},
				},
			},

			display = {
				action_palette = {
					provider = "telescope",
				},
				chat = {
					window = {
						layout = "vertical",
						width = 0.45,
						height = 0.8,
					},
					show_settings = true,
				},
			},

			completion = {
				enabled = true,
			},

			log_level = "ERROR",
		})

		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true }

		keymap("n", "<leader>ar", function()
			vim.cmd("CodeCompanionActions")

			vim.defer_fn(function()
				require("codecompanion").prompt("code_review")
			end, 100)
		end, vim.tbl_extend("force", opts, { desc = "Auto Review Code" }))

		keymap(
			"n",
			"<leader>cc",
			"<cmd>CodeCompanionChat<cr>",
			vim.tbl_extend("force", opts, { desc = "Open CodeCompanion Chat" })
		)
		keymap(
			"v",
			"<leader>cc",
			"<cmd>CodeCompanionChat<cr>",
			vim.tbl_extend("force", opts, { desc = "Open CodeCompanion Chat with selection" })
		)
		keymap(
			"n",
			"<leader>ca",
			"<cmd>CodeCompanionActions<cr>",
			vim.tbl_extend("force", opts, { desc = "CodeCompanion Actions" })
		)
		keymap(
			"v",
			"<leader>ca",
			"<cmd>CodeCompanionActions<cr>",
			vim.tbl_extend("force", opts, { desc = "CodeCompanion Actions with selection" })
		)
		keymap(
			"n",
			"<leader>ct",
			"<cmd>CodeCompanionChat Toggle<cr>",
			vim.tbl_extend("force", opts, { desc = "Toggle CodeCompanion Chat" })
		)
		keymap(
			"n",
			"<leader>cf",
			"<cmd>CodeCompanionCmd<cr>",
			vim.tbl_extend("force", opts, { desc = "CodeCompanion Command" })
		)

		keymap("v", "<leader>ci", function()
			require("codecompanion").inline()
		end, vim.tbl_extend("force", opts, { desc = "CodeCompanion Inline" }))

		keymap("v", "<leader>ce", function()
			require("codecompanion").prompt("explain_code")
		end, vim.tbl_extend("force", opts, { desc = "Explain Selected Code" }))

		keymap("v", "<leader>co", function()
			require("codecompanion").prompt("optimize_code")
		end, vim.tbl_extend("force", opts, { desc = "Optimize Selected Code" }))

		keymap("v", "<leader>cb", function()
			require("codecompanion").prompt("fix_bugs")
		end, vim.tbl_extend("force", opts, { desc = "Fix Bugs in Selection" }))
	end,

	event = "VeryLazy",
	init = function()
		vim.defer_fn(function()
			if not pcall(require, "nvim-treesitter.parsers") then
				return
			end
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			if not parser_config.markdown then
				vim.cmd("TSInstall markdown")
			end
		end, 1000)
	end,
}
