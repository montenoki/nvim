M = {}
---@param name string
---@return integer
function M.augroup(name)
    return vim.api.nvim_create_augroup('user_' .. name, { clear = true })
end
-- =============================================================================
-- 高亮显示yank的文本
-- =============================================================================
vim.api.nvim_create_autocmd('TextYankPost', {
    group = M.augroup('HighlightYank'),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- =============================================================================
-- 修复在进入缓冲区时formatoptions被重置的问题
-- =============================================================================
vim.api.nvim_create_autocmd('BufEnter', {
  group = M.augroup('dont_continue_comments'),
  pattern = '*',
  callback = function()
    vim.opt.formatoptions = { c = true, r = true, q = true, n = true, m = true, M = true, j = true }
  end,
})
-- =============================================================================
-- 检查文件更改时是否需要重新加载
-- =============================================================================
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = M.augroup('ReloadIfFileChanged'),
    command = 'checktime',
})

-- =============================================================================
-- 在打开缓冲区时将光标移动到上次编辑的位置
-- =============================================================================
vim.api.nvim_create_autocmd('BufReadPost', {
    group = M.augroup('RestoreLastEditLocation'),
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
    group = M.augroup('CloseWithQ'),
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
    group = M.augroup('AutoCreateDir'),
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
    group = M.augroup('enableAutoFormat'),
    pattern = '*.txt',
    callback = function()
        vim.opt.formatoptions:append('t')
    end,
})

-- =============================================================================
-- 在Yank时保持光标位置不变
-- =============================================================================
vim.api.nvim_create_autocmd({ 'VimEnter', 'CursorMoved' }, {
    group = M.augroup('saveCursorLocation'),
    callback = function()
        CURSOR_POS = vim.fn.getpos('.')
    end,
})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = M.augroup('RestoreCursorLocationAfterYank'),
    pattern = '*',
    callback = function()
        if vim.v.event.operator == 'y' then
            vim.fn.setpos('.', CURSOR_POS)
        end
    end,
})

-- =============================================================================
-- 以下未完成
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
return M
