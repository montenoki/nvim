local M = {}

-- mason
-- Server List:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
M.lsp_servers = {
  -- 'bashls',
  'lua_ls',
  'ruff_lsp',
  -- 'marksman',
  -- 'rust_analyzer',
  -- 'pylsp',
  -- 'vimls',
  -- 'r_language_server',
  -- 'clangd',
  -- 'jsonls',
  -- 'taplo',
}
M.mason_ensure_installed = {
  -- 'stylua',
  -- 'shfmt',
  -- 'lua_ls',
  -- 'lua-language-server',
  -- 'bash-language-server',
  -- 'bashls',
  -- 'lua_ls',
  -- 'marksman',
  -- 'rust_analyzer',
  -- 'pylsp',
  -- 'vimls',
  -- 'r_language_server',
  -- 'clangd',
  -- 'jsonls',
  -- 'taplo',
}

return M
