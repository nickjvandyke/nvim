return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local filename = {
      'filename',
      path = 1,
      separator = '',
    }

    local filetype = {
      'filetype',
      icon_only = true,
      separator = '',
      padding = { left = 0, right = 1 },
    }

    local cwd = {
      function()
        local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        local target_len = vim.o.columns / 11
        if string.len(cwd) > target_len then
          return string.sub(cwd, 1, target_len) .. '…'
        else
          return cwd
        end
      end,
      icon = ' ', -- Same as my powerline prompt
      separator = { left = '', right = '' },
    }

    local branch = {
      'branch',
      icon = '',
      fmt = function(str)
        local target_len = vim.o.columns / 7
        if string.len(str) > target_len then
          return string.sub(str, 1, target_len) .. '…'
        else
          return str
        end
      end,
      separator = { left = '', right = '' },
    }

    local progress = {
      function()
        local chars = { '⎺', '⎻', '─', '⎼', '⎽' }

        local progress = math.floor((vim.fn.line '.' / vim.fn.line '$') * 100)
        local indexBucket = math.min(#chars, math.floor(progress / (100 / #chars)) + 1)
        local progressChar = chars[indexBucket]

        return progressChar
      end,
      color = { fg = '#ff0000' },
    }

    local diff = {
      'diff',
      symbols = { added = ' ', modified = ' ', removed = ' ' },
      source = function()
        local summary = vim.b.minidiff_summary
        return {
          added = (summary and summary.add) or 0,
          modified = (summary and summary.change) or 0,
          removed = (summary and summary.delete) or 0,
        }
      end,
    }

    local modes = {
      'mode',
      fmt = function(str)
        return string.sub(str, 0, 1)
      end,
      separator = { left = '', right = '' },
    }

    local search = {
      'searchcount',
      icon = '',
      fmt = function(str)
        return str:gsub('[%[%]|]', '')
      end,
    }

    local macro = {
      function()
        local reg = vim.fn.reg_recording()
        if reg == '' then
          return ''
        end -- not recording
        return '󰑋 ' .. reg
      end,
      color = { fg = '#ff0000', gui = 'italic,bold' },
    }

    local diagnostics = {
      'diagnostics',
      color = { gui = 'bold' },
    }

    local lsp = {
      'lsp_status',
      color = { gui = 'italic' },
      icon = ' ',
      separator = { left = '', right = '' },
    }

    require('lualine').setup {
      options = {
        -- section_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        always_show_tabline = false,
        globalstatus = true,
      },
      tabline = {
        lualine_a = {
          'tabs',
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          filename,
          filetype,
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      sections = {
        lualine_a = {
          -- modes,
          -- cwd,
          branch,
        },
        lualine_b = {
          diff,
        },
        lualine_c = {
          { 'grapple', padding = { left = 1 } },
          filename,
          filetype,
          -- progress,
        },
        lualine_x = {
          search,
          macro,
        },
        lualine_y = {
          diagnostics,
        },
        lualine_z = {
          lsp,
          { require('opencode').statusline, separator = { left = '', right = '' } },
        },
      },
    }
  end,
}
