local Ascii_icons = require('util.ascii_icons')
local Lazyvim = require('lazyvim')
-- Statusline
return {
  'nvim-lualine/lualine.nvim',
  cond = vim.g.vscode == nil,
  event = 'VeryLazy',
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- Set an empty statusline till lualine loads
      vim.o.statusline = ' '
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local lualine_require = require('lualine_require')
    lualine_require.require = require

    vim.o.laststatus = vim.g.lualine_laststatus
    return {
      options = {
        theme = 'auto',
        globalstatus = true,
        disabled_filetypes = {
          statusline = {},
          winbar = { 'NvimTree', 'dap-repl' },
        },
        component_separators = { left = '', right = '' },
        section_separators = vim.g.lite == nil and { left = '', right = '' }
          or Ascii_icons.lualine.section_separators,
      },
      extensions = {
        'nvim-tree',
        'mason',
        'quickfix',
        'symbols-outline',
        'lazy',
        'toggleterm',
        'nvim-dap-ui',
        'trouble',
      },
      sections = {
        lualine_a = {
          { 'mode', icon = vim.g.lite == nil and '' or '' },
        },
        lualine_b = {
          { 'branch', icon = vim.g.lite == nil and '' or '' },
        },
        lualine_c = {
          {
            'filename',
            path = 1,
            file_status = false,
          },
        },
        lualine_x = {},
        lualine_y = {
          {
            'macro-recording',
            ---@diagnostic disable-next-line: undefined-field
            fmt = require('util.lualine').show_macro_recording,
            ---@diagnostic disable-next-line: undefined-field
            color = Lazyvim.ui.fg('Error'),
          },
        },
        lualine_z = {
          'location',
          'progress',
          function()
            local icon = vim.g.lite == nil and ' ' or ''
            return icon .. os.date('%R')
          end,
        },
      },
      winbar = {
        lualine_a = {
          {
            'filename',
            file_status = true,
            newfile_status = true,
            symbols = {
              modified = '󰏫',
              readonly = '',
              unnamed = '[No Name]',
              newfile = '[New]',
            },
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
          {
            'diagnostics',
            symbols = {
              error = vim.g.lite == nil and ' ' or Ascii_icons.diagnostics.Error,
              warn = vim.g.lite == nil and ' ' or Ascii_icons.diagnostics.Warn,
              info = vim.g.lite == nil and ' ' or Ascii_icons.diagnostics.Info,
              hint = vim.g.lite == nil and ' ' or Ascii_icons.diagnostics.Hint,
            },
          },
        },
        lualine_z = {},
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = {
          {
            'filename',
            file_status = true,
            newfile_status = true,
            symbols = {
              modified = '󰏫',
              readonly = '',
              unnamed = '[No Name]',
              newfile = '[New]',
            },
          },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
