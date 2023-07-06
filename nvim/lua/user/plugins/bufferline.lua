require('bufferline').setup({
  options = {
    indicator = {
      icon = ' ',
    },
    show_close_icon = false,
    tab_size = 0,
    max_name_length = 25,
    offsets = {
      {
        filetype = 'NvimTree',
        text = '  Files',
        -- highlight = 'StatusLine',
        text_align = 'left',
      },
    },
    -- separator_style = 'slant',
    -- modified_icon = '',
    custom_areas = {
      left = function()
        return {
          { text = '    ', fg = '#eeeeee' },
        }
      end,
    },
  },
  -- highlights = {
  --   close_button = {
  --     bg = { attribute = 'bg', highlight = '#ffffff' },
  --     fg = { attribute = 'fg', highlight = '#000000' },
  --   },
  --   separator = {
  --     fg = { attribute = 'bg', highlight = '#ffffff' },
  --     bg = { attribute = 'bg', highlight = '#ffffff' },
  --   },
  --   background = {
  --     bg = { attribute = 'bg', highlight = '#ffffff' },
  --   },
  --   fill = {
  --     bg = { attribute = 'bg', highlight = 'PMenu' },
  --   },
  -- },
})

vim.api.nvim_set_keymap('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>5', ':BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>6', ':BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>7', ':BufferLineGoToBuffer 7<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>8', ':BufferLineGoToBuffer 8<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>9', ':BufferLineGoToBuffer 9<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>0', ':BufferLineGoToBuffer 10<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>Q', ':BufferLineCloseLeft<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>W', ':BufferLineCloseRight<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wq', ':BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>:Bdelete<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>]', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>[', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>}', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>{', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>~', ':BufferLinePick<CR>', { noremap = true, silent = true })

