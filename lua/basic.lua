local uConfig = require('uConfig')

----- Display Settings -----
----------------------------

-- Movement Dead Zone
vim.o.scrolloff = 4
vim.o.sidescrolloff = 4

if uConfig.enable.code_ruler then
    vim.wo.colorcolumn = '80,120'
end

if uConfig.enable.lite_mode == false and uConfig.enable.listchars then
    vim.o.list = true
    vim.o.listchars = 'eol:↲,space:·,trail:●,tab:→→'
else
    vim.o.list = false
end

vim.wo.number = true
if uConfig.enable.relativenumber then
    vim.wo.relativenumber = true
else
    vim.wo.relativenumber = false
end

vim.o.hlsearch = true
vim.wo.cursorline = true

vim.g.encoding = 'UTF-8'
vim.o.fileencoding = 'utf-8'

vim.wo.signcolumn = 'yes'

vim.o.cmdheight = 2

vim.wo.wrap = true

vim.o.showmode = false

if uConfig.enable.lite_mode then
    vim.o.termguicolors = false
    vim.opt.termguicolors = false
else
    vim.o.termguicolors = true
    vim.opt.termguicolors = true
end

-- move to next line when use -> at end of line
vim.o.whichwrap = '<,>,[,]'

-- Autocomplete
vim.o.pumheight = 5
vim.o.wildmenu = true

-- Tabline
vim.o.showtabline = 2

----- Tab -----
---------------
local tab_width = uConfig.setting.tab_width

-- Tab Width
vim.o.tabstop = tab_width
vim.bo.tabstop = tab_width
vim.o.softtabstop = tab_width
vim.o.shiftround = true

-- >> <<
vim.o.shiftwidth = tab_width
vim.bo.shiftwidth = tab_width

-- Turn Tab to Space
vim.o.expandtab = true
vim.bo.expandtab = true

----- Indent -----
------------------
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

----- Reaction Times -----
--------------------------

vim.o.timeout = true
vim.o.timeoutlen = uConfig.setting.timeoutlen
vim.o.updatetime = uConfig.setting.updatetime

----- Search -----
------------------

-- Case
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.incsearch = true

----- Others -----
------------------
vim.o.autoread = true
vim.bo.autoread = true

vim.o.hidden = true

if uConfig.enable.mouse then
    vim.o.mouse = 'a'
else
    vim.o.mouse = ''
end

vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

vim.o.splitbelow = true
vim.o.splitright = true

-- Do not select when autocomplete
vim.g.completeopt = 'menu,menuone,noselect,noinsert'

-- Do not pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. 'c'

-- Clipboard Setting
vim.opt.clipboard = 'unnamedplus'
vim.opt.foldtext = 'v:lua.require("utils.simple_fold").simple_fold()'

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Fold
vim.o.foldenable = true
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
if not uConfig.enable.lite_mode then
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
end

-- Session
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Speed up loading Lua modules in Neovim to improve startup time.
vim.loader.enable()
