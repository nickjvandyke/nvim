return {
  'echasnovski/mini.diff',
  event = 'BufReadPost',
  opts = {},
  keys = {
    {
      '<leader>go',
      function()
        require('mini.diff').toggle_overlay(0)
      end,
      desc = 'Toggle Diff Overlay',
    },
  },
}
