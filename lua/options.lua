local Ascii_icons = require('util.ascii_icons')
local opt = vim.o

-- =============================================================================
--   Basic - 基本設定
-- =============================================================================

opt.clipboard = 'unnamedplus' -- システムのクリップボードと連携する
opt.confirm = true -- ファイル保存の確認
opt.mouse = 'a' -- マウスサポート
opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
opt.timeoutlen = 50
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 100

-- 自動補完
opt.completeopt = 'menu,menuone,noselect,noinsert' -- 自動補完設定
opt.wildmode = 'longest:full,full'

-- 検索
opt.ignorecase = true -- 大文字と小文字を同等に取り扱う
opt.smartcase = true -- 大文字が入る場合、大文字を無視しない

-- インデント
opt.expandtab = true -- Tabの代わりにSpaceを使用する
opt.shiftround = true -- シフト時shiftwidthの値の倍数になるようにスペースを挿入
opt.smartindent = true -- 自動的にインデントを入力する

-- ウィンドウ
opt.splitbelow = true -- 新規Windowの方向
opt.splitright = true
opt.splitkeep = 'screen'

-- grep 設定
opt.grepprg = 'rg --vimgrep'
opt.grepformat = '%f:%l:%c:%m'

-- 折り畳み設定
opt.foldenable = true
opt.foldlevelstart = 99
opt.foldlevel = 99
opt.foldcolumn = '1'
opt.foldmethod = 'indent'

-- UI
opt.cursorline = true -- 編集行をハイライトする
opt.laststatus = 1 -- global statusline
opt.number = true -- Print line number
opt.pumheight = 5 -- Maximum number of entries in a popup
opt.showmode = false -- Dont show mode since we have a statusline
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.termguicolors = true
opt.virtualedit = 'onemore' -- fix the problem that cant see last char when scrollbar on.
opt.winminwidth = 5 -- Minimum window width
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- =============================================================================
--   preference.lua - 好み設定
-- =============================================================================

local tab_width = 2

opt.whichwrap = '<,>,[,]' -- Use arrow key to move next line when cursor at end of line
opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 4 -- Columns of context

-- Tab
opt.tabstop = tab_width -- Number of spaces tabs count for
opt.shiftwidth = tab_width -- Size of an indent

-- UI
opt.colorcolumn = '81' -- Line length marker
opt.conceallevel = 3 -- ? Hide * markup for bold and italic
opt.list = true -- Show some invisible characters (tabs...
opt.listchars = vim.g.lite == nil and 'eol:↲,tab:<->,trail:~,extends:,precedes:,nbsp:␣'
  or Ascii_icons.listchars
opt.relativenumber = false -- Relative line numbers
opt.wrap = false -- Disable line wrap

-- =============================================================================
--   その他設定
-- =============================================================================

-- Add extra filetypes
vim.filetype.add({
  filename = {
    ['.zshrc'] = 'sh',
    ['.zsh'] = 'sh',
    ['.zlogout'] = 'sh',
  },
})

-- Python Provider
local executable_path = '/.virtualenvs/neovim/bin/python'
if string.find(vim.loop.os_uname().sysname, 'Windows') then
  executable_path = '\\.virtualenvs\\neovim\\Scripts\\python.exe'
end
vim.g.python3_host_prog = vim.env.HOME .. executable_path

-- TODO:
-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
