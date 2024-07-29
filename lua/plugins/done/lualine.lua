local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Rec @' .. recording_register
  end
end

local function color(name, bg)
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name, link = false })
    or vim.api.nvim_get_hl_by_name(name, true)

  local color = nil
  if hl then
    if bg then
      color = hl.bg or hl.background
    else
      color = hl.fg or hl.foreground
    end
  end
  return color and string.format('#%06x', color) or nil
end

local function fg(name)
  local color = color(name)
  return color and { fg = color } or nil
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    vim.opt.showmode = false -- Disable the default showmode
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
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        -- TODO:移动到Nvimtree 和dap-repl中？
        -- disabled_filetypes = {
        --   statusline = {},
        --   winbar = {'NvimTree', 'dap-repl' },
        -- },
      },
      extensions = {
        'lazy',
        --   'nvim-tree',
        --   'mason',
        --   'quickfix',
        --   'symbols-outline',
        --   'toggleterm',
        --   'nvim-dap-ui',
        --   'trouble',
      },
      sections = {
        lualine_a = {
          { 'mode', icon = '' },
        },
        lualine_b = {
          { 'branch', icon = '' },
        },
        lualine_c = {
          -- TODO:移动到LSP中
          -- {
          --   function()
          --     local original_bufnr = vim.api.nvim_get_current_buf()
          --     local buf_clients = vim.lsp.get_active_clients({ bufnr = original_bufnr })
          --     return ' :' .. tostring(#vim.tbl_keys(buf_clients))
          --   end,
          --   color = function()
          --     local original_bufnr = vim.api.nvim_get_current_buf()
          --     local buf_clients = vim.lsp.get_active_clients({ bufnr = original_bufnr })
          --     ---@diagnostic disable-next-line: undefined-field
          --     return #vim.tbl_keys(buf_clients) > 0 and lazyvim.ui.fg('Character') or lazyvim.ui.fg('Comment')
          --   end,
          --   on_click = function()
          --     vim.cmd('LspInfo')
          --   end,
          -- },
          { 'filename', path = 1, file_status = false },
        },
        lualine_x = {},
        lualine_y = { { 'macro-recording', fmt = show_macro_recording, color = fg('Error') } },
        lualine_z = {
          'location',
          'progress',
          function()
            local icon = ' '
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
          -- TODO:移动到LSP中
          -- {
          --   'diagnostics',
          --   symbols = {
          --     error = vim.g.lite == nil and ' ' or ascii.diagnostics.Error,
          --     warn = vim.g.lite == nil and ' ' or ascii.diagnostics.Warn,
          --     info = vim.g.lite == nil and ' ' or ascii.diagnostics.Info,
          --     hint = vim.g.lite == nil and ' ' or ascii.diagnostics.Hint,
          --   },
          -- },
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
