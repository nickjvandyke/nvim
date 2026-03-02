return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<c-f>',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      desc = 'Format',
    },
  },
  opts = {
    -- format_on_save = function()
    --   if vim.g.disable_autoformat then
    --     return
    --   end
    --   return {
    --     -- timeout_ms = 200,
    --     lsp_format = 'fallback',
    --     stop_after_first = true,
    --     quiet = true,
    --     -- Exclude the format from the undotree. Specifically, that's annoying with auto-save and auto-format
    --     undojoin = true,
    --   }
    -- end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black', lsp_format = 'fallback', stop_after_first = true },
      javascript = { 'prettierd', lsp_format = 'fallback', stop_after_first = true },
      typescript = { 'prettierd', lsp_format = 'fallback', stop_after_first = true },
      javascriptreact = { 'prettierd', lsp_format = 'fallback', stop_after_first = true },
      typescriptreact = { 'prettierd', lsp_format = 'fallback', stop_after_first = true },
      html = { 'prettierd', lsp_format = 'fallback', stop_after_first = true },
      sql = { 'sqlfmt', lsp_format = 'never', stop_after_first = true },
      terraform = { lsp_format = 'always', stop_after_first = true },
      markdown = { 'prettierd', lsp_format = 'fallback', stop_after_first = true },
    },
  },
}
