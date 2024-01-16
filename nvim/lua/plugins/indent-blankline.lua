return {
	"lukas-reineke/indent-blankline.nvim",
	tag = "v2.20.8",
	opts = {},
	config = function()
		require("indent_blankline").setup({
			filetype_exclude = {
				"help",
				"terminal",
				"dashboard",
				"packer",
				"lspinfo",
				"TelescopePrompt",
				"TelescopeResults",
			},
			buftype_exclude = {
				"terminal",
				"NvimTree",
			},
		})
		-- vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#2F313C" })
	end,
}
