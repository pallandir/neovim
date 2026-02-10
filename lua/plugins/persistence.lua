return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	keys = {
		{
			"<leader>wr",
			function()
				require("persistence").load()
			end,
			desc = "Restore session",
		},
		{
			"<leader>ws",
			function()
				require("persistence").select()
			end,
			desc = "Select session",
		},
		{
			"<leader>wl",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore last session",
		},
		{
			"<leader>wd",
			function()
				require("persistence").stop()
			end,
			desc = "Stop persistence",
		},
	},
}
