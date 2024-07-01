---@param name string
---@return integer
local function augroup(name)
  return vim.api.nvim_create_augroup('userDefined_' .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  command = 'checktime',
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
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

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'query',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<CMD>close<CR>', { buffer = event.buf, silent = true })
  end,
})

-- Auto create dir when saving a file,
-- in case some intermediate directory does not exist.
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+://') then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Add new line with 'o' do not continue comments
vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup('dont_continue_comments'),
  pattern = '*',
  callback = function() --'tcrqlmM'
    -- https://neovim.io/doc/user/change.html#fo-table
    vim.opt.formatoptions = vim.opt.formatoptions - 'j' - 'o' + 't' + 'm' + 'M'
  end,
})

-- Display Recording status in statusline
vim.api.nvim_create_autocmd('RecordingEnter', {
  group = augroup('display_rec_stat_enter'),
  callback = function()
    require('lualine').refresh({
      place = { 'statusline' },
    })
  end,
})
vim.api.nvim_create_autocmd('RecordingLeave', {
  group = augroup('display_rec_stat_leave'),
  callback = function()
    -- This is going to seem really weird!
    -- Instead of just calling refresh we need to wait a moment because
    -- of the nature of `vim.fn.reg_recording`. If we tell lualine to refresh
    -- right now it actually will still show a recording occuring because
    -- `vim.fn.reg_recording` hasn't emptied yet. So what we need to do is
    -- wait a tiny amount of time (in this instance 50 ms) to ensure
    -- `vim.fn.reg_recording` is purged before asking lualine to refresh.
    local timer = vim.loop.new_timer()
    timer:start(
      50,
      0,
      vim.schedule_wrap(function()
        require('lualine').refresh({
          place = { 'statusline' },
        })
      end)
    )
  end,
})

-- Keep cursor position on yank
vim.api.nvim_create_autocmd({ 'VimEnter', 'CursorMoved' }, {
  group = augroup('save_cursor_position'),
  callback = function()
    CURSOR_POS = vim.fn.getpos('.')
  end,
})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('yank_restore_cursor'),
  pattern = '*',
  callback = function()
    if vim.v.event.operator == 'y' then
      vim.fn.setpos('.', CURSOR_POS)
    end
  end,
})
