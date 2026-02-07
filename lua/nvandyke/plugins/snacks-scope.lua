return {
  'folke/snacks.nvim',
  opts = {
    -- Indent/scope guide
    indent = {
      indent = {
        only_scope = true,
      },
    },
    -- Scope-based movements and textobjects
    scope = {
      -- The textobjects ignore cursor column;
      -- ignore it for the scope guide too so we know what we'll select
      cursor = false,
      -- filter = function()
      --   -- It works weirdly in markdown
      --   return vim.bo.filetype ~= 'markdown'
      -- end,
      keys = {
        textobject = {
          ii = {
            linewise = true,
          },
          ai = {
            linewise = true,
          },
        },
      },
    },
  },
}
