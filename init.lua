-- I hope you enjoy your Neovim journey,
-- - TJ

require 'nvandyke.options'
require 'nvandyke.maps'
require 'nvandyke.commands'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath 'data' .. '/lazy/snacks.nvim'
  vim.opt.rtp:append(snacks)
  ---@diagnostic disable-next-line: missing-fields
  require('snacks.profiler').startup {
    startup = {
      event = 'VimEnter', -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  }
end

require('lazy').setup({
  { import = 'nvandyke.plugins' },
  { import = 'nvandyke.themes' },
}, {
  ui = {
    border = vim.o.winborder,
    icons = {},
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'osc52',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
        'rplugin',
      },
    },
  },
})

vim.cmd 'colorscheme everforest'

-- -- ❌ Inefficient, unreliable
-- require('your-plugin').setup {}
--
-- -- ✅ Instant, "just works"
-- vim.g.your_plugin_opts = {}
