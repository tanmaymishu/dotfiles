-- return {
-- 	"github/copilot.vim",
-- 	config = function()
-- 		vim.g.copilot_no_tab_map = true
-- 		vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
-- 	end,
-- }

return {
	'Exafunction/codeium.vim',
	config = function()
		vim.keymap.set('n', '<C-g>', function() return vim.fn['codeium#Chat']() end, { expr = true, silent = true })
		vim.keymap.set('i', '<C-j>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
		vim.keymap.set('i', '<c-k>', function() return vim.fn['codeium#CycleCompletions'](1) end,
			{ expr = true, silent = true })
		vim.keymap.set('i', '<c-l>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
			{ expr = true, silent = true })
		vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
	end
}
