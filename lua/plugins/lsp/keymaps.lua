local M = {}
local Keys = require('keymaps').lsp
local Lazyvim = require('lazyvim')

M._keys = nil

function M.get()
  if M._keys then
    return M._keys
  end
  M._keys = {
    {
      Keys.definition,
      function()
        require('telescope.builtin').lsp_definitions({ reuse_win = true })
      end,
      desc = 'Goto Definition',
      has = 'definition',
    },
    {
      Keys.show_references,
      function()
        require('telescope.builtin').lsp_references(require('telescope.themes').get_dropdown())
      end,
      desc = 'Show References',
    },
    { Keys.declaration, vim.lsp.buf.declaration, desc = 'Goto Declaration' },
    {
      Keys.implementation,
      function()
        require('telescope.builtin').lsp_implementations({ reuse_win = true })
      end,
      desc = 'Goto Implementation',
    },
    {
      Keys.type_definition,
      function()
        require('telescope.builtin').lsp_type_definitions({ reuse_win = true })
      end,
      desc = 'Goto T[y]pe Definition',
    },
    { mode = { 'i' }, Keys.hover, vim.lsp.buf.hover, desc = 'Hover' },
    {
      mode = { 'n', 'i' },
      Keys.signature_help,
      vim.lsp.buf.signature_help,
      desc = 'Signature Help',
      has = 'signatureHelp',
    },
    {
      Keys.pop_diagnostic,
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
    {
      Keys.code_action,
      vim.lsp.buf.code_action,
      desc = 'Code Action',
      mode = { 'n', 'v' },
      has = 'codeAction',
    },
    {
      Keys.code_action_source,
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
      desc = 'Source Code Action',
      has = 'codeAction',
    },
  }
  if Lazyvim.has('inc-rename.nvim') then
    M._keys[#M._keys + 1] = {
      Keys.rename,
      function()
        local inc_rename = require('inc_rename')
        return ':' .. inc_rename.config.cmd_name .. ' ' .. vim.fn.expand('<cword>')
      end,
      expr = true,
      desc = 'Rename',
      has = 'rename',
    }
  else
    M._keys[#M._keys + 1] = { Keys.rename, vim.lsp.buf.rename, desc = 'Rename', has = 'rename' }
  end
  return M._keys
end

---@param method string
function M.has(buffer, method)
  method = method:find('/') and method or 'textDocument/' .. method
  local clients = Lazyvim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

function M.resolve(buffer)
  local Keys = require('lazy.core.handler.keys')
  if not Keys.resolve then
    return {}
  end
  local spec = M.get()
  local opts = Lazyvim.opts('nvim-lspconfig')
  local clients = Lazyvim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
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
