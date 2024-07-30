local M = {}
local keymaps = require('keymaps')

local function getClients(options)
  -- 获取活跃的LSP客户端
  -- 它兼容不同版本的Neovim API，可以根据指定的选项筛选客户端
  local ret = {}
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(options)
  else
    ret = vim.lsp.get_active_clients(options)
    if options and options.method then
      ret = vim.tbl_filter(function(client)
        return client.supports_method(options.method, { bufnr = options.bufnr })
      end, ret)
    end
  end
  return options and options.filter and vim.tbl_filter(options.filter, ret) or ret
end

-- 从 lazy.nvim获取插件信息和选项
local function getPlugin(name)
  return require('lazy.core.config').spec.plugins[name]
end
local function getPluginOpts(name)
  local plugin = getPlugin(name)
  if not plugin then
    return {}
  end
  local Plugin = require('lazy.core.plugin')
  return Plugin.values(plugin, 'opts', false)
end

-- function M.rename_file()
--   local buf = vim.api.nvim_get_current_buf()
--   local old = assert(LazyVim.root.realpath(vim.api.nvim_buf_get_name(buf)))
--   local root = assert(LazyVim.root.realpath(LazyVim.root.get({ normalize = true })))
--   assert(old:find(root, 1, true) == 1, "File not in project root")

--   local extra = old:sub(#root + 2)

--   vim.ui.input({
--     prompt = "New File Name: ",
--     default = extra,
--     completion = "file",
--   }, function(new)
--     if not new or new == "" or new == extra then
--       return
--     end
--     new = LazyVim.norm(root .. "/" .. new)
--     vim.fn.mkdir(vim.fs.dirname(new), "p")
--     M.on_rename(old, new, function()
--       vim.fn.rename(old, new)
--       vim.cmd.edit(new)
--       vim.api.nvim_buf_delete(buf, { force = true })
--       vim.fn.delete(old)
--     end)
--   end)
-- end

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

M._keys = nil

function M.get()
  if M._keys then
    return M._keys
  end
  -- stylua: ignore
  M._keys =  {
    -- 跳转到当前符号（变量、函数、类等）的定义位置
    { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
    -- 查找当前符号在整个项目中的所有使用位置
    { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
    -- 从抽象基类或接口跳转到具体实现 例子：在查看一个抽象方法时，可以跳转到所有实现这个方法的子类
    { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
    -- 查看变量的类型定义，特别是对于复杂的自定义类型 例子：当你看到 x: CustomType 时，可以跳转到 CustomType 的定义
    { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
    -- 跳转到符号的声明位置  在Python中，这个功能通常与Goto Definition相似
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },

    { "K", vim.lsp.buf.hover, desc = "Hover" },

    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },

    { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },

    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },

    { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },

    { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
    -- TODO: Add support for rename_file
    -- { "<leader>cR", LazyVim.lsp.rename_file, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
    { "<leader>cA", action.source, desc = "Source Action", has = "codeAction" },
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
    { keymaps.lsp.definition, function() require('telescope.builtin').lsp_definitions({ reuse_win = true }) end, desc = 'Goto Definition', has = 'definition' },
    { keymaps.lsp.references, function() require('telescope.builtin').lsp_references(require('telescope.themes').get_dropdown()) end, desc = 'References' },
    { keymaps.lsp.implementation, function() require('telescope.builtin').lsp_implementations({ reuse_win = true }) end, desc = 'Goto Implementation' },
    { keymaps.type_definition, function() require('telescope.builtin').lsp_type_definitions({ reuse_win = true }) end, desc = 'Goto T[y]pe Definition' },
    { keymaps.declaration, vim.lsp.buf.declaration, desc = 'Goto Declaration' },
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
  -- if Lazyvim.has('inc-rename.nvim') then
  --   M._keys[#M._keys + 1] = {
  --     Keys.rename,
  --     function()
  --       local inc_rename = require('inc_rename')
  --       return ':' .. inc_rename.config.cmd_name .. ' ' .. vim.fn.expand('<cword>')
  --     end,
  --     expr = true,
  --     desc = 'Rename',
  --     has = 'rename',
  --   }
  -- else
  --   M._keys[#M._keys + 1] = { Keys.rename, vim.lsp.buf.rename, desc = 'Rename', has = 'rename' }
  -- end
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
  local clients = getClients({ bufnr = buffer })
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
  local opts = getPluginOpts('nvim-lspconfig')
  local clients = getClients({ bufnr = buffer })
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
