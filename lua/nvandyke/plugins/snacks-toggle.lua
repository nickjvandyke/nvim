return {
  'folke/snacks.nvim',
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        Snacks.toggle.diagnostics():map '<leader>uD'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
        Snacks.toggle.treesitter():map '<leader>uT'
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
        Snacks.toggle.inlay_hints():map '<leader>uh'
        Snacks.toggle.indent():map '<leader>uG'
        Snacks.toggle.dim():map '<leader>ud'
        Snacks.toggle.scroll():map '<leader>uS'
        Snacks.toggle.zen():map '<leader>uz'
        Snacks.toggle
          .new({
            id = 'autosave',
            name = 'Autosave',
            get = function()
              return not vim.g.disable_autosave
            end,
            set = function(state)
              vim.g.disable_autosave = not state
            end,
          })
          :map '<leader>us'
        Snacks.toggle
          .new({
            id = 'autoformat',
            name = 'Autoformat',
            get = function()
              return not vim.g.disable_autoformat
            end,
            set = function(state)
              vim.g.disable_autoformat = not state
            end,
          })
          :map '<leader>uf'
        Snacks.toggle
          .new({
            id = 'showkeys',
            name = 'Showkeys',
            get = function()
              return require('showkeys.state').visible
            end,
            set = function(state)
              require('showkeys').toggle()
            end,
          })
          :map '<leader>uK'

        local pairingToggles = {
          -- 'scroll',
          'showkeys',
          -- 'dim',
          'line_number',
        }
        Snacks.toggle
          .new({
            name = 'Pairing',
            get = function()
              local state = true
              for _, id in ipairs(pairingToggles) do
                state = state and Snacks.toggle.get(id):get()
              end
              return state
            end,
            set = function(state)
              for _, id in ipairs(pairingToggles) do
                Snacks.toggle.get(id):set(state)
              end
            end,
          })
          :map '<leader>up'
      end,
    })
  end,
}
