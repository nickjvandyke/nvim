return {
  'stevearc/quicker.nvim',
  event = 'FileType qf',
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    opts = {
      signcolumn = 'yes',
      winfixheight = true,
    },
    edit = {
      autosave = true,
    },
    highlight = {
      -- Better highlighting
      -- load_buffers = true,
    },
    follow = {
      enable = true,
    },
    keys = {
      {
        '>',
        function()
          require('quicker').expand { before = 2, after = 2, add_to_existing = true }
        end,
        desc = 'Expand quickfix context',
      },
      {
        '<',
        function()
          require('quicker').collapse()
        end,
        desc = 'Collapse quickfix context',
      },
    },
  },
  keys = {
    {
      '<leader>qf',
      function()
        require('quicker').toggle()
      end,
      desc = 'Toggle quickfix',
    },
    {
      '<leader>ql',
      function()
        require('quicker').toggle { loclist = true }
      end,
      desc = 'Toggle loclist',
    },
  },
}
