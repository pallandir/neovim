return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.icons",
	},
	ft = { "markdown" },
	opts = {
		file_types = { "markdown" },
		completions = { lsp = { enabled = true } },
		latex = { enabled = false },
	},
}
