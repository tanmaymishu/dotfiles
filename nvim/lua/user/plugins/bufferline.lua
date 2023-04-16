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
