return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local ts_configs = require("nvim-treesitter.configs")
		ts_configs.setup({
			auto_installed = true,
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"go",
				"javascript",
				"typescript",
				"php",
				"templ",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*.templ",
			callback = function()
				vim.cmd("TSBufEnable highlight")
			end,
		})
	end,
}
