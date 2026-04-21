return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        auto_trigger = true,
        hide_during_completion = false,
        keymap = {
          accept = '<Tab>',
          accept_line = '<S-Tab>',
        },
      },
    },
  },
  {
    'nickjvandyke/opencode.nvim',
    -- version = "*",
    dir = '~/dev/opencode.nvim',
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional.
        'folke/snacks.nvim',
        optional = true,
        ---@module 'snacks'
        ---@type snacks.Config
        opts = {
          -- Enhances `ask()`
          input = { enabled = true },
          -- Enhances `select()`
          picker = {
            enabled = true,
            win = { input = { keys = { ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } } } } },
            actions = {
              opencode_send = function(...)
                return require('opencode').snacks_picker_send(...)
              end,
            },
          },
        },
      },
      -- {
      --   'saghen/blink.cmp',
      --   optional = true,
      --   ---@module 'blink.cmp'
      --   ---@type blink.cmp.Config
      --   opts = {
      --     sources = {
      --       per_filetype = {
      --         opencode_ask = {
      --           'lsp',
      --           'buffer',
      --         },
      --       },
      --       providers = { lsp = { fallbacks = {} } },
      --     },
      --     -- TODO: Possible to register LSP here? Or at least the omnifunc?
      --     cmdline = {
      --       enabled = true,
      --       sources = {
      --         'omni',
      --       },
      --     },
      --   },
      -- },
      -- {
      --   'nvim-lualine/lualine.nvim',
      --   optional = true,
      --   opts = {
      --     sections = {
      --       lualine_z = {
      --         {
      --           -- TODO: Why doesn't this merge correctly?
      --           function()
      --             return require('opencode').statusline()
      --           end,
      --         },
      --       },
      --     },
      --   },
      -- },
    },
    config = function()
      local cmd = 'opencode --port 54403'
      ---@type snacks.terminal.Opts
      local snacks_terminal_opts = {
        win = {
          position = 'right',
          enter = false,
          on_win = function(win)
            -- Setup keymaps and cleanup for an arbitrary terminal
            require('opencode.terminal').setup(win.win)
          end,
        },
      }
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- stylua: ignore
        -- server = {
        -- -- start = false,
        -- start = function()
        --   require('snacks.terminal').open(cmd, snacks_terminal_opts)
        -- end,
        -- stop = function()
        --   require('snacks.terminal').get(cmd, snacks_terminal_opts):close()
        -- end,
        -- toggle = function()
        --   require('snacks.terminal').toggle(cmd, snacks_terminal_opts)
        -- end,
        --  },
        prompts = {
          code_reviewer = { prompt = '@code-reviewer Review @buffer', submit = true },
        },
        ask = {
          -- snacks = {
          --   icon = "💬 ",
          -- }
        },
        select = {
          -- prompt = 'meow',
          sections = {
            commands = {
              ['meowwww'] = 'MEOW MEOW',
              -- ['session.list'] = 'List Sessions',
            },
          },
        },
        lsp = {
          enabled = true,
          handlers = {
            hover = {
              model = 'github-copilot/gpt-4.1',
            },
          },
        },
        permissions = {
          enabled = false,
        },
      }

      -- Required for `opts.auto_reload`
      vim.opt.autoread = true

      vim.keymap.set({ 'n', 'x' }, 'go', function()
        return require('opencode').operator '@this '
      end, { expr = true, desc = 'Add range to opencode' })
      vim.keymap.set('n', 'goo', function()
        return require('opencode').operator '@this ' .. '_'
      end, { expr = true, desc = 'Add line to opencode' })

      -- Recommended/example keymaps.
      vim.keymap.set({ 'n', 'x' }, '<C-a>', function()
        require('opencode').ask('@this: ', { submit = true })
      end, { desc = 'Ask opencode' })
      vim.keymap.set({ 'n', 'x' }, '<C-x>', function()
        require('opencode').select()
      end, { desc = 'Execute opencode action…' })

      vim.keymap.set({ 'n', 't' }, '<C-.>', function()
        require('opencode').toggle()
      end, { desc = 'Toggle opencode' })
      vim.keymap.set({ 'n', 't' }, '<S-C-u>', function()
        require('opencode').command 'session.half.page.up'
      end, { desc = 'opencode half page up' })
      vim.keymap.set({ 'n', 't' }, '<S-C-d>', function()
        require('opencode').command 'session.half.page.down'
      end, { desc = 'opencode half page down' })

      -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
      vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
      vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
    end,
  },
}
