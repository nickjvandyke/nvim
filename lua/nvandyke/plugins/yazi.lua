return {
  'mikavilpas/yazi.nvim',
  enabled = false,
  cmd = 'Yazi',
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      '\\',
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
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
      desc = 'Resume the last yazi session',
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
