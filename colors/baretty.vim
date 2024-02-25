set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "baretty"

" let s:black=16
" let s:darkred=160
" let s:darkgreen=40
" let s:darkyellow=184
" let s:darkblue=20
" let s:darkmagenta=164
" let s:darkcyan=44
" let s:grey=254
" let s:darkgrey=46
" let s:red=196
" let s:green=46
" let s:yellow=226
" let s:blue=63
" let s:magenta=201
" let s:cyan=51
" let s:white=231

" color: xterm0         #000000          16                black
" color: xterm1         #cd0000          160               darkred
" color: xterm2         #00cd00          40                darkgreen
" color: xterm3         #cdcd00          184               darkyellow
" color: xterm4         #0000ee          20                darkblue
" color: xterm5         #cd00cd          164               darkmagenta
" color: xterm6         #00cdcd          44                darkcyan
" color: xterm7         #e5e5e5          254               grey
" color: xterm8         #7f7f7f          102               darkgrey
" color: xterm9         #ff0000          196               red
" color: xterm10        #00ff00          46                green
" color: xterm11        #ffff00          226               yellow
" color: xterm12        #5c5cff          63                blue
" color: xterm13        #ff00ff          201               magenta
" color: xterm14        #00ffff          51                cyan
" color: xterm15        #ffffff          231               white

