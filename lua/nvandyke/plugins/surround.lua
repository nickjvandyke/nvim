return {
  'nvim-mini/mini.surround',
  opts = {
    mappings = {
      add = 'ys', -- Add surrounding in Normal and Visual modes
      delete = 'ds', -- Delete surrounding.
      find = 'gs', -- Find surrounding (to the right)
      find_left = 'gS', -- Find surrounding (to the left)
      highlight = 'gsh', -- Highlight surrounding
      replace = 'cs', -- Replace surrounding
    },
  },
}
