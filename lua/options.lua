local opt = vim.opt
local tabWidth = 4

-- Use system clipboard
opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus' -- Sync with system clipboard

-- Line length ruler
opt.colorcolumn = '+1'

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
opt.conceallevel = 2

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

-- 用于填充状态栏、垂直分隔符和窗口中特殊列的字符
-- 任何被省略的内容将回退到默认值。
-- "horiz", "horizup", "horizdown", "vertleft", "vertright" and	"verthoriz"
-- 只在 'laststatus' 为 3 时使用，否则只使用垂直窗口分隔符
-- 如果 'ambiwidth' 是 "double"，那么
-- "horiz", "horizup", "horizdown",	"vert",
-- "vertleft", "vertright", "verthoriz", "foldsep" and "fold" 默认使用单字节替代
-- 对于“stl”、“stlnc”、“foldopen”、“foldclose”和“foldsep”项目
-- 支持单字节和多字节字符。但不支持双宽字符

-- item       default     Used for
-- stl        ' '         statusline of the current window
-- stlnc      ' '         statusline of the non-current windows
-- wbr        ' '         window bar
-- horiz      '─' or '-'  horizontal separators :split
-- horizup    '┴' or '-'  upwards facing horizontal separator
-- horizdown  '┬' or '-'  downwards facing horizontal separator
-- vert       '│' or '|'  vertical separators :vsplit
-- vertleft   '┤' or '|'  left facing vertical separator
-- vertright  '├' or '|'  right facing vertical separator
-- verthoriz  '┼' or '+'  overlapping vertical and horizontal
-- separator
-- fold       '·' or '-'  filling 'foldtext'
-- foldopen   '-'         mark the beginning of a fold
-- foldclose  '+'         show a closed fold
-- foldsep    '│' or '|'  open fold middle marker
-- diff       '-'         deleted lines of the 'diff' option
-- msgsep     ' '         message separator 'display'
-- eob        '~'         empty lines at the end of a buffer
-- lastline   '@'         'display' contains lastline/truncate
opt.fillchars = { eob = ' ', fold = ' ', foldopen = '', foldsep = ' ', foldclose = '' }

-- 如果启用此选项，文件末尾缺失的<EOL>将被恢复。
-- 如果您想保留原始文件的情况，请关闭此选项。
opt.fixendofline = false

-- TODO: 添加注释
opt.formatexpr = 'v:lua.require("utils").formatexpr()'

-- 影响 Vim 格式化文本的方式
-- 默认为"cjqt"
-- t:  使用 'textwidth' 自动换行文本
-- c:  注释使用'textwidth'自动换行，并自动插入当前注释前缀
-- r:  在插入模式下按下<Enter>后自动插入当前注释符
-- o:  在普通模式下按下 'o' 或 'O' 后自动插入当前注释符号
--     如果在特定位置不需要注释，请使用 CTRL-U 快速删除它。i_CTRL-U
-- /:  当opt中包含 'o' 时：仅当//在行首时插入注释符号
-- q:  允许使用“gq”格式化注释
--     请注意，格式化不会更改空行或仅包含注释前缀的行
--     新段落在此类行之后或注释前缀更改时开始。
-- w:  尾随空白符表示段落在下一行继续
--     具体来说，这意味着当你在一行的末尾添加一个空格时
--     Neovim 会将该行视为段落的一部分，并在下一行继续该段落，而不是开始一个新的段落。
-- a:  段落的自动格式化
--     每次插入或删除文本时，段落将被重新格式化
--     请参阅自动格式化。当存在“c”标志时，这仅发生在已识别的注释中。
-- n:  在格式化文本时，识别编号列表
--     这实际上使用了 'formatlistpat' 选项，因此可以使用任何类型的列表
--     数字后的文本缩进用于下一行。默认是找到一个数字
--     后面可以选择跟随 '.', ':', ')', ']' 或 '}'
--     注意，必须设置 'autoindent'。与 "2" 一起使用效果不佳。
-- 2:  在格式化文本时，使用段落第二行的缩进作为段落其余部分的缩进，而不是第一行的缩进
--     这支持第一行缩进与其余部分不同的段落。注意，必须设置 'autoindent'。
-- m:  也在 255 以上的多字节字符处断开
--     这对于每个字符都是一个单词的亚洲文本很有用
-- M:  在连接行时，不要在多字节字符前后插入空格。覆盖 'B' 标志
-- j:  在合理的情况下，合并行时删除注释符号
opt.formatoptions = { c = true, r = true, q = true, n = true, m = true, M = true, j = true }

-- 用于 :grep 命令的程序
-- 此选项可能包含 '%' 和 '#' 字符，这些字符在命令行中使用时会被扩展
-- 允许使用占位符 "$*" 来指定参数将被包含的位置。环境变量会被扩展 :set_env。
-- 有关包含空格和反斜杠的信息，请参见 option-backslash。
-- 特殊值：当 'grepprg' 设置为 "internal" 时，
-- :grep 命令的工作方式类似于 :vimgrep，:lgrep 类似于 :lvimgrep，
-- :grepadd 类似于 :vimgrepadd，:lgrepadd 类似于 :lvimgrepadd。
-- 另请参阅 :make_makeprg 部分，因为那里的大多数评论
-- 同样适用于 'grepprg'。出于安全原因，此选项不能从模式行或沙箱中设置。
opt.grepprg = 'rg --vimgrep  -uu'

