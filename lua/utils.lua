local M = {}

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

function M.getPlugin(name)
  return require('lazy.core.config').spec.plugins[name]
end

function M.has(plugin)
  return M.getPlugin(plugin) ~= nil
end

return M
