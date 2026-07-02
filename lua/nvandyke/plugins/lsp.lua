return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Extend lspconfig defaults
      -- Atm it doesn't support merging with lsp/<server>.lua

      -- https://writewithharper.com/docs/integrations/neovim
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

      vim.lsp.config('emmylua_ls', {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              requirePattern = {
                'lua/?.lua',
                'lua/?/init.lua',
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
        'basedpyright',
        'yamlls',
        'circleci',
        -- 'harper_ls',
        'tsgo',
        'eslint',
        'cssls',
        'vue_ls',
      }

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
        jump = {
          -- severity = { min = vim.diagnostic.severity.WARN },
        },
      }
    end,
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup {
        options = {
          use_icons_from_diagnostic = true,
          show_source = {
            enabled = true,
          },
        },
      }
      vim.diagnostic.config { virtual_text = false, virtual_lines = false } -- Disable Neovim's default virtual text diagnostics
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    dependencies = {
      'Bilal2453/luvit-meta',
    },
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        -- { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'lazy.nvim', words = { 'LazyVim' } },
      },
    },
  },
  {
    'rachartier/tiny-code-action.nvim',
    event = 'LspAttach',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'folke/snacks.nvim' },
    },
    opts = {
      backend = 'delta',
      picker = 'snacks',
    },
  },
  {
    'rmagatti/goto-preview',
    enabled = false,
    opts = {
      default_mappings = false,
      focus_on_open = false,
      dismiss_on_move = true,
      border = { '↖', '─', '╮', '│', '╯', '─', '╰', '│' },
      vim_ui_input = false,
    },
    config = true,
    keys = {
      {
        'gpd',
        function()
          require('goto-preview').goto_preview_definition()
        end,
        desc = 'Preview Definition',
      },
      {
        'gpD',
        function()
          require('goto-preview').goto_preview_declaration {}
        end,
        desc = 'Preview Declaration',
      },
      {
        'gpt',
        function()
          require('goto-preview').goto_preview_type_definition {}
        end,
        desc = 'Preview Type Definition',
      },
      {
        'gpr',
        function()
          require('goto-preview').goto_preview_references()
        end,
        desc = 'Preview References',
      },
      {
        'gpi',
        function()
          require('goto-preview').goto_preview_implementation {}
        end,
        desc = 'Preview Implementation',
      },
    },
  },
}
