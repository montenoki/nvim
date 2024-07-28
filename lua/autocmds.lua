---@param name string
---@return integer
local function augroup(name)
  return vim.api.nvim_create_augroup('user_' .. name, { clear = true })
end

-- =============================================================================
-- 高亮显示yank的文本
-- =============================================================================
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('HighlightYank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- =============================================================================
-- 检查文件更改时是否需要重新加载
-- =============================================================================
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('ReloadIfFileChanged'),
  command = 'checktime',
})

-- =============================================================================
-- 在打开缓冲区时将光标移动到上次编辑的位置
-- =============================================================================
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('RestoreLastEditLocation'),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- =============================================================================
-- 使用<q>关闭某些文件类型
-- =============================================================================
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('CloseWithQ'),
  pattern = {
    -- TODO: Add more filetypes when new plugins are added
    'help',
    'lspinfo',
    'man',
    'notify',
    'startuptime',
    'checkhealth',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<CMD>close<CR>', { buffer = event.buf, silent = true })
  end,
})

-- =============================================================================
-- 在保存文件时自动创建目录，以防某些中间目录不存在
-- =============================================================================
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('AutoCreateDir'),
  callback = function(event)
    if event.match:match('^%w%w+://') then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- =============================================================================
-- 编写某些文件时加入t选项使FormatOptions应用于所有地方
-- =============================================================================
vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup('enableAutoFormat'),
  pattern = '*.txt',
  callback = function()
    vim.opt.formatoptions:append('t')
  end,
})

-- =============================================================================
-- 在Yank时保持光标位置不变
-- =============================================================================
vim.api.nvim_create_autocmd({ 'VimEnter', 'CursorMoved' }, {
  group = augroup('saveCursorLocation'),
  callback = function()
    CURSOR_POS = vim.fn.getpos('.')
  end,
})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('RestoreCursorLocationAfterYank'),
  pattern = '*',
  callback = function()
    if vim.v.event.operator == 'y' then
      vim.fn.setpos('.', CURSOR_POS)
    end
  end,
})

-- =============================================================================
-- 以下废弃
-- =============================================================================
-- vim.api.nvim_create_autocmd('TextChanged', {
--   pattern = '*',
--   group = augroup('MoveTOEndOfPastedText'),
--   callback = function()
--     if vim.v.event.operator == 'p' then
--       -- 获取当前光标位置
--       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--       -- 获取粘贴的文本长度
--       local paste_length = #vim.v.event.text
--       -- 移动光标到粘贴文本的末尾
--       vim.api.nvim_win_set_cursor(0, {line, col + paste_length - 1})
--     end
--   end,
-- })

-- TODO:2024/07/29 移动到statusline插件设置中
-- -- Display Recording status in statusline
-- vim.api.nvim_create_autocmd('RecordingEnter', {
--   group = augroup('display_rec_stat_enter'),
--   callback = function()
--     require('lualine').refresh({
--       place = { 'statusline' },
--     })
--   end,
-- })
-- vim.api.nvim_create_autocmd('RecordingLeave', {
--   group = augroup('display_rec_stat_leave'),
--   callback = function()
--     -- This is going to seem really weird!
--     -- Instead of just calling refresh we need to wait a moment because
--     -- of the nature of `vim.fn.reg_recording`. If we tell lualine to refresh
--     -- right now it actually will still show a recording occuring because
--     -- `vim.fn.reg_recording` hasn't emptied yet. So what we need to do is
--     -- wait a tiny amount of time (in this instance 50 ms) to ensure
--     -- `vim.fn.reg_recording` is purged before asking lualine to refresh.
--     local timer = vim.loop.new_timer()
--     timer:start(
--       50,
--       0,
--       vim.schedule_wrap(function()
--         require('lualine').refresh({
--           place = { 'statusline' },
--         })
--       end)
--     )
--   end,
-- })
