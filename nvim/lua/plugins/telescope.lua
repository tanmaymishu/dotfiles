return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "kyazdani42/nvim-web-devicons" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			telescope.setup({
				defaults = {
					path_display = { truncate = 1 },
					prompt_prefix = "   ",
					selection_caret = "  ",
					layout_config = {
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
					file_ignore_patterns = { ".git/", "node_modules/", "vendor/" },
				},
				pickers = {
					find_files = {
						hidden = true,
					},
					buffers = {
						previewer = false,
						layout_config = {
							width = 80,
						},
					},
					oldfiles = {
						prompt_title = "History",
					},
					lsp_references = {
						previewer = true,
					},
				},
			})
			telescope.load_extension("fzf")
			telescope.load_extension("live_grep_args")

			vim.keymap.set("n", "<leader>f", builtin.find_files, {})
			vim.keymap.set(
				"n",
				"<leader>F",
				[[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]]
			)
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>g", telescope.extensions.live_grep_args.live_grep_args, {})
			vim.keymap.set("n", "<leader>h", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>l", builtin.lsp_document_symbols, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
