return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local separator = { '"▏"', color = "PMenu" }

		require("lualine").setup({
			options = {
				section_separators = "",
				component_separators = "",
				globalstatus = true,
				theme = {
					normal = {
						a = "PMenu",
						b = "PMenu",
						c = "PMenu",
					},
				},
			},
			sections = {
				lualine_a = {
					"mode",
					separator,
				},
				lualine_b = {
					"branch",
					"diff",
					separator,
					'"  " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
					{ "diagnostics", sources = { "nvim_diagnostic" } },
					separator,
				},
				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 1,
					},
				},
				lualine_x = {
					"filetype",
					"encoding",
					"fileformat",
				},
				lualine_y = {
					separator,
					'(vim.bo.expandtab and "␠ " or "⇥ ") .. " " .. vim.bo.shiftwidth',
					separator,
				},
				lualine_z = {
					"location",
					"progress",
				},
			},
		})
	end,
}
