return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			direction = "vertical", -- 'vertical' | 'float' | 'tab'
			size = 70,
			open_mapping = [[<leader>th]],
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
		})
	end,
}
