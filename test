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
badd +1 lua/dap/nvim-dap/init.lua
badd +172 lua/keybindings.lua
badd +119 lua/uConfig.lua
badd +16 init.lua
badd +221 lua/plugins.lua
badd +6 lua/dap/nvim-dap/ui.lua
argglobal
%argdel
$argadd NvimTree_1
edit lua/dap/nvim-dap/init.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
3wincmd k
wincmd w
wincmd w
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
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
wincmd =
argglobal
balt init.lua
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
11,13fold
15,19fold
let &fdl = &fdl
let s:l = 10 - ((7 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 10
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("init.lua", ":p")) | buffer init.lua | else | edit init.lua | endif
if &buftype ==# 'terminal'
  silent file init.lua
endif
balt lua/plugins.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 16 - ((7 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 16
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("lua/plugins.lua", ":p")) | buffer lua/plugins.lua | else | edit lua/plugins.lua | endif
if &buftype ==# 'terminal'
  silent file lua/plugins.lua
endif
balt lua/dap/nvim-dap/ui.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
13,15fold
8,17fold
20,22fold
44,46fold
43,47fold
48,50fold
41,51fold
52,56fold
57,61fold
67,69fold
64,70fold
75,77fold
73,78fold
88,90fold
86,91fold
84,92fold
93,95fold
82,96fold
101,103fold
98,104fold
109,111fold
107,112fold
120,123fold
164,166fold
161,168fold
173,176fold
177,179fold
171,180fold
185,187fold
183,188fold
193,195fold
191,196fold
204,206fold
202,207fold
212,214fold
210,215fold
222,224fold
220,225fold
234,236fold
237,239fold
231,240fold
248,250fold
245,251fold
392,394fold
25,395fold
400,402fold
399,403fold
398,404fold
396,405fold
24,406fold
let &fdl = &fdl
let s:l = 221 - ((5 * winheight(0) + 7) / 14)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 221
normal! 035|
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists(fnamemodify("~/.config/nvim/lua/dap/nvim-dap/ui.lua", ":p")) | buffer ~/.config/nvim/lua/dap/nvim-dap/ui.lua | else | edit ~/.config/nvim/lua/dap/nvim-dap/ui.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/dap/nvim-dap/ui.lua
endif
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
let &fdl = &fdl
let s:l = 20 - ((6 * winheight(0) + 6) / 13)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 20
normal! 089|
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists(fnamemodify("~/.config/nvim/lua/keybindings.lua", ":p")) | buffer ~/.config/nvim/lua/keybindings.lua | else | edit ~/.config/nvim/lua/keybindings.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/keybindings.lua
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
28,32fold
67,88fold
91,99fold
106,108fold
109,111fold
115,117fold
123,125fold
104,126fold
144,172fold
let &fdl = &fdl
let s:l = 163 - ((23 * winheight(0) + 14) / 28)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 163
normal! 07|
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists(fnamemodify("~/.config/nvim/lua/uConfig.lua", ":p")) | buffer ~/.config/nvim/lua/uConfig.lua | else | edit ~/.config/nvim/lua/uConfig.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/uConfig.lua
endif
balt ~/.config/nvim/lua/keybindings.lua
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
138,156fold
158,160fold
162,164fold
7,186fold
188,196fold
198,207fold
212,215fold
217,220fold
209,221fold
223,232fold
234,241fold
1,242fold
let &fdl = &fdl
let s:l = 85 - ((4 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 85
normal! 09|
lcd ~/.config/nvim
wincmd w
3wincmd w
wincmd =
tabnext 1
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
