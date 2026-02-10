return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
	cmd = "FzfLua",
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files" },
		{ "<leader>fr", "<cmd>FzfLua oldfiles<CR>", desc = "Recent files" },
		{ "<leader>fs", "<cmd>FzfLua live_grep<CR>", desc = "Live grep" },
		{ "<leader>fc", "<cmd>FzfLua grep_cword<CR>", desc = "Grep word under cursor" },
		{ "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Find buffers" },
		{ "<leader>fh", "<cmd>FzfLua help_tags<CR>", desc = "Help tags" },
		{ "<leader>fk", "<cmd>FzfLua keymaps<CR>", desc = "Keymaps" },
		{ "<leader>fd", "<cmd>FzfLua diagnostics_document<CR>", desc = "Document diagnostics" },
		{ "<leader>fD", "<cmd>FzfLua diagnostics_workspace<CR>", desc = "Workspace diagnostics" },
	},
	config = function()
		local fzf = require("fzf-lua")
		local actions = require("fzf-lua.actions")

		fzf.setup({
			"default-title",
			fzf_colors = true,
			fzf_opts = {
				["--no-scrollbar"] = true,
			},
			defaults = {
				formatter = "path.dirname_first",
			},
			winopts = {
				width = 0.8,
				height = 0.8,
				row = 0.5,
				col = 0.5,
				preview = {
					scrollchars = { "┃", "" },
				},
			},
			files = {
				cwd_prompt = false,
				actions = {
					["alt-i"] = { actions.toggle_ignore },
					["alt-h"] = { actions.toggle_hidden },
				},
			},
			grep = {
				actions = {
					["alt-i"] = { actions.toggle_ignore },
					["alt-h"] = { actions.toggle_hidden },
				},
			},
			lsp = {
				symbols = {
					symbol_hl = function(s)
						return "TroubleIcon" .. s
					end,
					symbol_fmt = function(s)
						return s:lower() .. "\t"
					end,
					child_prefix = false,
				},
				code_actions = {
					previewer = "codeaction_native",
				},
			},
		})

		fzf.register_ui_select()
	end,
}
