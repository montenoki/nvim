local keymaps = require('keymaps')

local function lspOnAttach(on_attach, name)
  -- 创建一个自动命令,在LSP客户端附加到缓冲区时触发
  -- 如果指定了名称,它只会为特定的LSP客户端触发。
  return vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and (not name or client.name == name) then
        return on_attach(client, buffer)
      end
    end,
  })
end

local action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      })
    end
  end,
})

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'workspace',
                exclude = { 'tests', 'test', 'dist', 'build', '.venv', '.git' },
                typeCheckingMode = 'standard',
              },
            },
          },
        },
        ruff_lsp = {
          keys = { { keymaps.lsp.organize, action['source.organizeImports'], desc = 'Organize Imports' } },
        },
      },
      setup = {
        ruff_lsp = function()
          lspOnAttach(function(client, _)
            if client.name == 'ruff_lsp' then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },
}
