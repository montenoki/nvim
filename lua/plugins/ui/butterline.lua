local Ascii_icons = require('util.ascii_icons').bufferline
return {
  'akinsho/bufferline.nvim',
  cond = vim.g.vscode == nil,
  event = 'VeryLazy',
  opts = {
    options = {
      mode = 'tabs',
      close_command = function(n)
        require('mini.bufremove').delete(n, false)
      end,

      buffer_close_icon = '',
      modified_icon = '',
      close_icon = '',
      left_trunc_marker = vim.g.lite == nil and '' or Ascii_icons.left_trunc_marker,
      right_trunc_marker = vim.g.lite == nil and '' or Ascii_icons.right_trunc_marker,
      show_buffer_icons = vim.g.lite == nil,
      always_show_bufferline = false,
      indicator = {
        icon = '||', -- this should be omitted if indicator style is not 'icon'
        style = 'icon',
      },
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'left',
        },
        {
          filetype = 'dapui_scopes',
          text = 'Debug Mode',
          highlight = 'Directory',
          text_align = 'left',
        },
        {
          filetype = 'Outline',
          text = 'Outline',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
      diagnostics = false,
    },
  },
  config = function(_, opts)
    local bufferline = require('bufferline')
    if vim.g.lite ~= nil then
      opts.options.style_preset = {
        bufferline.style_preset.no_italic,
        bufferline.style_preset.no_bold,
      }
    else
      opts.options.style_preset = {
        bufferline.style_preset.no_italic,
      }
    end
    require('bufferline').setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd('BufAdd', {
      group = vim.api.nvim_create_augroup('reload_bufferline', { clear = true }),
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
