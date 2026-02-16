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
    'NickvanDyke/opencode.nvim',
    dir = '~/dev/opencode.nvim',
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional.
        ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
        'folke/snacks.nvim',
        optional = true,
        opts = {
          -- Enhances `ask()`.
          input = {},
          -- Enhances `select()`.
          picker = {
            actions = {
              opencode_send = function(...)
                return require('opencode').snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
                },
              },
            },
          },
          -- Enables the `snacks` provider.
          terminal = {},
        },
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- port = 54403,
        prompts = {
          code_reviewer = { prompt = 'Review @buffer @code-reviewer', submit = true },
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
              -- ['meowwww'] = 'MEOW MEOW',
              -- ['session.list'] = 'List Sessions',
            },
          },
        },
        provider = {
          enabled = 'snacks',
          snacks = {
            auto_insert = true,
            win = {
              -- position = 'left'
            },
          },
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
