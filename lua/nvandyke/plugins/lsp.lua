return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason.nvim',
    },
    config = function()
      -- Extend lspconfig defaults
      -- Atm it doesn't support merging with lsp/<server>.lua

      -- https://writewithharper.com/docs/integrations/neovim
      -- TODO: How to add words to dictionary? "Thanh Thanh"
      vim.lsp.config('harper_ls', {
        filetypes = { 'markdown' },
        settings = {
          ['harper-ls'] = {
            linters = {
              -- SentenceCapitalization = false,
              SpellCheck = false,
            },
          },
        },
      })

      vim.lsp.config('yamlls', {
        settings = {
          yaml = {
            schemas = {
              ['https://json.schemastore.org/circleciconfig.json'] = '/.circleci/config.yml',
            },
          },
        },
      })

      -- Add --cache flag
      -- TODO: Verify it works. I don't see a .eslintcache file being created.
      -- WARNING: `eslint` needs to exist in `node_modules` or globally installed.
      -- Doesn't seem to cooperate with yarn v4 cache.
      vim.lsp.config('eslint', {
        cmd = { 'vscode-eslint-language-server', '--stdio', '--cache' },
      })

      vim.lsp.config('emmylua_ls', {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              requirePattern = {
                'lua/?.lua',
                'lua/?/init.lua',
                '?/lua/?.lua',
                '?/lua/?/init.lua',
              },
            },
            workspace = {
              library = {
                '$VIMRUNTIME',
                '$LLS_Addons/luvit',
                '$HOME/.local/share/nvim/lazy',
              },
              ignoreGlobs = { '**/*_spec.lua' },
            },
          },
        },
      })

      vim.lsp.enable {
        'lua_ls',
        -- 'emmylua_ls',
        'graphql',
        'terraformls',
        'intelephense',
        'cssls',
        'vue_ls',
        'basedpyright',
        'yamlls',
        'circleci',
        -- 'harper_ls',
        -- 'eslint',
        'tsgo',
      }

      -- vim.api.nvim_create_autocmd('BufWritePre', {
      --   pattern = { '*.js', '*.ts', '*.jsx', '*.tsx' },
      --   command = 'LspEslintFixAll',
      -- })

      -- FIX:
      -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
      --   silent = true,
      -- })

      vim.keymap.set('n', 'grn', function()
        vim.lsp.buf.rename()
      end, { desc = 'LSP Rename' })

      -- Depends on the theme, apparently
      -- vim.api.nvim_set_hl(0, 'VirtualTextError', { link = 'DiagnosticVirtualLinesError' })
      -- vim.api.nvim_set_hl(0, 'VirtualTextWarn', { link = 'DiagnosticVirtualLinesWarn' })
      -- vim.api.nvim_set_hl(0, 'VirtualTextInfo', { link = 'DiagnosticVirtualLinesInfo' })
      -- vim.api.nvim_set_hl(0, 'VirtualTextHint', { link = 'DiagnosticVirtualLinesHint' })

      vim.diagnostic.config {
        signs = {
          priority = 200,
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '󰠠',
          },
          -- linehl = {
          --   [vim.diagnostic.severity.ERROR] = 'Error',
          --   [vim.diagnostic.severity.WARN] = 'Warn',
          --   [vim.diagnostic.severity.INFO] = 'Info',
          --   [vim.diagnostic.severity.HINT] = 'Hint',
          -- },
        },
        -- virtual_text = {
        --   -- current_line = true,
        --   prefix = '',
        -- },
        virtual_lines = {
          current_line = true,
        },
        severity_sort = true,
        underline = true,
        float = {
          source = true,
        },
      }
    end,
  },
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    opts = {},
  },
  {
    'folke/lazydev.nvim',
    -- enabled = false, -- Doesn't work with emmylua_ls I think
    ft = 'lua',
    dependencies = {
      'Bilal2453/luvit-meta',
    },
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'lazy.nvim', words = { 'LazyVim' } },
      },
    },
  },
}
