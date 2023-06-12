local uConfig = require('uConfig')

----- Display Settings -----
----------------------------

-- Movement Dead Zone
vim.o.scrolloff = 4
vim.o.sidescrolloff = 4

-- Code Ruler
vim.wo.colorcolumn = '80,120'

-- Listchars
if uConfig.lite_mode then
    vim.o.list = false
else
    vim.o.list = true
    vim.o.listchars = 'eol:↲,space:·,trail:●,tab:→→'
end

-- Row Number
vim.wo.number = true
vim.wo.relativenumber = true

-- Highlight
vim.o.hlsearch = true
vim.wo.cursorline = true

-- utf-8
vim.g.encoding = 'UTF-8'
vim.o.fileencoding = 'utf-8'

-- Icon column
vim.wo.signcolumn = 'yes'

-- CMD line height
vim.o.cmdheight = 2

-- wrap line
vim.wo.wrap = true

-- move to next line when use -> at end of line
vim.o.whichwrap = '<,>,[,]'

-- color
if not uConfig.lite_mode then
    vim.o.termguicolors = true
    vim.opt.termguicolors = true
end

-- Autocomplete
vim.o.pumheight = 5
vim.o.wildmenu = true

-- Tabline
vim.o.showtabline = 2

vim.o.showmode = false

----- Tab -----
---------------

-- Tab Width
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true

-- >> <<
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4

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
vim.o.timeoutlen = 2000
vim.o.updatetime = 50

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

-- vim.o.mouse = 'a'

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
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
if not uConfig.lite_mode then
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
end

-- Session
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
