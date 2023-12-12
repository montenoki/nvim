return {

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
}
