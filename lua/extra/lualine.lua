local icons = require('icons')
local lazyvim = require('lazyvim')
local ascii = require('util.ascii')
-- Statusline
return {
  'nvim-lualine/lualine.nvim',
  cond = vim.g.vscode == nil,
  dependencies = {
    { 'AndreM222/copilot-lualine' },
  },
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
          winbar = { 'NvimTree', 'dap-repl' },
        },
        component_separators = icons.lualine.component_separators,
        section_separators = icons.lualine.section_separators,
      },
      extensions = {
        'nvim-tree',
        'mason',
        'quickfix',
        'symbols-outline',
        'lazy',
        'toggleterm',
        'nvim-dap-ui',
      },
      sections = {
        lualine_a = {
          function()
            return icons.lualine.nvim
          end,
          'mode',
        },
        lualine_b = {
          { 'branch', icon = icons.lualine.branch },
        },
        lualine_c = {
          -- TODO
          {
            function()
              return icons.lualine.session .. require('auto-session.lib').current_session_name()
            end,
            fmt = lazyvim.lualine.trunc(80, 10, 60),
          },
        },
        lualine_x = {
          {
            function()
              return icons.bug .. require('dap').status()
            end,
            cond = function()
              return package.loaded['dap'] and require('dap').status() ~= ''
            end,
            color = lazyvim.ui.fg('Debug'),
          },
          {
            'copilot',
            cond = function()
              return vim.g.copilot ~= nil
            end,
            fmt = lazyvim.lualine.trunc(80, 5, 80),
          },
        },
        lualine_y = {
          {
            ---@diagnostic disable-next-line: undefined-field
            require('noice').api.status.command.get,
            ---@diagnostic disable-next-line: undefined-field
            cond = require('noice').api.status.command.has,
            color = lazyvim.ui.fg('String'),
          },
          {
            'macro-recording',
            ---@diagnostic disable-next-line: undefined-field
            fmt = lazyvim.lualine.show_macro_recording,
            color = lazyvim.ui.fg('Error'),
          },
        },
        lualine_z = {
          'location',
          'progress',
          function()
            return icons.clock .. os.date('%R')
          end,
        },
      },
      winbar = {
        lualine_a = {
          { lazyvim.lualine.pretty_path() },
        },
        lualine_b = {
          {
            'diff',
            symbols = {
              added = vim.g.lite == nil and '' or ascii.git.added,
              modified = vim.g.lite == nil and '' or ascii.git.modified,
              removed = vim.g.lite == nil and '' or ascii.git.removed,
            },
            source = function()
              ---@diagnostic disable-next-line: undefined-field
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
        },
        lualine_z = {},
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = {
          {
            'filetype',
            icon_only = true,
            separator = '',
            padding = { left = 1, right = 0 },
          },
          { lazyvim.lualine.pretty_path() },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
