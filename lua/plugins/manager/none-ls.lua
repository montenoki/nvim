local Lazyvim = require('lazyvim')

return {
  'nvimtools/none-ls.nvim',
  cond = vim.g.vscode == nil,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
  dependencies = { 'mason.nvim' },
  init = function()
    Lazyvim.on_very_lazy(function()
      -- register the formatter with LazyVim
      ---@diagnostic disable-next-line: undefined-field
      Lazyvim.format.register({
        name = 'none-ls.nvim',
        priority = 200, -- set higher than conform, the builtin formatter
        primary = true,
        format = function(buf)
          ---@diagnostic disable-next-line: undefined-field
          return Lazyvim.lsp.format({
            bufnr = buf,
            filter = function(client)
              return client.name == 'null-ls'
            end,
          })
        end,
        sources = function(buf)
          local ret = require('null-ls.sources').get_available(vim.bo[buf].filetype, 'NULL_LS_FORMATTING') or {}
          return vim.tbl_map(function(source)
            return source.name
          end, ret)
        end,
      })
    end)
  end,
  opts = function(_, opts)
    opts.root_dir = opts.root_dir
      or require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git')
  end,
}
