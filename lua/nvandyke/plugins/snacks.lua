return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    scroll = { enabled = true },
    input = {
      enabled = true,
    },
    bigfile = { enabled = true },
    -- WARNING: Breaks and issues tons of warnings in VSCode Neovim
    words = { enabled = true },
    statuscolumn = {
      enabled = true,
      folds = {
        -- open = true,
      },
    },
    notifier = { -- Used by noice
      top_down = false,
      style = 'compact',
    },
    zen = {
      toggles = {
        dim = false,
      },
      show = {
        statusline = true,
        tabline = true,
      },
    },
  },
  keys = {
    {
      '<leader>uz',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle Zen Mode',
    },
    {
      '<leader>bdc',
      function()
        Snacks.bufdelete.delete()
      end,
      desc = 'Delete current buffer',
    },
    {
      '<leader>bda',
      function()
        Snacks.bufdelete.all()
      end,
      desc = 'Delete all buffers',
    },
    {
      '<leader>bdo',
      function()
        Snacks.bufdelete.other()
      end,
      desc = 'Delete other buffers',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    -- {
    --   '<leader>S',
    --   function()
    --     Snacks.scratch.select()
    --   end,
    --   desc = 'Select Scratch Buffer',
    -- },
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
    },
  },
}
