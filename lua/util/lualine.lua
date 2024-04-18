local M = {}
local Lazyvim = require('lazyvim')

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

function M.show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Rec @' .. recording_register
  end
end

function M.show_venv()
  local selector = require('venv-selector')
  local py_icon = vim.g.lite == nil and '' or ''
  local venv = selector.get_active_venv():gsub(Lazyvim.root.cwd():gsub('%-', '%%-') .. '/', '') or 'NO ENV'
  local version = vim.fn.system(selector.get_active_path() .. ' --version'):gsub('Python ', ''):gsub('[%c%s]', '')
  return py_icon .. venv .. '@' .. version
end
function M.test()
  local selector = require('venv-selector')
  local py_icon = vim.g.lite == nil and '' or ''
  local venv = selector.get_active_venv():gsub(Lazyvim.root.cwd():gsub('%-', '%%-') .. '/', '') or 'NO ENV'
  return 'abc' .. py_icon .. venv
end

return M
