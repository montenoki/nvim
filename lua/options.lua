local ascii = require('util.ascii')
local opt = vim.opt

-- Use system clipboard
opt.clipboard = 'unnamedplus'

-- Line length ruler
opt.colorcolumn = '81'

-- List of options for Insert mode completion
-- 支持的值有：
-- menu: 使用弹出菜单显示可能的补全选项, 菜单仅在有多个匹配项时显示
-- menuone: 即使只有一个匹配项也使用弹出菜单, 当有关于匹配的额外信息时很有用
-- longest: 仅插入匹配项中最长的公共文本, 如果显示菜单, 可以使用 CTRL-L 添加更多字符
-- preview: 在预览窗口中显示当前选择的补全的额外信息, 仅在menu+menuone结合使用时有效
-- popup: 在弹出窗口中显示当前选择的补全的额外信息, 仅在menu+menuone结合使用时有效, 覆盖preview
-- noinsert: 在用户从菜单中选择匹配项之前, 不插入任何文本, 仅在menu+menuone结合使用时有效, 如果存在longest则无效
-- noselect: 不在菜单中选择匹配项, 强制用户从菜单中选择, 仅在menu+menuone结合使用时有效
-- fuzzy: 启用模糊匹配以完成候选项
--        这允许更灵活和直观的匹配, 可以跳过字符, 即使没有键入确切的顺序也可以找到匹配项
--        仅在如何从备选列表中减少完成候选项方面有所不同，但不影响候选项的收集方式
opt.completeopt = { 'menu', 'menuone', 'popup', 'noselect', 'noinsert' }
-- FIX(2024/07/28): 添加fuzzy报错
-- opt.completeopt:append({ 'fuzzy' })

-- 确定带有 "conceal" 语法属性 :syn-conceal 的文本显示方式
-- 0 文本正常显示
-- 1 每个隐藏文本块都被替换为一个字符。如果语法项没有定义自定义替换字符（参见 :syn-cchar）, 则使用 'listchars' 中定义的字符。
-- 2 隐藏文本完全隐藏，除非它有定义的自定义替换字符（参见 :syn-cchar）
-- 3 隐藏文本完全隐藏
opt.conceallevel = 1

-- 当confirm开启时，某些操作通常会因为缓冲区中未保存的更改而失败，
-- 例如“:q”和“:e”，此时会弹出一个对话框询问您是否希望保存当前文件
opt.confirm = true

-- 突出显示光标所在的文本行，使用 CursorLine hl-CursorLine
-- 便于轻松找到光标。会使屏幕重绘变慢
-- 当处于可视模式时，不使用高亮显示，以便更容易看到选定的文本。
opt.cursorline = true

-- 在插入模式下：使用适当数量的空格代替<Tab>
-- 当 'autoindent' 开启时，使用 '>' 和 '<' 命令的缩进中使用空格。
-- 要在 'expandtab' 开启时插入一个真实的制表符，请使用 CTRL-V<Tab>。
opt.expandtab = true

-- -- =============================================================================
-- --   Basic - 基本設定
-- -- =============================================================================

--
-- opt.mouse = 'a' -- マウスサポート
-- opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
-- opt.timeoutlen = 50
-- opt.undofile = true
-- opt.undolevels = 10000
-- opt.updatetime = 100

-- -- 自動補完

-- opt.wildmode = 'longest:full,full'

-- -- 検索
-- opt.ignorecase = true -- 大文字と小文字を同等に取り扱う
-- opt.smartcase = true -- 大文字が入る場合、大文字を無視しない

-- -- インデント

-- opt.shiftround = true -- シフト時shiftwidthの値の倍数になるようにスペースを挿入
-- opt.smartindent = true -- 自動的にインデントを入力する

-- -- ウィンドウ
-- opt.splitbelow = true -- 新規Windowの方向
-- opt.splitright = true
-- opt.splitkeep = 'screen'

-- -- grep 設定
-- opt.grepprg = 'rg --vimgrep'
-- opt.grepformat = '%f:%l:%c:%m'

-- -- 折り畳み設定
-- opt.foldenable = true
-- opt.foldlevelstart = 99
-- opt.foldlevel = 99
-- opt.foldcolumn = '1'
-- opt.foldmethod = 'indent'

-- -- UI

-- opt.laststatus = 3 -- global statusline
-- opt.number = true -- Print line number
-- opt.pumheight = 5 -- Maximum number of entries in a popup
-- opt.showmode = false -- Dont show mode since we have a statusline
-- opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
-- opt.termguicolors = true
-- opt.virtualedit = 'onemore' -- fix the problem that cant see last char when scrollbar on.
-- opt.winminwidth = 5 -- Minimum window width
-- opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- -- =============================================================================
-- --   preference.lua - 好み設定
-- -- =============================================================================

-- local tab_width = 2

-- opt.whichwrap = '<,>,[,]' -- Use arrow key to move next line when cursor at end of line
-- opt.scrolloff = 4 -- Lines of context
-- opt.sidescrolloff = 4 -- Columns of context

-- -- Tab
-- opt.tabstop = tab_width -- Number of spaces tabs count for
-- opt.shiftwidth = tab_width -- Size of an indent

-- -- UI


-- opt.list = true -- Show some invisible characters (tabs...
-- opt.listchars = vim.g.lite == nil and 'eol:↲,tab:<->,trail:~,extends:,precedes:,nbsp:␣' or ascii.listchars
-- opt.relativenumber = false -- Relative line numbers
-- opt.wrap = false -- Disable line wrap

-- -- =============================================================================
-- --   その他設定
-- -- =============================================================================

-- -- TODO: 移动到lang/sh.lua
-- -- Add extra filetypes
-- vim.filetype.add({
--   filename = {
--     ['.zshrc'] = 'sh',
--     ['.zsh'] = 'sh',
--     ['.zlogout'] = 'sh',
--   },
-- })

-- -- Setup python provider
-- local executable_path = '/.virtualenvs/neovim/bin/python'
-- if string.find(string.lower(vim.loop.os_uname().sysname), 'windows') then
--   executable_path = '\\.virtualenvs\\neovim\\Scripts\\python.exe'
-- end
-- vim.g.python3_host_prog = vim.env.HOME .. executable_path

-- -- Disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- -- Fix markdown indentation settings
-- vim.g.markdown_recommended_style = 0
