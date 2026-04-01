return {
  'aaronik/treewalker.nvim',
  opts = {
    highlight = true,
  },
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
    },
  },
  keys = {
    { mode = { 'n', 'v' }, '<C-j>', '<cmd>Treewalker Down<CR>', noremap = true, silent = true },
    { mode = { 'n', 'v' }, '<C-k>', '<cmd>Treewalker Up<CR>', noremap = true, silent = true },
    { mode = { 'n', 'v' }, '<C-h>', '<cmd>Treewalker Left<CR>', noremap = true, silent = true },
    { mode = { 'n', 'v' }, '<C-l>', '<cmd>Treewalker Right<CR>', noremap = true, silent = true },
    { mode = 'n', '<C-S-k>', '<cmd>Treewalker SwapUp<CR>', noremap = true, silent = true },
    { mode = 'n', '<C-S-j>', '<cmd>Treewalker SwapDown<CR>', noremap = true, silent = true },
    { mode = 'n', '<C-S-h>', ':TSTextobjectSwapPrevious @parameter.inner<CR>', noremap = true, silent = true },
    { mode = 'n', '<C-S-l>', ':TSTextobjectSwapNext @parameter.inner<CR>', noremap = true, silent = true },
  },
}
