local opt = vim.opt
local tab_width = 2

opt.autowrite = true           -- Enable auto write
opt.clipboard = "unnamedplus"  -- Sync with system clipboard
opt.colorcolumn = "80,120"     -- Line length marker
opt.completeopt = "menu,menuone,noselect,noinsert"
opt.conceallevel = 3           -- ? Hide * markup for bold and italic
opt.confirm = true             -- Confirm to save changes before exiting modified buffer
opt.cursorline = true          -- Enable highlighting of the current line
opt.expandtab = true           -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- ? tcqj
opt.grepformat = "%f:%l:%c:%m" -- ?
opt.grepprg = "rg --vimgrep"   -- ?
opt.ignorecase = true          -- Ignore case
opt.inccommand = "nosplit"     -- ? preview incremental substitute
opt.laststatus = 3             -- global statusline
opt.list = true                -- Show some invisible characters (tabs...
opt.listchars = {
  eol = "↲",
  tab = "→ ",
  trail = "·",
  extends = "❯",
  precedes = "❮",
  -- space = "␣",
}
opt.mouse = "a"           -- Enable mouse mode
opt.number = true         -- Print line number
opt.pumblend = 10         -- Popup blend
opt.pumheight = 5         -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4         -- Lines of context
opt.sessionoptions = { "blank", "buffers", "curdir", "winpos", "tabpages", "winsize", "help", "globals", "skiprtp",
  "folds" }
opt.shiftround = true      -- Round indent
opt.shiftwidth = tab_width -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false       -- Dont show mode since we have a statusline
opt.sidescrolloff = 4      -- Columns of context
opt.signcolumn = "yes"     -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true       -- Don't ignore case with capitals
opt.smartindent = true     -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true      -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true      -- Put new windows right of current
opt.tabstop = tab_width    -- Number of spaces tabs count for
opt.termguicolors = true   -- True color support
opt.timeoutlen = 500
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 100               -- Save swap file and trigger CursorHold
opt.virtualedit = "block"          -- Allow cursor to move where there is no text in visual block mode
opt.whichwrap = "<,>,[,]"          -- Use arrow key to move next line when cursor at end of line
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5                -- Minimum window width
opt.wrap = true                    -- Disable line wrap
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end

-- Folding
opt.foldlevel = 99
-- opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()" -- todo: check this
-- opt.foldtext = 'v:lua.require("utils.simple_fold").simple_fold()'

if vim.fn.has("nvim-0.9.0") == 1 then
  -- vim.opt.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]
end

-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
if vim.fn.has("nvim-0.10") == 1 then
  opt.foldmethod = "expr"
  -- vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()" -- todo: check this
else
  opt.foldmethod = "indent"
end

-- vim.o.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()" -- todo: check this

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Powershell Setting for Windows
local powershell_options = {
  shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell',
  shellcmdflag =
  '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
  shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
  shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
  shellquote = '',
  shellxquote = ''
}
local os_name = vim.loop.os_uname().sysname
if os_name == 'Windows' or os_name == 'Windows_NT' then
  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end
end
