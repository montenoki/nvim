--------- Preference Setting ----------

-- hjkl 移動時の上下デッドゾーン
vim.o.scrolloff = 4
vim.o.sidescrolloff = 4

-- 垂直ルーラー表示
vim.wo.colorcolumn = '80,120'

-- Tab の長さ
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true

-- >> << 移動距離
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4

-- タイピング停止時から反映されるまでの時間
vim.o.updatetime = 50

-- キーコードの待ち時間 (ms)
vim.o.timeoutlen = 2000

-- 自動補完の表示数
vim.o.pumheight = 5

-- 特殊文字コードの見える化
vim.o.list = true
vim.o.listchars = 'eol:↲,space:·,trail:●,tab:→→'

-- 相対的に行番号表示
vim.wo.relativenumber = true

-- 検索時ハイライト
vim.o.hlsearch = true

------------ Fixed Setting -------------

-- Windowsターミナル: Powershell
local powershell_options = {
    shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell',
    shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
    shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
    shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
    shellquote = '',
    shellxquote = '',
}
if getSysName() == 'Windows' then
    for option, value in pairs(powershell_options) do
        vim.o[option] = value
    end
end

-- utf8
vim.g.encoding = 'UTF-8'
vim.o.fileencoding = 'utf-8'

-- 行番号表示
vim.wo.number = true

-- 所在行ハッチング
vim.wo.cursorline = true

-- アイコン列表示
vim.wo.signcolumn = 'yes'

-- Tab を Space に変更
vim.o.expandtab = true
vim.bo.expandtab = true

-- 自動インデント
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

-- 大文字込みのキーワード以外では、大文字小文字無視検索
vim.o.ignorecase = true
vim.o.smartcase = true

-- 入力中検索
vim.o.incsearch = true

-- CMD バー2行表示
vim.o.cmdheight = 2

-- 編集中のファイルを自動 Reload（外部修正があった場合）
vim.o.autoread = true
vim.bo.autoread = true

-- 行の折返し
vim.wo.wrap = true

-- ← → で行頭行尾移動時、次の行に移動
vim.o.whichwrap = '<,>,[,]'

-- 修正ありの Buffer は非表示可能
vim.o.hidden = true

-- マウスサポート ON
vim.o.mouse = 'a'

-- バックアップ OFF
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- split window 右と下に
vim.o.splitbelow = true
vim.o.splitright = true

-- 自動補完時、自動選択しない
vim.g.completeopt = 'menu,menuone,noselect,noinsert'

-- スタイル
vim.o.termguicolors = true
vim.opt.termguicolors = true

-- 自動補完機能のメニュー表示
vim.o.wildmenu = true

-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. 'c'

-- Tabline 常時表示
vim.o.showtabline = 2

-- 純正のモード表示 OFF （拡張により表示）
vim.o.showmode = false

-- clipboard Setting
vim.opt.clipboard = 'unnamedplus'
vim.opt.foldtext = 'v:lua.require("utils.simple_fold").sinple_fold()'

-- Fold
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1'
vim.o.foldnestmax = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