hi cursor ctermfg=none ctermbg=none cterm=none
hi visual ctermfg=black ctermbg=grey cterm=none "HACK"
hi cursorline ctermfg=none ctermbg=none cterm=none
hi cursorcolumn ctermfg=none ctermbg=none cterm=none
hi colorcolumn ctermfg=none ctermbg=red cterm=none "HACK"
hi linenr ctermfg=yellow ctermbg=none cterm=none "HACK"
hi vertsplit ctermfg=none ctermbg=none cterm=none
hi matchparen ctermfg=none ctermbg=none cterm=none
hi statusline ctermfg=none ctermbg=none cterm=none
hi statuslinenc ctermfg=none ctermbg=none cterm=none
hi pmenu ctermfg=none ctermbg=none cterm=none
hi pmenusel ctermfg=none ctermbg=none cterm=none
hi incsearch ctermfg=none ctermbg=none cterm=none
hi search ctermfg=none ctermbg=none cterm=none
hi directory ctermfg=none ctermbg=none cterm=none
hi folded ctermfg=none ctermbg=none cterm=none
hi normal ctermfg=grey ctermbg=none cterm=none "HACK"
hi boolean ctermfg=blue ctermbg=none cterm=none "HACK"
hi character ctermfg=none ctermbg=none cterm=none "HACK"
hi comment ctermfg=darkgrey ctermbg=none cterm=none "HACK"
hi conditional ctermfg=none ctermbg=none cterm=none
hi constant ctermfg=none ctermbg=none cterm=none
hi define ctermfg=none ctermbg=none cterm=none
hi diffadd ctermfg=none ctermbg=none cterm=none
hi diffdelete ctermfg=none ctermbg=none cterm=none
hi diffchange ctermfg=none ctermbg=none cterm=none
hi difftext ctermfg=none ctermbg=none cterm=none
hi errormsg ctermfg=red ctermbg=none cterm=none "HACK"
hi warningmsg ctermfg=none ctermbg=none cterm=none
hi float ctermfg=none ctermbg=none cterm=none
hi function ctermfg=none ctermbg=none cterm=none
hi identifier ctermfg=none ctermbg=none cterm=none
hi keyword ctermfg=red ctermbg=none cterm=none "HACK"
hi label ctermfg=blue ctermbg=none cterm=none "HACK"
hi nontext ctermfg=none ctermbg=none cterm=none
hi number ctermfg=none ctermbg=none cterm=none
hi operator ctermfg=none ctermbg=none cterm=none
hi preproc ctermfg=none ctermbg=none cterm=none
hi special ctermfg=none ctermbg=none cterm=none
hi specialkey ctermfg=red ctermbg=none cterm=none
hi statement ctermfg=none ctermbg=none cterm=none
hi storageclass ctermfg=none ctermbg=none cterm=none
hi string ctermfg=none ctermbg=none cterm=none
hi tag ctermfg=none ctermbg=none cterm=none
hi title ctermfg=none ctermbg=none cterm=none
hi todo ctermfg=none ctermbg=none cterm=none
hi type ctermfg=none ctermbg=none cterm=none
hi underlined ctermfg=none ctermbg=none cterm=none
hi rubyclass ctermfg=none ctermbg=none cterm=none
hi rubyfunction ctermfg=none ctermbg=none cterm=none
hi rubyinterpolationdelimiter ctermfg=none ctermbg=none cterm=none
hi rubysymbol ctermfg=none ctermbg=none cterm=none
hi rubyconstant ctermfg=none ctermbg=none cterm=none
hi rubystringdelimiter ctermfg=none ctermbg=none cterm=none
hi rubyblockparameter ctermfg=none ctermbg=none cterm=none
hi rubyinstancevariable ctermfg=none ctermbg=none cterm=none
hi rubyinclude ctermfg=none ctermbg=none cterm=none
hi rubyglobalvariable ctermfg=none ctermbg=none cterm=none
hi rubyregexp ctermfg=none ctermbg=none cterm=none
hi rubyregexpdelimiter ctermfg=none ctermbg=none cterm=none
hi rubyescape ctermfg=none ctermbg=none cterm=none
hi rubycontrol ctermfg=none ctermbg=none cterm=none
hi rubyclassvariable ctermfg=none ctermbg=none cterm=none
hi rubyoperator ctermfg=none ctermbg=none cterm=none
hi rubyexception ctermfg=none ctermbg=none cterm=none
hi rubypseudovariable ctermfg=none ctermbg=none cterm=none
hi rubyrailsuserclass ctermfg=none ctermbg=none cterm=none
hi rubyrailsarassociationmethod ctermfg=none ctermbg=none cterm=none
hi rubyrailsarmethod ctermfg=none ctermbg=none cterm=none
hi rubyrailsrendermethod ctermfg=none ctermbg=none cterm=none
hi rubyrailsmethod ctermfg=none ctermbg=none cterm=none
hi erubydelimiter ctermfg=none ctermbg=none cterm=none
hi erubycomment ctermfg=none ctermbg=none cterm=none
hi erubyrailsmethod ctermfg=none ctermbg=none cterm=none
hi htmltag ctermfg=none ctermbg=none cterm=none
hi htmlendtag ctermfg=none ctermbg=none cterm=none
hi htmltagname ctermfg=none ctermbg=none cterm=none
hi htmlarg ctermfg=none ctermbg=none cterm=none
hi htmlspecialchar ctermfg=none ctermbg=none cterm=none
hi javascriptfunction ctermfg=none ctermbg=none cterm=none
hi javascriptrailsfunction ctermfg=none ctermbg=none cterm=none
hi javascriptbraces ctermfg=none ctermbg=none cterm=none
hi yamlkey ctermfg=none ctermbg=none cterm=none
hi yamlanchor ctermfg=none ctermbg=none cterm=none
hi yamlalias ctermfg=none ctermbg=none cterm=none
hi yamldocumentheader ctermfg=none ctermbg=none cterm=none
hi cssurl ctermfg=none ctermbg=none cterm=none
hi cssfunctionname ctermfg=none ctermbg=none cterm=none
hi csscolor ctermfg=none ctermbg=none cterm=none
hi csspseudoclassid ctermfg=none ctermbg=none cterm=none
hi cssclassname ctermfg=none ctermbg=none cterm=none
hi cssvaluelength ctermfg=none ctermbg=none cterm=none
hi csscommonattr ctermfg=none ctermbg=none cterm=none
hi cssbraces ctermfg=none ctermbg=none cterm=none
hi @variable ctermfg=red 

