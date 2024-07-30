local M = {}

M.action = setmetatable({}, {
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

function M.removeDuplicates(list)
  local ret = {}
  local seen = {}
  for _, v in ipairs(list) do
    if not seen[v] then
      table.insert(ret, v)
      seen[v] = true
    end
  end
  return ret
end

function M.showRecording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Rec @' .. recording_register
  end
end

function M.trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

function M.norm(path)
  if path:sub(1, 1) == '~' then
    local home = vim.uv.os_homedir()
    if home:sub(-1) == '\\' or home:sub(-1) == '/' then
      home = home:sub(1, -2)
    end
    path = home .. path:sub(2)
  end
  path = path:gsub('\\', '/'):gsub('/+', '/')
  return path:sub(-1) == '/' and path:sub(1, -2) or path
end

function M.realPath(path)
  if path == '' or path == nil then
    return nil
  end
  path = vim.uv.fs_realpath(path) or path
  return M.norm(path)
end

function M.cwd()
  return M.realPath(vim.uv.cwd()) or ''
end

-- 从 lazy.nvim获取插件信息和选项
function M.getPlugin(name)
  return require('lazy.core.config').spec.plugins[name]
end

function M.has(plugin)
  return M.getPlugin(plugin) ~= nil
end

function M.color(name, bg)
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name, link = false })
    or vim.api.nvim_get_hl_by_name(name, true)

  local color = nil
  if hl then
    if bg then
      color = hl.bg or hl.background
    else
      color = hl.fg or hl.foreground
    end
  end
  return color and string.format('#%06x', color) or nil
end

function M.fg(name)
  local color = M.color(name)
  return color and { fg = color } or nil
end

function M.getPluginOpts(name)
  local plugin = M.getPlugin(name)
  if not plugin then
    return {}
  end
  local Plugin = require('lazy.core.plugin')
  return Plugin.values(plugin, 'opts', false)
end
function M.getClients(options)
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
function M.lspOnAttach(on_attach, name)
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
return M
