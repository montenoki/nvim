local M = {}
function M.toggle_option(option)
  -- 获取选项当前值
  local current_value = vim.opt[option]:get()

  -- 切换选项
  if current_value then
    vim.notify(option .. " off", vim.log.levels.INFO, { title = "Toggle" })
    vim.opt[option] = false
  else
    vim.notify(option .. " on", vim.log.levels.WARN, { title = "Toggle" })
    vim.opt[option] = true
  end
end

return M
