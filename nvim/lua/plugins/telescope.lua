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
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "TelescopeResults",
				callback = function(ctx)
					vim.api.nvim_buf_call(ctx.buf, function()
						vim.fn.matchadd("TelescopeParent", "\t\t.*$")
						vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
					end)
				end,
			})

			local function filenameFirst(_, path)
				local tail = vim.fs.basename(path)
				local parent = vim.fs.dirname(path)
				if parent == "." then return tail end
				return string.format("%s\t\t%s", tail, parent)
			end
			telescope.setup({
				defaults = {
					path_display = { truncate = 1 },
					prompt_prefix = "   ",
					selection_caret = "  ",
					sorting_strategy = "ascending",
					file_ignore_patterns = { ".git/", "node_modules/" },
					wrap_results = true,
					layout_config = {
						prompt_position = "top",
						vertical = { width = { padding = 0 } },
						horizontal = { width = { padding = 0 } },
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						path_display = filenameFirst,
					},
					buffers = {
						previewer = false,
					},
					oldfiles = {
						prompt_title = "History",
					},
					lsp_references = {
						previewer = true,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					live_grep_args = {
						auto_quoting = true,
					},
				},
			})
			telescope.load_extension("fzf")
			telescope.load_extension("live_grep_args")

			vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, {})
			vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations, {})

			vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>")
			vim.keymap.set("n", "gr", ":Telescope lsp_references show_line=false<CR>")

			vim.keymap.set("n", "<leader>f", builtin.find_files, {})
			vim.keymap.set(
				"n",
				"<leader>F",
				[[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]]
			)
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>gs", telescope.extensions.live_grep_args.live_grep_args, {})
			vim.keymap.set("n", "<leader>gc", require("telescope-live-grep-args.shortcuts").grep_word_under_cursor, {})
			vim.keymap.set("n", "<leader>h", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>ld", builtin.lsp_dynamic_workspace_symbols, {})
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
