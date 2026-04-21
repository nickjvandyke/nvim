return {
  'folke/snacks.nvim',
  opts = {
    notifier = {
      margin = { right = 0, bottom = 0 },
    },
    styles = {
      notification_history = {
        -- position = 'bottom',
        -- height = 10,
      },
    },
  },
  config = function(_, opts)
    require('snacks').setup(opts)
  end,
  keys = {
    {
      '<leader>sn',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Notifications',
    },
  },
}
