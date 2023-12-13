local M = {}
-- Server List:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
M.lsp_servers = {
  lua_ls = {
    -- mason = false, -- set to false if you don't want this server to be installed with mason
    -- Use this to add any additional keymaps
    -- for specific lsp servers
    ---@type LazyKeysSpec[]
    -- keys = {},
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
  pylyzer = {
    python = {
      chechOnType = true,
    },
  },
  pyright = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        useLibraryCodeForTypes = true,
      },
    },
  },
  ruff_lsp = {
    init_options = {
      settings = {
        -- Any extra CLI arguments for `ruff` go here.
        args = {},
      },
    },
  },
}
M.mason_ensure_installed = {}
M.ts_ensure_installed = { 'vim', 'lua', 'python', 'query', 'r', 'c', 'toml', 'markdown', 'markdown_inline' }

return M
