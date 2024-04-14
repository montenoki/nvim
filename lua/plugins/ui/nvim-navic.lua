local Lazyvim = require('lazyvim')
local Ascii_icons = require('util.ascii_icons')
return -- Breadcrumb Bar
{
  'SmiteshP/nvim-navic',
  lazy = true,
  init = function()
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    vim.g.navic_silence = false
    Lazyvim.lsp.on_attach(function(client, buffer)
      if client.supports_method('textDocument/documentSymbol') then
        require('nvim-navic').attach(client, buffer)
      end
    end)
  end,
  opts = {
    icons = vim.g.lite == nil and {
      File = ' ',
      Module = '󰆧 ',
      Namespace = ' ',
      Package = '󰏗 ',
      Class = '𝓒 ',
      Method = 'ƒ ',
      Property = ' ',
      Field = '󰽐 ',
      Constructor = ' ',
      Enum = ' ',
      Interface = ' ',
      Function = '󰊕 ',
      Variable = '󰫧 ',
      Constant = '󰏿 ',
      String = '𝓐 ',
      Number = ' ',
      Boolean = '◩ ',
      Array = ' ',
      Object = '⦿ ',
      Key = ' ',
      Null = '󰟢 ',
      EnumMember = ' ',
      Struct = ' ',
      Event = ' ',
      Operator = ' ',
      TypeParameter = ' ',
      separator = '> ',
    } or Ascii_icons.navic,
    lsp = {
      auto_attach = true,
      preference = nil,
    },
    highlight = true,
    depth_limit = 4,
    separator = vim.g.lite == nil and '> ' or '',
    click = true,
    lazy_update_context = true,
  },
}
