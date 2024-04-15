local Lazyvim = require('lazyvim')

return
{
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    cond = vim.g.vscode == nil,
    build = ':MasonUpdate',
    opts = {
      ensure_installed = { 'taplo', 'shfmt', 'stylua', 'tree-sitter-cli' },
      -- ui = { icons = Icon.mason },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- none-ls
  {
    'nvimtools/none-ls.nvim',
    cond = vim.g.vscode == nil,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    dependencies = { 'mason.nvim' },
    init = function()
      Lazyvim.on_very_lazy(function()
        -- register the formatter with LazyVim
        Lazyvim.format.register({
          name = 'none-ls.nvim',
          priority = 200, -- set higher than conform, the builtin formatter
          primary = true,
          format = function(buf)
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
  },
}
