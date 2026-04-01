return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  init = function()
    -- TODO: Migrate Wanna to use .sql... don't think .psql is a legit thing
    vim.treesitter.language.register('sql', 'psql')
  end,
  config = function(_, opts)
    require('nvim-treesitter').install {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'php',
      'graphql',
      'query',
      'vim',
      'vimdoc',
      'terraform',
      'json',
      'yaml',
      'sql',
      'regex',
      'blade',
      'javascript',
      'jsx',
      'typescript',
      'tsx',
    }

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        -- Errors for filetypes with no parser
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
