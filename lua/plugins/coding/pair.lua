--- Plugin settings: comment
-- @author monten (monten.oki@gmail.com)
-- @license MIT
-- @copyright monten.oki 2024

local function checkSurroundingChars()
  -- 获取光标位置和当前行内容
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  -- 获取光标前后的字符
  local prev_char = (col > 0) and line:sub(col, col) or ' '
  local next_char = (col < #line) and line:sub(col + 1, col + 1) or ' '

  -- 检查字符是否为字母
  if prev_char:match('%w') or next_char:match('%w') then
    vim.g.minipairs_disable = true
  else
    vim.g.minipairs_disable = false
  end
end

-- 自动开关pairs
vim.api.nvim_create_autocmd('CursorMovedI', {
  group = vim.api.nvim_create_augroup('minipairsAutoDisable', { clear = true }),
  callback = checkSurroundingChars,
})

return {
  'echasnovski/mini.pairs',
  cond = vim.g.vscode == nil,
  event = { 'InsertEnter' },
  opts = {
    mappings = {
      -- Add < >
      ['<'] = { action = 'open', pair = '<>', neigh_pattern = '[^\\].' },
      ['>'] = { action = 'close', pair = '<>', neigh_pattern = '[^\\].' },
    },
  },
}
