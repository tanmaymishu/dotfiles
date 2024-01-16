return {
	-- For smooth scrolling
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},
	-- Commenting support.
	{ "tpope/vim-commentary" },
	-- Add, change, and delete surrounding text.
	{ "tpope/vim-surround" },
	-- Useful commands like :Rename and :SudoWrite.
	{ "tpope/vim-eunuch" },
	-- Pairs of handy bracket mappings, like [b and ]b.
	{ "tpope/vim-unimpaired" },
	-- Indent autodetection with editorconfig support.
	{ "tpope/vim-sleuth" },
	-- Allow plugins to enable repeating of commands.
	{ "tpope/vim-repeat" },
	-- Navigate seamlessly between Vim windows and Tmux panes.
	{ "christoomey/vim-tmux-navigator" },
	-- Jump to the last location when opening a file.
	{ "farmergreg/vim-lastplace" },
	-- Enable * searching with visually selected text.
	{ "nelstrom/vim-visual-star-search" },
	-- Automatically create parent dirs when saving.
	{ "jessarcher/vim-heritage" },
	-- Text objects for HTML attributes.
	{
		"whatyouhide/vim-textobj-xmlattr",
		dependencies = { "kana/vim-textobj-user" },
	},
	-- Automatically set the working directory to the project root.
	{
		"airblade/vim-rooter",
		setup = function()
			-- Instead of this running every time we open a file, we'll just run it once when Vim starts.
			vim.g.rooter_manual_only = 1
		end,
		config = function()
			vim.cmd("Rooter")
		end,
	},
	-- Automatically add closing brackets, quotes, etc.
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	-- All closing buffers without closing the split window.
	{
		"famiu/bufdelete.nvim",
		config = function()
			local bufdelete = require("bufdelete")
			vim.keymap.set("n", "<Leader>q", ":Bdelete<CR>")
			-- Function to delete all buffers
			function delete_all_buffers()
				-- Get a list of all buffer handles
				local buffers = vim.api.nvim_list_bufs()

				-- Get the Neotree buffer name or pattern
				local neotree_pattern = "neo-tree filesystem"

				-- Iterate through the list and delete each buffer (except Neotree buffer)
				for _, buf in ipairs(buffers) do
					local buf_name = vim.api.nvim_buf_get_name(buf)

					-- Check if the buffer is not the current buffer and does not match Neotree pattern
					if not string.find(buf_name, neotree_pattern) then
						-- Wipe out the buffer
						vim.api.nvim_buf_delete(buf, { force = true })
					end
				end
			end

			vim.keymap.set("n", "<Leader>wq", ":lua delete_all_buffers()<CR>")
		end,
	},
	-- Split arrays and methods onto multiple lines, or join them back up.
	{
		"AndrewRadev/splitjoin.vim",
		config = function()
			vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
			vim.g.splitjoin_trailing_comma = 1
			vim.g.splitjoin_php_method_chain_full = 1
		end,
	},
	-- Automatically fix indentation when pasting code.
	{
		"sickill/vim-pasta",
		config = function()
			vim.g.pasta_disabled_filetypes = { "fugitive" }
		end,
	},
}