-- 在搜索时忽略大小写
opt.ignorecase = true

-- 此选项的值会影响最后一个窗口何时会有状态行
-- 0: never
-- 1: only if there are at least two windows
-- 2: always
-- 3: always and ONLY the last window
opt.laststatus = 2

-- 如果开启，Vim 将在 'breakat' 中的字符处换行，
-- 而不是在屏幕上能容纳的最后一个字符处换行。
-- 与 'wrapmargin' 和 'textwidth' 不同，这不会在文件中插入 <EOL>，
-- 它只影响文件的显示方式，而不影响其内容。
-- 如果设置了 'breakindent'，行会在视觉上缩进。
-- 然后，'showbreak' 的值将用于放在换行前。这选项在 'wrap' 选项关闭时不使用。
-- 请注意，<EOL> 后的 <Tab> 字符大多不会显示正确数量的空白。
opt.linebreak = true

-- List mode: By default, show tabs as ">", trailing spaces as "-", and
-- non-breakable space characters as "+". Useful to see the difference
-- between tabs and spaces and for trailing blanks.
-- opt.list = true

-- eol:c  Character to show at the end of each line.  When
-- 			  omitted, there is no extra character at the end of the
-- 			  line.
-- tab:xy[z]  Two or three characters to be used to show a tab.
--            The third character is optional.
-- tab:xy  The 'x' is always used, then 'y' as many times as will
--         fit.
-- tab:xyz  The 'z' is always used, then 'x' is prepended, and
--          then 'y' is used as many times as will fit.
--          When "tab:" is omitted, a tab is shown as ^I.
-- space:c	Character to show for a space.  When omitted, spaces are left blank.
-- multispace:c...  One or more characters to use cyclically to show for
--                  multiple consecutive spaces.  Overrides the "space"
--                  setting, except for single spaces.  When omitted, the
--                  "space" setting is used.
--lead:c  Character to show for leading spaces.  When omitted,
--        leading spaces are blank.  Overrides the "space" and
--        "multispace" settings for leading spaces.  You can
--        combine it with "tab:", for example: set listchars+=tab:>-,lead:.
-- leadmultispace:c...  Like the lcs-multispace value, but for leading
--                      spaces only.  Also overrides lcs-lead for leading
--                      multiple spaces.
--                      :set listchars=leadmultispace:---+ shows ten
--                      consecutive leading spaces as: ---+---+--XXX
-- trail:c  用于显示尾随空格的字符
--          省略时，尾随空格为空白。
--          覆盖“space”和“multispace”设置的尾随空格。
-- extends:c  当 'wrap' 关闭且行超出屏幕右侧时，在最后一列显示的字符
-- precedes:c  当第一个列中有字符之前的文本时, 在物理行的第一个可见列中显示的字符
--conceal:c  当 'conceallevel' 设置为 1 时，用于显示隐藏文本的字符。省略时为空格
-- nbsp:c  用于显示不间断空格字符（0xA0（十进制 160）和 U+202F）的字符。省略时留空
opt.listchars = { eol = '↲', tab = '<->', trail = '~', extends = '', precedes = '', nbsp = '␣' }

-- 启用鼠标支持
-- 要暂时禁用鼠标支持，请在使用时按住 Shift 键
opt.mouse = 'a'

-- 在每行前打印行号
opt.number = true

-- 弹出菜单中显示的最大项目数
-- 0表示“使用可用的屏幕空间”
opt.pumheight = 0

-- 光标所在行显示相对行号
opt.relativenumber = true

-- 光标上下方要保留的最少屏幕行数这将使您正在工作的地方周围的一些上下文可见
-- 如果将其设置为一个非常大的值（999），光标行将始终位于窗口的中间（除非在文件的开头或结尾或长行换行时）。
-- 在使用本地值后，使用以下两种方法之一返回全局值：
-- setlocal scrolloff<
-- setlocal scrolloff=-1
opt.scrolloff = 3

-- 更改 :mksession 命令的效果。它是一个逗号分隔的单词列表
-- 每个单词都可以启用保存和恢复某物
opt.sessionoptions:append({ 'winpos', 'localoptions' })

-- 将缩进调整为“shiftwidth”的倍数
opt.shiftround = true

-- （自动）缩进步骤的空格数
-- 用于 'cindent'、>>、<< 等
-- 当为0时，将使用 'tabstop' 值。使用 shiftwidth() 函数获取有效的 shiftwidth 值。
opt.shiftwidth = 0

