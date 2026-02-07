return {
  'folke/snacks.nvim',
  ---@type snacks.terminal.Opts
  opts = {
    terminal = {
      -- auto_insert = false,
      win = {
        wo = {
          winbar = '',
          -- winhighlight = 'Normal:Normal',
        },
        border = vim.o.winborder,
      },
      keys = {
        -- default, but don't hide self
        gf = function()
          local f = vim.fn.findfile(vim.fn.expand '<cfile>', '**')
          if f == '' then
            Snacks.notify.warn 'No file under cursor'
          else
            vim.schedule(function()
              vim.cmd('e ' .. f)
            end)
          end
        end,
      },
    },
  },
  keys = {
    {
      '<c-\\>',
      function()
        Snacks.terminal.toggle()
      end,
      desc = 'Toggle terminal',
      mode = { 'n', 't' },
    },
    -- {
    --   '<leader>tf',
    --   function()
    --     Snacks.terminal.toggle(nil, {
    --       env = {
    --         -- So Snacks IDs it differently
    --         floating = 'true',
    --       },
    --       win = {
    --         position = 'float',
    --       },
    --     })
    --   end,
    --   desc = 'Toggle floating terminal',
    --   mode = 'n',
    -- },
    {
      '<s-c-\\>',
      function()
        Snacks.terminal.open()
      end,
      desc = 'Open new terminal',
      mode = { 'n', 't' },
    },
  },
}
