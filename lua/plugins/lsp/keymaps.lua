local M = {}

---@type LazyKeysLspSpec[]|nil
M._keys = nil

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string}
---@alias LazyKeysLsp LazyKeys|{has?:string}

---@return LazyKeysLspSpec[]
function M.get()
  if M._keys then
    return M._keys
  end
  M._keys = {
    {
      'gd',
      function()
        require('telescope.builtin').lsp_definitions({ reuse_win = true })
      end,
      desc = 'Goto Definition',
      has = 'definition',
    },
    {
      'gr',
      function()
        require('telescope.builtin').lsp_references(
          require('telescope.themes').get_dropdown()
        )
      end,
      desc = 'References',
    },
    { 'gD', vim.lsp.buf.declaration, desc = 'Goto Declaration' },
    {
      'gI',
      function()
        require('telescope.builtin').lsp_implementations({ reuse_win = true })
      end,
      desc = 'Goto Implementation',
    },
    {
      'gy',
      function()
        require('telescope.builtin').lsp_type_definitions({ reuse_win = true })
      end,
      desc = 'Goto T[y]pe Definition',
    },
    { 'gh', vim.lsp.buf.hover, desc = 'Hover' },
    {
      'gH',
      vim.lsp.buf.signature_help,
      desc = 'Signature Help',
      has = 'signatureHelp',
    },
    { 'gt', vim.lsp.buf.type_definition, desc = 'Type definition' },
    {
      'gp',
      function()
        local opts = {
          focusable = false,
          close_events = {
            'BufLeave',
            'CursorMoved',
            'InsertEnter',
            'FocusLost',
          },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end,
      desc = 'Popup diagnostic info',
    },
    -- { "<LEADER>f",  function() vim.lsp.buf.format({ async = true }) end, desc = "Format" },
    {
      '<LEADER>ca',
      vim.lsp.buf.code_action,
      desc = 'Code Action',
      mode = { 'n', 'v' },
      has = 'codeAction',
    },
    {
      '<LEADER>cA',
      function()
        vim.lsp.buf.code_action({
          context = {
            only = {
              'source',
            },
            diagnostics = {},
          },
        })
      end,
      desc = 'Source Action',
      has = 'codeAction',
    },
  }
  if require('util').has('inc-rename.nvim') then
    M._keys[#M._keys + 1] = {
      '<LEADER>r',
      function()
        local inc_rename = require('inc_rename')
        return ':'
          .. inc_rename.config.cmd_name
          .. ' '
          .. vim.fn.expand('<cword>')
      end,
      expr = true,
      desc = 'Rename',
      has = 'rename',
    }
  else
    M._keys[#M._keys + 1] =
      { '<LEADER>r', vim.lsp.buf.rename, desc = 'Rename', has = 'rename' }
  end
  return M._keys
end

---@param method string
function M.has(buffer, method)
  method = method:find('/') and method or 'textDocument/' .. method
  local clients = require('util').lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

---@return (LazyKeys|{has?:string})[]
function M.resolve(buffer)
  local Keys = require('lazy.core.handler.keys')
  if not Keys.resolve then
    return {}
  end
  local spec = M.get()
  local opts = require('util').opts('nvim-lspconfig')
  local clients = require('util').lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys
      or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require('lazy.core.handler.keys')
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    if not keys.has or M.has(buffer, keys.has) then
      local opts = Keys.opts(keys)
      ---@diagnostic disable-next-line: inject-field
      opts.has = nil
      ---@diagnostic disable-next-line: inject-field
      opts.silent = opts.silent ~= false
      ---@diagnostic disable-next-line: inject-field
      opts.buffer = buffer
      vim.keymap.set(keys.mode or 'n', keys.lhs, keys.rhs, opts)
    end
  end
end

return M
