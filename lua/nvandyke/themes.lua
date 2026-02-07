return vim.tbl_map(function(theme)
  if type(theme) == 'string' then
    theme = { theme }
  end
  theme.lazy = true
  return theme
end, {
  {
    'sainnhe/everforest',
    config = function()
      vim.g.everforest_better_performance = 1
      -- vim.g.everforest_transparent_background = 2
      -- vim.g.everforest_dim_inactive_windows = 1
    end,
  },
  {
    'rose-pine/neovim',
    config = function()
      require('rose-pine').setup {
        styles = {
          -- transparency = true,
        },
      }
    end,
  },
  'folke/tokyonight.nvim',
  'webhooked/kanso.nvim',
})
