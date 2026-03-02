return {
  'folke/snacks.nvim',
  opts = {
    dashboard = {
      preset = {
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          -- { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = '/', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          -- { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = ' ',
            key = 'c',
            desc = 'Search Config',
            action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') .. '/..', hidden = true })",
          },
          { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
        { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        -- { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        { section = 'startup' },
      },
    },
  },
}
