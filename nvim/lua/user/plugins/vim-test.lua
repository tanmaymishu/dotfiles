vim.keymap.set('n', '<Leader>tn', ':TestNearest<CR>')
vim.keymap.set('n', '<Leader>tf', ':TestFile<CR>')
vim.keymap.set('n', '<Leader>ts', ':TestSuite<CR>')
vim.keymap.set('n', '<Leader>tl', ':TestLast<CR>')
vim.keymap.set('n', '<Leader>tv', ':TestVisit<CR>')

-- vim.cmd([[
  -- function! FloatermStrategy(cmd)
    -- execute 'silent FloatermKill'
    -- execute 'FloatermNew! '.a:cmd.' |less -X'
  -- endfunction
  -- let g:test#custom_strategies = {'floaterm': function('FloatermStrategy')}
  -- let g:test#strategy = 'floaterm'
-- ]])
vim.cmd([[
  let g:tslime_always_current_session = 1
  let g:tslime_always_current_window = 1
  let g:tslime_autoset_pane = 1
  let g:test#strategy = 'tslime'
]])