" let s:t_co = &t_co
" let s:t_co = 1

" hi! link terminal normal
" hi! link boolean constant
" hi! link character constant
" hi! link conditional repeat
" hi! link debug special
" hi! link define preproc
" hi! link delimiter special
" hi! link exception statement
" hi! link float number
" hi! link include preproc
" hi! link keyword statement
" hi! link label statement
" hi! link macro preproc
" hi! link number constant
" hi! link popupselected pmenusel
" hi! link precondit preproc
" hi! link specialchar special
" hi! link specialcomment special
" hi! link statuslineterm statusline
" hi! link statuslinetermnc statuslinenc
" hi! link storageclass type
" hi! link string constant
" hi! link structure type
" hi! link tag special
" hi! link typedef type
" hi! link lcursor cursor
" hi! link cursearch search
" hi! link cursorlinefold cursorline
" hi! link cursorlinesign cursorline
" hi! link messagewindow pmenu
" hi! link popupnotification todo

" background: dark
" color: xterm0         #000000          16                black
" color: xterm1         #cd0000          160               darkred
" color: xterm2         #00cd00          40                darkgreen
" color: xterm3         #cdcd00          184               darkyellow
" color: xterm4         #0000ee          20                darkblue
" color: xterm5         #cd00cd          164               darkmagenta
" color: xterm6         #00cdcd          44                darkcyan
" color: xterm7         #e5e5e5          254               grey
" color: xterm8         #7f7f7f          102               darkgrey
" color: xterm9         #ff0000          196               red
" color: xterm10        #00ff00          46                green
" color: xterm11        #ffff00          226               yellow
" color: xterm12        #5c5cff          63                blue
" color: xterm13        #ff00ff          201               magenta
" color: xterm14        #00ffff          51                cyan
" color: xterm15        #ffffff          231               white
" color: pmenu          #444444          238               darkgrey
" color: cursorline     #3a3a3a          237               darkgrey
" color: rgbgrey40      #666666          59                darkgrey
" color: rgbdarkgrey    #a9a9a9          145               darkgrey
" color: rgbblue        #0000ff          21                darkblue
" color: rgbdarkcyan    #008b8b          30                darkcyan
" color: directory      #00ffff          51                cyan
" color: rgbseagreen    #2e8b57          29                darkgreen
" color: rgbgrey        #bebebe          250               grey
" color: question       #00ff00          46                green
" color: signcolumn     #a9a9a9          248               grey
" color: specialkey     #00ffff          51                cyan
" color: title          #ff00ff          201               magenta
" color: warningmsg     #ff0000          196               red
" color: toolbarline    #7f7f7f          244               darkgrey
" color: underlined     #80a0ff          111               blue
" color: elfcomment     #80a0ff          111               blue
" color: elfidentifier  #40ffff          87                cyan
" color: elfstatement   #aa4444          131               darkred
" color: elfpreproc     #ff80ff          213               magenta
" color: elftype        #60ff60          83                green
" color: elfblue        #0000ff          21                blue
" term colors: xterm0 xterm1 xterm2 xterm3 xterm4 xterm5 xterm6 xterm7
" term colors: xterm8 xterm9 xterm10 xterm11 xterm12 xterm13
" term colors: xterm14 xterm15
" color: bgdiffa     #5f875f        65             darkgreen
" color: bgdiffc     #5f87af        67             blue
" color: bgdiffd     #af5faf        133            magenta
" color: bgdifft     #c6c6c6        251            grey
" color: fgdiffw     #ffffff        231            white
" color: fgdiffb     #000000        16             black
" color: bgdiffc8    #5f87af        67             darkblue
" color: bgdiffd8    #af5faf        133            darkmagenta
" vim: et ts=8 sw=2 sts=2