-- 设置了 'nowrap'，则在光标的左侧和右侧保持的最小屏幕列数
-- 选项设置为大于 0 的值，同时将 'sidescroll' 也设置为非零值
-- 您在水平滚动的行中看到一些上下文（行首除外）
-- 选项设置为较大的值（如 999）只要不太接近行首, 会使光标在窗口中水平居中，
opt.sidescrolloff = 999

-- 何时以及如何绘制 signcolumn。有效值为：
-- "auto"  仅当有标志显示时
-- "auto:[1-9]"  调整大小以容纳多个标志，最多可达给定数量（最多 9 个），例如“auto:4”
-- "auto:[1-8]-[2-9]"  调整大小以容纳多个标志，最多可达给定的最大数量（最多 9 个）
--                     同时保持至少给定的最小（最多 8 个）固定空间
--                     最小数量应始终小于最大数量，例如“auto:2-5”
-- "no" 从不
-- "yes" 总是
-- "yes:[1-9]"  总是，固定空间用于符号最多到给定的数字（最多 9），例如 "yes:3"
--              “number”在“number”列中显示符号。
--              如果不存在数字列，则行为类似于“auto”。
opt.signcolumn = 'auto:2-9'

-- 如果搜索模式包含大写字符，则覆盖 'ignorecase' 选项
-- 仅在输入搜索模式并且 'ignorecase' 选项开启时使用。
opt.smartcase = true

-- 在开始新行时进行智能自动缩进
-- 适用于类 C 程序，但也可用于其他语言
-- 通常在使用'smartindent'时，'autoindent'也应该开启
opt.smartindent = true

opt.splitbelow = true
opt.splitright = true

-- Number of spaces that a <Tab> in the file counts for.
opt.tabstop = tabWidth

-- 正在插入文本的最大宽度
-- 较长的行将在空白处断开以达到此宽度
-- 零值将禁用此功能
-- 当 'textwidth' 为零时，可以使用 'wrapmargin'
-- 另请参见 'formatoptions' 和 ins-textwidth
-- 当设置了 'formatexpr' 时，它将用于断行
opt.textwidth = 80

-- 等待映射序列完成的时间（以毫秒为单位）
opt.timeoutlen = 100

opt.updatetime = 100

-- 当开启时，Vim 在将缓冲区写入文件时会自动将撤销历史保存到撤销文件中
-- 并在读取缓冲区时从同一文件中恢复撤销历史。
opt.undofile = true

-- 最大可撤销的更改次数
opt.undolevels = 10000

-- 允许指定的键在光标位于行首/行尾字符时
-- 左右移动光标以移动到上一行/下一行
-- <  <Left>   Normal and Visual
-- >  <Right>  Normal and Visual
-- [  <Left>   Insert and Replace
-- ]  <Right>  Insert and Replace
-- Use arrow key to move next line when cursor at end of line
opt.whichwrap = '<,>,[,]'

-- 用于指定“wildchar”字符的完成模式
-- 它是一个最多包含四部分的逗号分隔列表
-- 每一部分指定连续使用“wildchar”时的操作
-- 第一部分指定第一次使用“wildchar”的行为，第二部分指定第二次使用的行为，依此类推
-- ""  仅完成第一个匹配。
-- "full"  完成下一个完整匹配
--         在最后一个匹配之后，使用原始字符串，然后再次进行第一次匹配
--         如果启用了 'wildmenu'，也将启动它。
-- "longest"  完成直到最长公共字符串。如果这没有产生更长的字符串，使用下一部分
-- "list"  当有多个匹配项时，列出所有匹配项。
-- "lastused"  在完成缓冲区名称并且有多个缓冲区匹配时，
--             按上次使用时间排序缓冲区（当前缓冲区除外）
--             当只有一个匹配时，在所有情况下都完全完成。
opt.wildmode = { 'longest:full', 'full' }

-- =============================================================================
--   その他設定
-- =============================================================================

-- Setup python provider
local executablePath = '/.virtualenvs/neovim/bin/python'
if string.find(string.lower(vim.loop.os_uname().sysname), 'windows') then
    executablePath = '\\.virtualenvs\\neovim\\Scripts\\python.exe'
end
vim.g.python3_host_prog = vim.env.HOME .. executablePath

-- =============================================================================
--   TODO
-- =============================================================================
-- TODO: 2024/07/28: 考虑是否需要设置
-- opt.splitkeep = 'screen'

-- Nvim 将自动尝试确定主机终端是否
-- 支持 24 位颜色并将在可能时启用此选项
-- opt.termguicolors = true

-- TODO: 2024/07/28: 移动到scrollbar文件中
-- fix the problem that cant see last char when scrollbar on.
-- opt.virtualedit = 'onemore'

-- -- TODO: 移动到lang/sh.lua
-- -- Add extra filetypes
-- vim.filetype.add({
--   filename = {
--     ['.zshrc'] = 'sh',
--     ['.zsh'] = 'sh',
--     ['.zlogout'] = 'sh',
--   },
-- })

-- TODO: 2024/07/28: 移动到markdown设置中
-- -- Fix markdown indentation settings
-- vim.g.markdown_recommended_style = 0
