let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +29 lua/plugin-config/interface/bufferline.lua
badd +1 lua/plugin-config/search/telescope.lua
badd +142 lua/uConfig.lua
badd +58 lua/plugins.lua
badd +0 NvimTree_1
argglobal
%argdel
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit NvimTree_1
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 40 + 124) / 248)
exe 'vert 2resize ' . ((&columns * 103 + 124) / 248)
exe 'vert 3resize ' . ((&columns * 103 + 124) / 248)
argglobal
balt lua/plugin-config/interface/bufferline.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal nofen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 21) / 42)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists(fnamemodify("~/.config/nvim/lua/plugin-config/interface/bufferline.lua", ":p")) | buffer ~/.config/nvim/lua/plugin-config/interface/bufferline.lua | else | edit ~/.config/nvim/lua/plugin-config/interface/bufferline.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/plugin-config/interface/bufferline.lua
endif
balt ~/.config/nvim/lua/uConfig.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
7,9fold
17,22fold
16,23fold
29,32fold
27,34fold
13,35fold
12,36fold
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 21) / 42)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists(fnamemodify("~/.config/nvim/lua/uConfig.lua", ":p")) | buffer ~/.config/nvim/lua/uConfig.lua | else | edit ~/.config/nvim/lua/uConfig.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/uConfig.lua
endif
balt ~/.config/nvim/lua/plugin-config/interface/bufferline.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
15,36fold
38,46fold
48,55fold
57,64fold
66,80fold
82,95fold
96,136fold
137,143fold
145,164fold
166,168fold
170,172fold
173,175fold
177,179fold
180,182fold
7,198fold
200,209fold
214,217fold
219,222fold
211,223fold
225,234fold
236,243fold
1,244fold
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 21) / 42)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
lcd ~/.config/nvim
wincmd w
exe 'vert 1resize ' . ((&columns * 40 + 124) / 248)
exe 'vert 2resize ' . ((&columns * 103 + 124) / 248)
exe 'vert 3resize ' . ((&columns * 103 + 124) / 248)
tabnext
edit ~/.config/nvim/lua/plugin-config/interface/bufferline.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 123 + 124) / 248)
exe 'vert 2resize ' . ((&columns * 124 + 124) / 248)
argglobal
balt ~/.config/nvim/lua/plugins.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
6,8fold
16,21fold
15,22fold
28,31fold
26,33fold
12,34fold
11,35fold
let &fdl = &fdl
let s:l = 29 - ((28 * winheight(0) + 21) / 42)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 29
normal! 016|
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists(fnamemodify("~/.config/nvim/lua/plugins.lua", ":p")) | buffer ~/.config/nvim/lua/plugins.lua | else | edit ~/.config/nvim/lua/plugins.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/plugins.lua
endif
balt ~/.config/nvim/lua/plugin-config/interface/bufferline.lua
setlocal fdm=diff
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 61 - ((36 * winheight(0) + 21) / 42)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 61
normal! 013|
lcd ~/.config/nvim
wincmd w
exe 'vert 1resize ' . ((&columns * 123 + 124) / 248)
exe 'vert 2resize ' . ((&columns * 124 + 124) / 248)
tabnext 2
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
