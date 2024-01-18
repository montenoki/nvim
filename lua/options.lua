local Icons = require('icons')
local opt = vim.opt
local tab_width = 2

opt.autowrite = true -- Enable auto write
opt.clipboard = 'unnamedplus' -- Sync with system clipboard
opt.colorcolumn = '81' -- Line length marker
opt.completeopt = 'menu,menuone,noselect,noinsert'
opt.conceallevel = 3 -- ? Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = 'jcroqlnt' -- ? tcqj
opt.grepformat = '%f:%l:%c:%m' -- ?
opt.grepprg = 'rg --vimgrep' -- ?
opt.ignorecase = true -- Ignore case
opt.inccommand = 'nosplit' -- ? preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.list = vim.g.lite_mode and false or true -- Show some invisible characters (tabs...
opt.listchars = vim.g.lite_mode and {} or Icons.listchars
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 5 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions =
  'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
opt.shiftround = true -- Round indent
opt.shiftwidth = tab_width -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 4 -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { 'en' }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = 'screen'
opt.splitright = true -- Put new windows right of current
opt.tabstop = tab_width -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeout = true -- Enable timeout
opt.timeoutlen = 500
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 100 -- Save swap file and trigger CursorHold
opt.whichwrap = '<,>,[,]' -- Use arrow key to move next line when cursor at end of line
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = true -- Disable line wrap
opt.fillchars = Icons.fillchars
opt.virtualedit = 'onemore' -- fix the problem that cant see last char when scrollbar on.

if vim.fn.has('nvim-0.10') == 1 then
  opt.smoothscroll = true
end

-- Folding
opt.foldcolumn = '1'
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldtext = "v:lua.require'util'.ui.foldtext()" -- todo: check this
-- opt.foldtext = 'v:lua.require("utils.simple_fold").simple_fold()'

if vim.fn.has('nvim-0.9.0') == 1 then
  vim.opt.statuscolumn = [[%!v:lua.require'util'.ui.statuscolumn()]]
end

-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
if vim.fn.has('nvim-0.10') == 1 then
  opt.foldmethod = 'expr'
  vim.opt.foldexpr = "v:lua.require'util'.ui.foldexpr()" -- todo: check this
else
  opt.foldmethod = 'indent'
end

vim.o.formatexpr = "v:lua.require'util'.format.formatexpr()" -- todo: check this

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Add extra filetypes
vim.filetype.add({
  filename = {
    ['.zshrc'] = 'sh',
  },
})
