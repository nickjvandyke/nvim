return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'BufReadPost',
  opts = {
    multiwindow = true,
    line_numbers = vim.o.number or vim.o.relativenumber,
    multiline_threshold = 3,
  },
  keys = {
    {
      '[c',
      function()
        require('treesitter-context').go_to_context()
      end,
    },
  },
  config = function(_, opts)
    require('treesitter-context').setup(opts)

    -- vim.api.nvim_set_hl(0, 'TreesitterContext', { link = 'None' })
    -- vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true })
    -- vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { link = 'None' })
    -- vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { underline = true })
  end,
}
