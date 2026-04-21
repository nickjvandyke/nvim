return {
  'folke/flash.nvim',
  enabled = false,
  ---@type Flash.Config
  opts = {
    -- search = {
    --   max_length = 1,
    -- },
    highlight = {
      backdrop = false,
    },
    label = {
      rainbow = {
        enabled = true,
      },
    },
    modes = {
      treesitter = {
        -- This breaks the `treesitter` mode's selection
        -- jump = { pos = 'start' },
      },
      -- char = {
      --   highlight = {
      --     backdrop = false,
      --   },
      -- },
    },
    prompt = {
      enabled = false, -- looks bad until it properly supports the new vim.o.winborder
    },
  },
  keys = {
    -- TODO: have to wait for timeoutlen when using `ys` or `yS` because of nvim-surround `ys` mapping
    {
      's',
      mode = { 'n', 'o', 'v' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'S',
      -- No 'x' mode because it conflicts with nvim-surround and seems kinda useless anyway (maybe I'm using it wrong)
      mode = { 'n', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Treesitter Flash',
    },
    {
      'R',
      mode = 'n',
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      'R',
      mode = 'o',
      function()
        require('flash').treesitter_search {
          remote_op = {
            restore = true,
            motion = true,
          },
        }
      end,
      desc = 'Remote Treesitter Search',
    },
    -- '/',
    -- '?',
    'f',
    'F',
    't',
    'T',
  },
}
