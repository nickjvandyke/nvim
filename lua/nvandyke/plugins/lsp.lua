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

      -- vim.lsp.config('tsgo', {
      --   settings = {
      --     cmd = { 'tsgo', '--singleThreaded' },
      --   },
      -- })

      -- Add --cache flag
      -- TODO: Verify it works. I don't see a .eslintcache file being created.
      -- WARNING: `eslint` needs to exist in `node_modules` or globally installed.
      -- Doesn't seem to cooperate with yarn v4 cache.
      vim.lsp.config('eslint', {
        cmd = { 'vscode-eslint-language-server', '--stdio', '--cache' },
      })

      -- I suddenly had to do this manually?
      -- I thought lazydev essentially does this.
      -- https://github.com/neovim/nvim-lspconfig/blob/44acfe887d4056f704ccc4f17513ed41c9e2b2e6/lsp/lua_ls.lua#L4
      -- HACK: https://github.com/folke/lazydev.nvim/issues/136
      -- Downgrading lua_ls didn't fix for me.
      vim.lsp.config('lua_ls', {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using (most
              -- likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              -- Tell the language server how to find Lua modules same way as Neovim
              -- (see `:h lua-module-load`)
              path = {
                'lua/?.lua',
                'lua/?/init.lua',
              },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Depending on the usage, you might want to add additional paths
                -- here.
                '${3rd}/luv/library',
                -- '${3rd}/busted/library',
              },
              -- Or pull in all of 'runtimepath'.
              -- NOTE: this is a lot slower and will cause issues when working on
              -- your own configuration.
              -- See https://github.com/neovim/nvim-lspconfig/issues/3189
              -- library = vim.api.nvim_get_runtime_file('', true),
            },
          })
        end,
        settings = {
          Lua = {},
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
    'mason-org/mason.nvim',
    cmd = 'Mason',
    opts = {},
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
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'lazy.nvim', words = { 'LazyVim' } },
      },
    },
  },
}
