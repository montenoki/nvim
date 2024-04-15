local Lazyvim = require('lazyvim')
local Ascii_icons = require('util.ascii_icons')
return -- Breadcrumb Bar
{
  {
    'SmiteshP/nvim-navic',
    cond=vim.g.vscode == nil,
    lazy = true,
    init = function()
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
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
        auto_attach = false,
        preference = nil,
      },
      highlight = true,
      depth_limit = 4,
      separator = vim.g.lite == nil and '> ' or '',
      click = true,
      lazy_update_context = true,
    },
  },
  {
    'lualine.nvim',
    opts = function(_, opts)
      table.insert(opts.winbar.lualine_c, { 'navic' })
    end,
  },
}