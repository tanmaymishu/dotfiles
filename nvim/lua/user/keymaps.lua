-- Space is my leader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Always center the cursor when Ctrl-U and Ctrl-D is used.
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')

-- Disable annoying command line typo.
vim.keymap.set('n', 'q:', ':q')

-- Paste replace visual selection without copying it.
vim.keymap.set('v', 'p', '"_dP')

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set('i', ';;', '<Esc>A;')
vim.keymap.set('i', ',,', '<Esc>A,')

-- Get back to normal mode from insert mode etc
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'Jk', '<Esc>')
vim.keymap.set('i', 'jK', '<Esc>')
-- vim.keymap.set('v', 'jk', '<Esc>')
-- vim.keymap.set('v', 'Jk', '<Esc>')
-- vim.keymap.set('v', 'jK', '<Esc>')

-- Quickly clear search highlighting.
vim.keymap.set('n', '<Leader>k', ':nohlsearch<CR>')

-- Write to the file
vim.keymap.set('n', '<Leader>ss', ':w<CR>')
vim.keymap.set('v', '<Leader>ss', ':w<CR>')

-- Write to the file
vim.keymap.set('n', '<Leader>sa', ':wa<CR>')
vim.keymap.set('v', '<Leader>sa', ':wa<CR>')

-- Write to all files and exit
vim.keymap.set('n', '<Leader>se', ':wqa<CR>')
vim.keymap.set('v', '<Leader>se', ':wqa<CR>')

-- Quit without writing (Changes will be unsaved)
vim.keymap.set('n', '<Leader>qe', ':qa!<CR>')
vim.keymap.set('v', '<Leader>qe', ':qa!<CR>')

-- Open the current file in the default program (on Mac this should just be just `open`).
vim.keymap.set('n', '<Leader>x', ':!open %<CR><CR>')

-- Move lines up and down.
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('n', '<A-j>', ':move .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':move .-2<CR>==')
vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":move '<-2<CR>gv=gv")

-- prompt for a refactor to apply when the remap is triggered
vim.api.nvim_set_keymap(
    "v",
    "<leader>rr",
    ":lua require('refactoring').select_refactor()<CR>",
    { noremap = true, silent = true, expr = false }
)
