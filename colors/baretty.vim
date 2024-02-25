set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "baretty"

hi cursor ctermfg=none ctermbg=none cterm=none
hi visual ctermfg=black ctermbg=grey cterm=none "HACK"
hi cursorline ctermfg=none ctermbg=none cterm=none
hi cursorcolumn ctermfg=none ctermbg=none cterm=none
hi colorcolumn ctermfg=none ctermbg=darkred cterm=none "HACK"
hi linenr ctermfg=DarkYellow ctermbg=none cterm=none "HACK"
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

hi! link terminal normal
hi! link boolean constant
hi! link character constant
hi! link conditional repeat
hi! link debug special
hi! link define preproc
hi! link delimiter special
hi! link exception statement
hi! link float number
hi! link include preproc
hi! link keyword statement
hi! link label statement
hi! link macro preproc
hi! link number constant
hi! link popupselected pmenusel
hi! link precondit preproc
hi! link specialchar special
hi! link specialcomment special
hi! link statuslineterm statusline
hi! link statuslinetermnc statuslinenc
hi! link storageclass type
hi! link string constant
hi! link structure type
hi! link tag special
hi! link typedef type
hi! link lcursor cursor
hi! link cursearch search
hi! link cursorlinefold cursorline
hi! link cursorlinesign cursorline
hi! link messagewindow pmenu
hi! link popupnotification todo

" Background: dark
" Color: xterm0         #000000          16                black
" Color: xterm1         #cd0000          160               darkred
" Color: xterm2         #00cd00          40                darkgreen
" Color: xterm3         #cdcd00          184               darkyellow
" Color: xterm4         #0000ee          20                darkblue
" Color: xterm5         #cd00cd          164               darkmagenta
" Color: xterm6         #00cdcd          44                darkcyan
" Color: xterm7         #e5e5e5          254               grey
" Color: xterm8         #7f7f7f          102               darkgrey
" Color: xterm9         #ff0000          196               red
" Color: xterm10        #00ff00          46                green
" Color: xterm11        #ffff00          226               yellow
" Color: xterm12        #5c5cff          63                blue
" Color: xterm13        #ff00ff          201               magenta
" Color: xterm14        #00ffff          51                cyan
" Color: xterm15        #ffffff          231               white
" Color: Pmenu          #444444          238               darkgrey
" Color: CursorLine     #3a3a3a          237               darkgrey
" Color: rgbGrey40      #666666          59                darkgrey
" Color: rgbDarkGrey    #a9a9a9          145               darkgrey
" Color: rgbBlue        #0000ff          21                darkblue
" Color: rgbDarkCyan    #008b8b          30                darkcyan
" Color: Directory      #00ffff          51                cyan
" Color: rgbSeaGreen    #2e8b57          29                darkgreen
" Color: rgbGrey        #bebebe          250               grey
" Color: Question       #00ff00          46                green
" Color: SignColumn     #a9a9a9          248               grey
" Color: SpecialKey     #00ffff          51                cyan
" Color: Title          #ff00ff          201               magenta
" Color: WarningMsg     #ff0000          196               red
" Color: ToolbarLine    #7f7f7f          244               darkgrey
" Color: Underlined     #80a0ff          111               blue
" Color: elfComment     #80a0ff          111               blue
" Color: elfIdentifier  #40ffff          87                cyan
" Color: elfStatement   #aa4444          131               darkred
" Color: elfPreProc     #ff80ff          213               magenta
" Color: elfType        #60ff60          83                green
" Color: elfBlue        #0000ff          21                blue
" Term colors: xterm0 xterm1 xterm2 xterm3 xterm4 xterm5 xterm6 xterm7
" Term colors: xterm8 xterm9 xterm10 xterm11 xterm12 xterm13
" Term colors: xterm14 xterm15
" Color: bgDiffA     #5F875F        65             darkgreen
" Color: bgDiffC     #5F87AF        67             blue
" Color: bgDiffD     #AF5FAF        133            magenta
" Color: bgDiffT     #C6C6C6        251            grey
" Color: fgDiffW     #FFFFFF        231            white
" Color: fgDiffB     #000000        16             black
" Color: bgDiffC8    #5F87AF        67             darkblue
" Color: bgDiffD8    #AF5FAF        133            darkmagenta
