local lazyvim = require('lazyvim')
local ascii = require('util.ascii')
return {
  {
    'SmiteshP/nvim-navic',
    lazy = true,
    init = function()
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
      ---@diagnostic disable-next-line: undefined-field
      lazyvim.lsp.on_attach(function(client, buffer)
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
      } or ascii.navic,
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
