return {
  'yorickpeterse/nvim-jump',
  keys = {
    {
      's',
      function()
        require('jump').start()
      end,
      mode = { 'n', 'x', 'o' },
      desc = 'Jump to a position in the buffer',
    },
  },
}
