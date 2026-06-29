return {
  'mikavilpas/yazi.nvim',
  cmd = 'Yazi',
  keys = {
    {
      '\\',
      '<cmd>Yazi<cr>',
      desc = 'Open Yazi at the current file',
    },
    -- {
    --   -- Open in the current working directory
    --   '<C-\\>',
    --   '<cmd>Yazi cwd<cr>',
    --   desc = 'Open yazi at neovim cwd',
    -- },
    {
      '|',
      '<cmd>Yazi toggle<cr>',
      desc = 'Resume the last Yazi session',
    },
  },
  opts = {
    keymaps = {
      show_help = '<f1>',
      open_file_in_horizontal_split = '<c-s>',
      grep_in_directory = false, -- attempts to use telescope
      close = 'q',
    },
  },
}
