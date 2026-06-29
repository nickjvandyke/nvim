return {
  {
    'zbirenbaum/copilot.lua',
    enabled = false,
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
      -- {
      --   'nvim-mini/mini.input',
      --   opts = {},
      -- },
      {
        'folke/snacks.nvim',
        optional = true,
        opts = {
          input = {
            enabled = true, -- Enhances `ask()`
          },
          picker = {
            enabled = true, -- Enhances `select()`
            actions = {
              ---@param picker snacks.Picker
              opencode_send = function(picker)
                local items = vim.tbl_map(function(item) ---@param item snacks.picker.Item
                  return item.file and require('opencode').format { path = item.file, from = item.pos, to = item.end_pos } or item.text
                end, picker:selected { fallback = true })

                require('opencode').prompt(table.concat(items, ', ') .. ' ')
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
        },
      },
    },
    config = function()
      local opencode_cmd = 'opencode --port'
      ---@type snacks.terminal.Opts
      local snacks_terminal_opts = {
        win = {
          position = 'right',
          enter = false,
        },
      }
      vim.keymap.set({ 'n', 't' }, '<C-.>', function()
        require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
      end, { desc = 'Toggle opencode' })
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        contexts = {
          ['@grapple'] = function()
            local is_available, grapple = pcall(require, 'grapple')
            if not is_available then
              return nil
            end
            local tags = grapple.tags()
            if not tags or #tags == 0 then
              return nil
            end
            local paths = {}
            for _, tag in ipairs(tags) do
              table.insert(paths, require('opencode.context').format { path = tag.path })
            end
            return table.concat(paths, ', ')
          end,
        },
        -- stylua: ignore
        server = {
          -- url = "http://localhost:4096",
          -- start = function()
          --   require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
          -- end,
          -- start = false
        },
        ask = {
          -- snacks = {
          --   icon = "💬 ",
          -- }
        },
        select = {
          prompts = {
            -- code_reviewer = '@code-reviewer Review @buffer',
            -- append = 'meow space ',
          },
          commands = {
            -- ['meowwww'] = 'MEOW MEOW',
            -- ['session.list'] = 'List Sessions',
          },
        },
        events = {
          permissions = {
            enabled = true,
            edits = {
              enabled = true,
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
        require('opencode').ask '@this: '
      end, { desc = 'Ask opencode…' })

      vim.keymap.set({ 'n', 'x' }, '<C-x>', function()
        require('opencode').select()
      end, { desc = 'Execute opencode action…' })

      vim.keymap.set({ 'n', 't' }, '<S-C-u>', function()
        require('opencode').command 'session.half.page.up'
      end, { desc = 'opencode half page up' })
      vim.keymap.set({ 'n', 't' }, '<S-C-d>', function()
        require('opencode').command 'session.half.page.down'
      end, { desc = 'opencode half page down' })

      -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
      vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
      vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })

      vim.api.nvim_create_autocmd('User', {
        pattern = { 'OpencodeEvent:tui.command.execute' },
        callback = function(args)
          ---@type opencode.server.Event
          local event = args.data.event
          if event.properties.command == 'prompt.submit' then
            local win = require('snacks.terminal').get(opencode_cmd, { create = false })
            if win then
              win:show()
            end
          end
        end,
      })
    end,
  },
}
