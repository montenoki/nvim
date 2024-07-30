local M = {}
local keymaps = require('keymaps')
local utils = require('utils')

M._keys = nil

function M.get()
  if M._keys then
    return M._keys
  end
  -- stylua: ignore
  M._keys =  {
    -- 跳转到当前符号（变量、函数、类等）的定义位置
    { keymaps.lsp.definition, vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
    -- 查找当前符号在整个项目中的所有使用位置
    { keymaps.lsp.references, vim.lsp.buf.references, desc = "References", nowait = true },
    -- 从抽象基类或接口跳转到具体实现 例子：在查看一个抽象方法时，可以跳转到所有实现这个方法的子类
    { keymaps.lsp.implementation, vim.lsp.buf.implementation, desc = "Goto Implementation" },
    -- 查看变量的类型定义，特别是对于复杂的自定义类型 例子：当你看到 x: CustomType 时，可以跳转到 CustomType 的定义
    { keymaps.lsp.type_definition, vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
    -- 跳转到符号的声明位置  在Python中，这个功能通常与Goto Definition相似
    { keymaps.lsp.declaration, vim.lsp.buf.declaration, desc = "Goto Declaration" },
    -- 查看当前符号的文档信息
    { keymaps.lsp.hover, vim.lsp.buf.hover, desc = "Hover" },
    -- 查看当前符号的签名信息
    { keymaps.lsp.signature_help, vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    -- 插入模式下查看当前符号的签名信息
    { keymaps.lsp.signature_help_insert, vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },

    { keymaps.lsp.code_action, vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },

    { keymaps.lsp.runCodelensAction, vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },

    { keymaps.lsp.refreshCodelens, vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
  
    { keymaps.lsp.rename, vim.lsp.buf.rename, desc = "Rename", has = "rename" },

    -- { "]]", function() LazyVim.lsp.words.jump(vim.v.count1) end, has = "documentHighlight",
    --   desc = "Next Reference", cond = function() return LazyVim.lsp.words.enabled end },
    -- { "[[", function() LazyVim.lsp.words.jump(-vim.v.count1) end, has = "documentHighlight",
    --   desc = "Prev Reference", cond = function() return LazyVim.lsp.words.enabled end },
    -- { "<a-n>", function() LazyVim.lsp.words.jump(vim.v.count1, true) end, has = "documentHighlight",
    --   desc = "Next Reference", cond = function() return LazyVim.lsp.words.enabled end },
    -- { "<a-p>", function() LazyVim.lsp.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
    --   desc = "Prev Reference", cond = function() return LazyVim.lsp.words.enabled end },
  }
  -- stylua: ignore
  M._keys_origin = {
    -- { keymaps.lsp.definition, function() require('telescope.builtin').lsp_definitions({ reuse_win = true }) end, desc = 'Goto Definition', has = 'definition' },
    -- { keymaps.lsp.references, function() require('telescope.builtin').lsp_references(require('telescope.themes').get_dropdown()) end, desc = 'References' },
    -- { keymaps.lsp.implementation, function() require('telescope.builtin').lsp_implementations({ reuse_win = true }) end, desc = 'Goto Implementation' },
    -- { keymaps.type_definition, function() require('telescope.builtin').lsp_type_definitions({ reuse_win = true }) end, desc = 'Goto T[y]pe Definition' },
    -- { keymaps.declaration, vim.lsp.buf.declaration, desc = 'Goto Declaration' },
    -- { mode = { 'i' }, Keys.hover, vim.lsp.buf.hover, desc = 'Hover' },
    -- {
    --   mode = { 'n', 'i' },
    --   Keys.signature_help,
    --   vim.lsp.buf.signature_help,
    --   desc = 'Signature Help',
    --   has = 'signatureHelp',
    -- },
    -- {
    --   Keys.pop_diagnostic,
    --   function()
    --     local opts = {
    --       focusable = false,
    --       close_events = {
    --         'BufLeave',
    --         'CursorMoved',
    --         'InsertEnter',
    --         'FocusLost',
    --       },
    --       border = 'rounded',
    --       source = 'always',
    --       prefix = ' ',
    --       scope = 'cursor',
    --     }
    --     vim.diagnostic.open_float(nil, opts)
    --   end,
    --   desc = 'Popup diagnostic info',
    -- },
    -- {
    --   Keys.code_action,
    --   vim.lsp.buf.code_action,
    --   desc = 'Code Action',
    --   mode = { 'n', 'v' },
    --   has = 'codeAction',
    -- },
    -- {
    --   Keys.code_action_source,
    --   function()
    --     vim.lsp.buf.code_action({
    --       context = {
    --         only = {
    --           'source',
    --         },
    --         diagnostics = {},
    --       },
    --     })
    --   end,
    --   desc = 'Source Code Action',
    --   has = 'codeAction',
    -- },
  }
  return M._keys
end

function M.has(buffer, method)
  if type(method) == 'table' then
    for _, m in ipairs(method) do
      if M.has(buffer, m) then
        return true
      end
    end
    return false
  end
  method = method:find('/') and method or 'textDocument/' .. method
  local clients = utils.getClients({ bufnr = buffer })
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
  local opts = utils.getPluginOpts('nvim-lspconfig')
  local clients = utils.getClients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require('lazy.core.handler.keys')
  local currentKeymaps = M.resolve(buffer)

  for _, keys in pairs(currentKeymaps) do
    local has = not keys.has or M.has(buffer, keys.has)
    local cond = not (keys.cond == false or ((type(keys.cond) == 'function') and not keys.cond()))

    if has and cond then
      local opts = Keys.opts(keys)
      opts.cond = nil
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or 'n', keys.lhs, keys.rhs, opts)
    end
  end
end

return M
