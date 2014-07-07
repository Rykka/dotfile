"""""""""""""""""""""""""""""""""""""""""""""""""
"  Script: Rykka's Vimrc
"  Author: Rykka <Rykka10(at)gmail.com>
"  Update: 2014-07-07
"  License: WTFPL v2.0 
" vim:ft=vim tw=0 sw=4 ts=4 sts=4 fdm=marker fdls=0 :
""""""""""""""""""""""""""""""""""""""""""""""""
" TODO:
" Install step.
" 0. get the script 
    " .vim_init (copy or clone it to the directory)
    " create .vimrc with 'so .vim_init' (or clone)
" 1. prepare the enviroment.
    " check os, 
    " if has no git, error and show a link for git
" 2. download user settings or config from start (.vim_init_conf): 
    " from github/dropbox/....
    " A. guidance for vim settings and generate .vimrc
        " like ':option' 
        " a. basic settings
        " b. ui
        " c. inputs 
        " d. formats
        " e. mappings
        " f. commands
        " g. aug
    " B. bundle and install vim plugins.
        " install vundle
        " suggest plugins.
    " C. user optimize script for vim.
" 3. upload personal settings
" 4. rate plugin in vim.org / vim.wikia.com ...
    
" git clone xxx .vimrc

let s:rc = {}
let g:_vimrc = s:rc

" Pre Install
" git clone se
let s:rc.root = '~/.vim/bundle'
" XXX: adding 'git:user@github.com' ?
"      or user modify the .git/config 
let s:rc.repo = 'http://github.com/Rykka/vundle.git'

" Check and install my vundle
" In the future. I will move the local part to a new plugin.
" if !isdirectory(s:rc.root)
"     call mkdir(expand(s:rc.root), 'p')
" endif
" if !isdirectory(s:rc.root . '/vundle')
"     let repo = s:rc.reporiv#buf_load_syn() 
"     let dir = shellescape(expand(s:rc.root . '/vundle'), 1)
"     exec '!git clone '  repo  dir
" endif

" 0.Vars "{{{1
let s:win_col       = 80
let s:win_row       = 42
let s:win_col_span2 = 2 * s:win_col + 1
let s:win_pos       = exists("s:win_pos") ? s:win_pos : 550
function! s:os_chk() "{{{
    if has("win32") || has("win64")
        return "windows"
    elseif has("mac")
        return "mac"
    elseif has("unix")
        let o = system("uname -a")
        if o =~? "ubuntu"
            return "ubuntu"
        elseif o=~ "ARCH"
            return "archlinux"
        else
            return "linux"
        endif
    endif
endfunction "}}}
function! s:auto_mkdir(dir, force) "{{{
    if !isdirectory(a:dir) && (a:force ||
    \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction "}}}
let mapleader       = " "
let maplocalleader  = ","
" /etc/vim/vimrc have added /var/lib to rtp.
" 1.Settings "{{{1
" init
" 1.0.Bundles "{{{2 
" load only once to improve vimrc reloading speed
let s:os = s:os_chk()
if !exists("g:vimrc_bundle_loaded") || g:vimrc_bundle_loaded == 0 "{{{
    let g:vimrc_bundle_loaded=1
    set nocompatible
    syntax on
    filetype off 
    
    " set it to 1 to enable it
    " then vundle will only adding the localbundle dir to &rtp.
    let g:vundle_local = 1
    " set the localbundle directory
    " let g:vundle_local_dir = '~/.vim/localbundle'
    " let g:localbundle_dir= '~/.vim/localbundle'


    if s:os=='windows'
        let dir =expand('~\.vim\bundle\vundle' )
    else
        let dir =expand('~/.vim/bundle/vundle' )
    endif
    exe 'set rtp+='.dir
    if !isdirectory(expand(dir))
        exe '!git clone https://github.com/gmarik/vundle.git '.dir
    endif
    call vundle#rc()
    Bundle 'gmarik/vundle'
    Bundle 'majutsushi/tagbar'
    Bundle 'sjl/gundo.vim'

    Bundle 'scrooloose/nerdtree'
    Bundle 'scrooloose/syntastic'

    Bundle 'Shougo/neocomplcache'
    Bundle 'Shougo/neosnippet'
    Bundle 'Shougo/neosnippet-snippets'
    
    Bundle 'Shougo/vimproc.vim'
    Bundle 'Shougo/vimshell.vim'
    " Bundle 'Shougo/neocomplcache-snippets-complete'

    " Bundle 'vim-scripts/UltiSnips'
    " Bundle 'kien/ctrlp.vim'

    Bundle 'vim-scripts/sudo.vim'
     
    
    Bundle 'tpope/vim-fugitive'
    Bundle 'tpope/vim-dispatch'

    " Bundle 'mattn/zencoding.vim'  " moved to emmet.vim
    Bundle 'mattn/emmet-vim'

    " Bundle 'lilydjwg/csspretty.vim'
    Bundle 'kchmck/vim-coffee-script'
    Bundle 'maksimr/vim-jsbeautify'
    " less(compact css) syntax
    Bundle 'groenewege/vim-less'
    Bundle 'mako.vim'
    Bundle 'BBCode--Dahn'
    Bundle 'haesken/pentadactyl.vim'
    
    " Android dev
    Bundle 'bpowell/vim-android'
    Bundle 'javacomplete'

    " Bundle 'pydoc.vim'
    " Bundle 'vim-scripts/Efficient-python-folding'
    " Bundle 'ode79/pythonfolding'
    " Bundle 'sontek/rope-vim'

    Bundle 'mattn/calendar-vim'
    Bundle 'mattn/gist-vim'
    Bundle 'mattn/webapi-vim'
    Bundle 'vim-scripts/fcitx.vim'
    " tabbar
    " Bundle 'dbext.vim'

    Bundle 'tomtom/tcomment_vim'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-repeat'
    Bundle 'tpope/vim-abolish'
    Bundle 'matchit.zip'
    Bundle "godlygeek/tabular"
    Bundle 'jmcantrell/vim-virtualenv'

    " Bundle 'vimwiki'
    Bundle 'xolox/vim-misc'
    Bundle 'xolox/vim-session'
    " Bundle "tpope/vim-obsession"

    " deploy
    Bundle 'Puppet-Syntax-Highlighting'

    " trans

    " Bundle 'sjbach/lusty'
    Bundle 'mbbill/VimExplorer'
    
    " oh-my
    Bundle 'Rykka/colorv.vim'
    Bundle 'Rykka/galaxy.vim'
    Bundle 'Rykka/easydigraph.vim'
    Bundle 'Rykka/lastbuf.vim'
    Bundle 'Rykka/jass.vim'
    Bundle 'Rykka/mathematic.vim'
    Bundle 'Rykka/zendjango.vim'
    Bundle 'Rykka/trans.vim'
    Bundle 'Rykka/riv.vim'

    Bundle 'Rykka/localbundle.vim'
    if isdirectory(expand('~/.vim/bundle/localbundle.vim'))
        call localbundle#init()
    endif

    filetype plugin indent on     " required!
endif "}}}
" 1.1.Basic "{{{2
if !exists("g:vimrc_init")
    let g:vimrc_init=1
endif
set history=255 viminfo='100,\"30,:30,s10,!
set autoread noautowrite

set backup backupdir=~/.vim_backups/
call s:auto_mkdir(expand('~/.vim_backups'),1)

set noswapfile directory=~/.vim_swaps/
call s:auto_mkdir(expand('~/.vim_swaps'),1)

set browsedir=buffer
set hidden bufhidden=hide switchbuf=useopen

set shortmess+=As           " no swap exists 'ATTENTION'
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set report=0                " : commands always print changed line count.

set expandtab tabstop=4  smarttab
set softtabstop=4 shiftwidth=4
set shiftround              " rounds indent to a multiple of shiftwidth
set autoindent copyindent   " copy the previous indentation on autoindenting


set nopaste pastetoggle=<F2>

set completeopt=menuone
set pumheight=10            " Keep a small completion window

set isfname-==
" set iskeyword+=$,@ 
" set iskeyword-=#
set comments=n://,fb:-,n:>,fb:*
set formatlistpat="^\s*[(\d)*#-]\+[\]:.)}\t ]\s*"
set formatoptions+=1on2mMq
" set formatoptions-=r      " Do not automatically insert a comment
" set formatoptions-=t      " Do no auto-wrap text using textwidth

set cscopetag               " When using :tag, <C-]>, or "vim -t", try cscope:
set cscopetagorder=0        " try ":cscope find g foo" and then ":tselect foo"

if has("unix") | set shell=sh | endif

set cryptmethod = "blowfish"
" if has("unix") "{{{
"     if has('unnamedplus')
"         set clipboard=unnamedplus,autoselect,exclude:cons\|linux
"     else
"         set clipboard=unnamed,autoselect,exclude:cons\|linux
"     endif
" else
"     if has('unnamedplus')
"         set clipboard=unnamedplus
"     else
"         set clipboard=unnamed
"     endif
" endif "}}}
" 1.2.Multi_Byte "{{{2
if has("multi_byte")
    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
    set encoding=utf-8
    set termencoding=utf-8
    set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,latin-1
endif
" 1.3.UI fonts colors "{{{2
" Guifont
if has("gui_running") "{{{
    if s:os == "windows"
        " both should install first.
        set guifont=Consolas:h12:cANSI
        " set gfw=Wenquanyi_Micro_Hei_Mono:h12:cCHINESEBIG5
        " set gfw=Yahei_Consolas_Hybrid:h14
    elseif s:os == "mac"
        set guifont=Monaco:h14
    elseif s:os == "ubuntu"
        set guifont=Wenquanyi\ Micro\ Hei\ Mono\ 12
        " set guifont=Dejavu\ Sans\ Mono\ 14,WenQuanYi\ Micro\ Hei\ 14
        set gfw=Wenquanyi\ Micro\ Hei\ Mono\ 12,WenQuanYi\ Zen\ Hei\ 12
    elseif s:os == "archlinux"
        " underscore is not showing with dejavu 14,
        " so use monaco, should install first.
        set guifont=Monaco\ 13,Wenquanyi\ Micro\ Hei\ Mono\ 13
        set gfw=Wenquanyi\ Micro\ Hei\ Mono\ 13,WenQuanYi\ Zen\ Hei\ 13
    else
        set guifont=Dejavu\ Sans\ Mono\ 14,WenQuanYi\ Micro\ Hei\ 14
        set gfw=Wenquanyi\ Micro\ Hei\ Mono\ 14,WenQuanYi\ Zen\ Hei\ 14
    endif
endif "}}}
" colorscheme
let s:rc.galaxy_path = globpath(&rtp, 'colors/galaxy.vim')
if s:rc.galaxy_path != ''
    let $colorscheme_n="galaxy"
else
    let $colorscheme_n="desert"
endif
colorscheme $colorscheme_n
" menu
if s:os == "windows"
    source $VIMRUNTIME/delmenu.vim
    set langmenu=zh_CN.utf-8
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
endif
set winaltkeys=no                       " no ALT key for menus
let did_install_default_menus = 1       " no default menus
let did_install_syntax_menu = 1         " no syntax menus
" tabline
set showtabline=1 tabpagemax=15
" statusline
set ruler "column and line number even no status line
set rulerformat=%15(%c%V\ %p%%%)
set laststatus=2

" cmdline
set cmdheight=1 showcmd showmode
if has('wildmenu')
    set wildchar=<Tab> wildmenu wildmode=full
    set wildignore=*.o,*.obj,*.bak,*.exe,*.swp
    set cpoptions-=<  "compatible-options"
    set wildcharm=<C-Z> "wildchar inside macro"
endif
" misc
set noshowmatch               " show matchpairs

set mouse=a                 " Enable terminal mouse in all mode
set mousehide  " rightmouse in extend mode work wrong
   
set nolazyredraw
set visualbell t_vb=
" 1.4.vim version"{{{2
if v:version >= 703 "{{{
    " let &colorcolumn=s:win_col-1
    
    call s:auto_mkdir(expand('~/.vim_undo'),1)
    set undofile undodir=~/.vim_undo/   " persistent undo

    set conceallevel=0                
    set concealcursor=              " n Normal v Visual i Insert c Command
endif "}}} 
" 
" 2.Commands {{{1 
" 2.1.Autocmds {{{2
aug au_GuiEnter "{{{
    au!
    au GuiEnter * set t_vb=
    " awesome don't need this
    " exe "au GuiEnter * winpos ".s:win_pos." 0"
    " exe "au GuiEnter * set columns=".s:win_col." lines=".s:win_row
aug END "}}}
aug au_VimEnter " {{{
    au!
    " if !has("gui_running")
    "     au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
    "     au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
    "     au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
    " endif
aug END
"}}}
aug au_Vimrc "{{{
    au!
    au SourcePre ~/Dropbox/dotfiles/.vimrc redraw | echohl WarningMsg
                \|echom "Reloading .vimrc"|echohl Normal
    au BufWritePre,FileWritePre ~/Dropbox/dotfiles/.vimrc  LastUpdate
    au BufWritePost,FileWritePost ~/Dropbox/dotfiles/.vimrc redraw
                \|echohl WarningMsg
                \|echom "Writing .vimrc"|echohl Normal
                \|so $MYVIMRC|normal '.zv
    " load vimrc after load any session.
    au SessionLoadPost * so ~/.vimrc
    " avoid using function while redefine it.
    au BufRead */.vimrc map <buffer> <F5> :silent so %<CR>
aug END "}}}
aug au_Buffer "{{{
    au! 
    au BufEnter,BufNew,BufReadPost * silent! lcd %:p:h:gs/ /\\ /
    " to the line when file last opened
    au BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe  "normal! g`\"" | endif
aug END "}}} 
" 2.2.Commands "{{{2
if has("unix")
    command! -nargs=0 Write w sudo:%
else
    command! -nargs=0 Write w
endif
command! -nargs=0 AutoMkdir call <SID>auto_mkdir(expand('%:p:h'),1) | w
command! -nargs=1 EditTemp   exe "sp /tmp/vim_".localtime().".".<q-args>


function! s:delete(name) "{{{
    let f = a:name
    if input('Delete '.f.' ?(y/N)') =~? '^y\%[es]$'
        if !delete(f)
            echom f."deleted successfully!"
            Explore
        else
            echom f."delete faiure!"
        endif
    endif
endfunction "}}}
function! s:rename(name) "{{{
    let f = expand('%:p')
    exec "saveas ".a:name
    call s:delete(f)
    exec "edit ".a:name
endfunction "}}}
command! -nargs=0 Delete call <SID>delete(expand("%:p"))
command! -nargs=1 Rename call <SID>rename(<q-args>)

fun! s:glob_edit(...) "{{{
    let ext = 'vim'
    let path = expand('%:p:h')
    let depth = "/**/*"
    if a:0 && a:1!=""
        let ext = a:1
        if a:0 > 1
           let path = expand(a:2)
        endif
        if a:0 > 2 && a:3 < 1
           let depth = "/*"
        endif
    endif
    let files= split(glob( path.depth.".".ext,1),"\n")
    " echom string([ext,path,depth])
    " echom string(files)
    for file in files
        exe "top sp " file
    endfor
endfun "}}}
com! -nargs=*  GlobEdit call s:glob_edit(<f-args>)

command! CopyName let @+ = expand('%:p:t')
command! CopyPath let @+ = expand('%:p:h')
command! CopyFull let @+ = expand('%:p')|echo 'PATH:'.@+

command! SubFullWhite %s/　/  /g
" We can use retab
command! SubFullTab %s/	/    /g
command! TrimWhite %s/[[:space:] ]\+$//

command! TrimCtrlM %s//\r/
command! TrimCtrl0 %s/ //g
command! TrimDoubleLine %s/\n\n\n/\r/
command! TrimWhiteLine %s/\n\n/\r/

command! Ch7 !chmod 755 '%:p'
command! Ch6 !chmod 644 '%:p'

function! s:last_update() "{{{
    let rx_str_upd='\%(Change\|Update\|Updated\|Modified\|Revision\)'
    for i in range(1,20)
        let line = getline(i)
        if line =~# rx_str_upd
            let nline = substitute(line, '\(^.*'.rx_str_upd.':\s*\).*$',
                        \ '\1'.strftime("%Y-%m-%d"), '')
            if line != nline
                call setline(i, nline)
            endif
            return
        endif
    endfor
endfunction "}}}
command! -nargs=0 -bar LastUpdate call <SID>last_update()
function! s:Ack(args) "{{{
    let grepprg_bak=&grepprg
    if s:os=="ubuntu"
        set grepprg=ack-grep\ -H\ --nocolor
    else
        set grepprg=ack\ -H\ --nocolor
    endif
    silent! execute "grep! " . a:args
    let &grepprg=grepprg_bak
    botright copen
    redraw!
endfunction "}}}
command! -nargs=* -complete=file Ack call <SID>Ack(<q-args>)

" Compiles
com! GccGtk !gcc `pkg-config --cflags --libs gtk+-2.0` -o %:t:r %
com! Grr !./%:t:r


" com Man
if !exists("g:man_loaded")
    let g:man_loaded=1
    runtime ftplugin/man.vim
    com! -nargs=* -complete=shellcmd M Man <args>
endif

" 2.3.Insert Abbrevation "{{{2 
iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.
" 2.5 keymap "{{{2
map <leader>kd :sp /usr/share/vim/vim73/keymap/<CR>
map <leader>kvm :sp ~/.vim/bundle/mathematic.vim/keymap/mathematic.vim<CR>
map <leader>km :set keymap=mathematic<CR>
map <leader>kn :set keymap=<CR>
function! s:convert() "{{{
    " assume the item always the last one. and sep by \s
    let lnum = line('.')
    let l_list = split(getline(lnum))
    let hex = printf("%x",char2nr(l_list[-1]))
    let x = nr2char("0x".hex)
    call setline(lnum, printf(l_list[0]."     <char-0x%05X>   \" %s ", "0x".hex , x))
endfunction "}}}
com! FmtConv  call s:convert()
function! s:fmtappend(hex,...) "{{{
    let line = a:0 && a:1==0 ? line('.') : line('$')
    " sil exe "normal! :let x = '\<c-v>U".a:hex."'\<cr>"
    let x = nr2char("0x".a:hex)
    call append(line,printf("\\\\%X              <char-0x%05X>   \" %s ", "0x".a:hex, "0x".a:hex , x))
endfunction "}}}
com! -nargs=* FmtLine  call s:fmtappend(<f-args>)
function! s:fmtrange(hex1,hex2,...) "{{{
    if a:0
        for hex in range("0x".a:hex1,"0x".a:hex2)
            call s:fmtappend(printf("%X",hex),a:1)
            normal! j
        endfor
    else
        for hex in range("0x".a:hex1,"0x".a:hex2)
            call s:fmtappend(printf("%X",hex))
        endfor
    endif
endfunction "}}}
com! -nargs=* FmtRange call <SID>fmtrange(<f-args>)

com! -nargs=* -complete=file E edit! <args>
com! -nargs=* -complete=help H help <args>

" 3.Mappings "{{{1
" 3.1.Leader_Mapping "{{{2
" Single Key "{{{
nno   <leader>   <Nop>
vno   <leader>   <Nop>
nno   s          <Nop>
nno   S          <Nop>
nno   Q          <Nop>
" similar with D
nno   Y          y$
nno   >          >>
nno   <          <<
vno   >          >gv
vno   <          <gv
" last changed position '.  `.
" last inserted position '^ `^
nno   `,         `^
nno   ',         '^

" repeat on every line
vno   .          :normal .<CR>
nor <rightmouse><leftmouse> <c-o>
nor <rightmouse><rightmouse> <c-o>
nor <rightrelease><leftrelease> <c-o>
ino <rightrelease><leftrelease> <c-o><c-o>

map <silent> <2-leftmouse> :call <SID>dbl_click()<CR>

fun! s:dbl_click() "{{{
    if foldclosed('.') != -1
        exe "normal! zv"
    else
        if &fdm == 'marker' 
            let row = line('.')
            let marker_start=split(&foldmarker,',')[0]
            if getline('.') =~ marker_start
                exe "normal! zc"
                return
            endif
        endif
        exe "normal! \<2-LeftMouse>"
    endif
endfun "}}}

"}}}
" Dotfiles "{{{
map <leader>vr  :so $MYVIMRC<CR>
map <leader>vp  :Sp\|e ~/.pentadactylrc<CR>
map <leader>vsp :Sp\|e ~/Dropbox/Vimwiki/Ref/ShuangPin.vwk<CR>
map <leader>vv  :Sp\|e ~/Dropbox/dotfiles/.vimrc<CR>
map <leader>vm  :Sp\|e ~/.muttrc<CR>
if has("unix")
    map <silent><leader>va :Sp\|e ~/.config/awesome/rc.lua<CR>
    map <silent><leader>vb :Sp\|e ~/.bashrc<CR>
    map <silent><leader>vt :Sp\|e ~/.tmux.conf<CR>
    map <silent><leader>vz :Sp\|e ~/.zshrc<CR>
    map <silent><leader>vz :Sp\|e ~/.zshrc<CR>
    map <silent><leader>vx :Sp\|e ~/.Xdefaults<CR>
endif "}}}
" Toggle Diff "{{{
fun! s:tog_opt(opt,val) "{{{
    if type(a:val) == type(0)
        let null = 0
    else
        let null = "\x00"
    endif
    if eval("&".a:opt."=='".a:val."'")
        exe "let &".a:opt."  = '".null."'"
        echo "NO" a:opt
    else
        exe "let &".a:opt."  = '".a:val."'"
        echo a:opt a:val
    endif
endfun "}}}
nma <silent><leader>db :call <SID>tog_opt("debug","msg")<CR>
set diffopt=filler,vertical,foldcolumn:1,iwhite,context:4
" nma <leader>dO :!git diff -c -cc # % > ~/Desktop/tmp.diff<cr>:sp ~/Desktop/tmp.diff<CR>
com! -nargs=1 DiffBuf exe '!diff -u #<args> % > /tmp/tmp.diff ' | Sp /tmp/tmp.diff
nma <leader>da :1,$+1diffget<cr>
nma <leader>d1 :1,.diffget<cr>
nma <leader>d$ :.,$+1diffget<cr>
nnor <leader>drr :diffget REMOTE<cr>]c
nnor <leader>dll :diffget LOCAL<cr>]c
map <silent> <leader>dd :call <SID>toggle_diff()<CR>
map <silent> <leader>do :call <SID>diff_this()<CR>
function! s:toggle_diff() "{{{
    if &diff
        diffoff
        let &foldmethod = exists("b:foldmethod") ? b:foldmethod : "marker"
        set foldenable foldcolumn=0
        echoh ModeMsg    | ec "diffmode Off" | echoh None
    else
        let b:foldmethod=&foldmethod
        diffthis
        set foldcolumn=0
        echoh WarningMsg | ec "diffmode On"  | echoh None
    endif
endfun "}}}
function! s:diff_this(...) "{{{
    if exists("a:1")
        exec "sp ".a:1
    endif
    let syn=&syntax
    call s:split()
    if !exists("a:2")
        enew | setl bt=nofile | r # | 0d_
        exec "set syn=".syn
        setl ro
    else
        exec "e ".a:2
    endif
    diffthis | wincmd p | diffthis
endfunction "}}}
"}}}
" Toggle Fold "{{{
set foldtext=MyFoldText()
set foldenable foldmethod=marker 
set foldcolumn=0
set foldlevel=0 foldlevelstart=1
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
set foldclose=
nno <silent> zf :set opfunc=MyFoldMarker<CR>g@
vno <silent> zf :<C-U>call MyFoldMarker(visualmode(), 1)<CR>zv
nno <silent> zz @=(&foldlevel?'zM':'zR')<CR>
nno <silent> <leader>zz @=(&foldlevel?'zM':'zR')<CR>
nno <silent> <leader><leader> @=(foldclosed('.')>0?'zv':'zc')<CR>
vno <silent> <leader><leader> <ESC>@=(foldclosed('.')>0?'zv':'zc')<CR>gv
nor <2-rightmouse> @=(foldclosed('.')>0?'zv':'zc')<CR>
vno <2-rightmouse> <ESC>@=(foldclosed('.')>0?'zv':'zc')<CR>gv
nor <silent> <leader>ff :setl fdm=<C-R>=&fdm=~'mar'?'indent'
            \:&fdm=~'ind'?'syntax'
            \:&fdm=~'syn'?'expr':'marker'<CR><BAR>ec &fdm<CR>
function! MyFoldText() "{{{
    let markers = split(&foldmarker, ",")
    let cmtmakrer = substitute(&commentstring, "%s", markers[0], "\x00")
    let sub = markers[0].'\d\=\|'.cmtmakrer.'\d\='
    let line = substitute(getline(v:foldstart), sub, '', 'g')
    let pre_white= matchstr(line,'^\s*')
    let m_line = winwidth(0)-10
    if len(line)<=m_line 
        let line = line."  ".repeat('-',m_line) 
    else
        " trim preceding whitespace to 50
        if len(pre_white)>=m_line
            let line = substitute(line,'^\s*',repeat(' ',m_line-10),'')
        endif
    endif
    let line = printf("%-".m_line.".".m_line."s",line)
    if v:foldlevel < 4
        let dash = printf("%4s",repeat("<",v:foldlevel))
    else
        let dash = " <<+"
    endif
    let num = printf("%4s",(v:foldend-v:foldstart))
    return line."[".num.dash."]"
    " return "+-" . v:folddashes.printf("%3d",(v:foldend-v:foldstart)).
    "     \ " lines: " . line
endfunction "}}}
function! MyFoldMarker(type, ...) "{{{
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    if a:0  " Invoked from Visual mode, use '< and '> marks.
        call s:set_fold_markers("'<", "'>")
    elseif a:type == 'line'
        call s:set_fold_markers("'[", "']")
    elseif a:type == 'block'
    endif

    let &selection = sel_save
    let @@ = reg_save
endfunction "}}}
function! s:set_fold_markers(lnum_st, lnum_end) "{{{
" let foldmarkers to be applied with space before a comment.
    let markers = split(&foldmarker, ",")

    function! s:set_line(ln, marker)
        let cmnt = substitute(&commentstring, "%s", a:marker, "\x00")
        let line = getline(a:ln)
        if line =~ '^\s*$'
            let space = ''
        else
            let space = ' '
        endif
        let line = substitute(line, '\s*$', space, '').cmnt
        call setline(a:ln, line)
    endfunction

    call s:set_line(a:lnum_st, markers[0])
    call s:set_line(a:lnum_end, markers[1])
endfunction "}}}
"}}}
" Toggle Option "{{{
set listchars=tab:\|-,trail:-,extends:>,precedes:<
nor <Leader>li :setl list! list?<CR>

set virtualedit=block
nor <Leader>ve :setl ve=<c-r>= &ve=='' ? 'block' : &ve=='block' ? 'all' : ''  <CR><CR>

nor <leader>nn :setl <c-r>=&nu?'rnu':&rnu?'nornu':'nu'<CR><CR>

let &showbreak='> '         " wrap text break string
set wrap linebreak
set display=lastline        " show wraping text even it's not complete show
nor <leader>wp :setl wrap! wrap?<CR>

set spelllang=en nospell
nor <leader>sp :setl spell! spell?<CR>

" syn spell toplevel

" aegimrLtT
" set go-=aeimrLT       " XXX: NO effect
set go=Agt
nor <m-1> :set go<C-R>=&go=~#'m' ? '-=m' : '+=m'<CR><CR>
nor <m-2> :set go<C-R>=&go=~#'r' ? '-=rL': '+=rL'<CR><CR>
nor <m-3> :set go<C-R>=&go=~#'T' ? '-=T' : '+=T'<CR><CR>

nma <leader>11 : filetype detect<CR>
nma <leader>12  :syn sync maxlines=200<CR>
nma <leader>1v  :call <SID>get_synfile("syntax")<CR>
nma <leader>1p  :call <SID>get_synfile("ftplugin")<CR>
nma <leader>1i  :call <SID>get_synfile("indent")<CR>
function! s:get_synfile(type) "{{{
    let files = split(globpath(&rtp,a:type."/".&syntax.".vim"),'\n')
    if !empty(files)
        for file in files
            exe "split ". file
        endfor
    endif
endfunction "}}}
nma <silent><leader>1s :call <SID>synstack()<CR>
function! s:synstack() "{{{
    if exists("*synstack")
        for id in synstack(line("."), col("."))
            echon " ".synIDattr(id, "name")
            exe "echoh ".synIDattr(id, "name")
            echon "[".synIDattr(synIDtrans(id), "name")."]"
            echoh None
        endfor
    endif
endfunc "}}}
" using expr to return a map , which can autoload plugin files
" map <expr><Space> <SID>fake_leader()
fun! s:fake_leader() "{{{
    " A fake leader to display the status of <Space>.
    " you should set your mapleader to a key other than '<Space>'
    " disadvantage: only recevie 2 key mapping
    "        e.g. <leader>vv but no <leader>v or <leader>vvv
    echohl WarningMsg | echo "F:<Space>" | echohl Normal
    let n1 = getchar()
    let c1 = nr2char(n1)
    let t=""
    if c1 == "\<Space>"
        echon "<Space>"
        let t = g:mapleader . g:mapleader
    elseif c1 == "\<Esc>"
        echon "<Escape>"
    elseif c1 == "\\"
        echon "<Bslash>"
        let t = g:mapleader . "\\"
    elseif n1 == "\<BS>"
        echon "<BS>"
    else
        echon c1
        let c2 = nr2char(getchar())
        let t = g:mapleader .c1.c2
    endif
    redraw | echo 
    return t 
endfun "}}}

"}}}
" 3.2.Switch Window "{{{2
set winheight=6 winwidth=5          " current window minimum width/height
set winminwidth=0 winminheight=0
set noequalalways splitbelow splitright
" nma <silent><C-W>1 :call <SID>max_resize_win()<CR>
" nma <silent><C-W>2 :call <SID>span_vert_win(0)<CR><C-W>=
" nma <silent><C-W>3 :call <SID>fold_vert_win(1)<CR>
" nma <silent><C-W>4 :call <SID>place_vim()<CR>

" nma <silent><C-W>1 :cal <SID>toggle_size('n')<CR>
nno <silent><C-W>1 :resize<cr>
" nma <silent><C-W>2 :cal <SID>toggle_size('v')<CR>
nno <silent><C-W>2 :vert resize<cr>
nno <silent><C-W>3 <C-W>=
nno <silent><C-W>o <C-W><c-o>
fun! s:toggle_size(type) "{{{
    if a:type == 'n'
        if exists("s:size_tg_n") && s:size_tg_n == 1
            let s:size_tg_n = 0
            exe "norm! \<C-W>="
        else
            let s:size_tg_n = 1
            resize
        endif
    elseif a:type == 'v'
        echo 2
        if exists("s:size_tg_v") && s:size_tg_v == 1
            let s:size_tg_v = 0
            exe "norm! \<C-W>="
        else
            let s:size_tg_v = 1
            vert resize
        endif
    endif
endfun "}}}

nno <C-W><c-u> :resize +5<CR>
nno <C-W><c-d> :resize -5<CR>
nno <C-W>n <C-W>w
nno <C-W>N <C-W>n

" onoremap <silent> F :<C-U>normal! 0f(hviw<CR>

" no <C-W>x :set opfunc=SwitchWin<CR>g@
" fun! SwitchWin(type)
"     echomsg @@ a:type
"     
" endfun

nma <silent><C-W><c-q> :close<bar>call <SID>fold_vert_win(0)<CR>
nma <silent><C-W>q     :close<bar>call <SID>fold_vert_win(0)<CR>

fun! s:edit_file(ask)
    let file = expand('<cfile>')
    let ptn ='\v(%(file|https=|ftp|gopher)://|%(mailto|news):)([0-9a-zA-Z#&?._-~/]*)'
    let links = matchlist(file,ptn)
    if !empty(links) 
        if links[1] =~ 'file'
            let file = links[2]
        else
            sil! exe "!firefox ". links[2]
        endif
        return
    endif
    let file = expand(file)
    if filereadable(file) || isdirectory(file)
        exe "edit ".file
        return
    elseif a:ask==1 && input("file: ".file." not exists, continue?(Y/n)") =~?"y"
        exe "edit ".file
        return
    endif
    
    " find the file match with <cfile>.ext 
    if file !~ '^\s*$'
        let files = split(glob(expand('%:p:h')."/".file.".*"),'\n')
        if !empty(files)
            exe "edit ".files[0]
            for f in files[1:]
                exe "split ".f
            endfor
            return
        endif
    endif
endfun 
nno <silent><C-W><C-V> :Sp\|call <SID>edit_file(0)<CR>
nno <silent><C-W><C-S> :sp\|call <SID>edit_file(0)<CR>
nno <silent><C-W><C-T> :tab sp\|call <SID>edit_file(0)<CR>
nno <silent><C-W><C-F> :Sp\|call <SID>edit_file(1)<CR>
nno <silent><C-W><C-O> :call <SID>diff_this()<CR>


map <C-Up>      :tabclose<CR>
map <S-Up>      :close<CR>
map <C-Down>    :tabnew<CR>
map <S-Down>    :new<CR>

map <C-Right>   :tabnext<CR>
map <S-Right>   :wincmd w<CR>
map <C-Left>    :tabprev<CR>
map <S-Left>    :wincmd p<CR>
function! s:is_win_vert() "{{{
    return winwidth(0) < &columns
endfunction "}}}
function! s:is_vim_span() "{{{
    return &columns >= s:win_col_span2
endfunction "}}}
function! s:max_resize_win() "{{{
    resize +15
    " if &lines != s:win_row
    "     let &lines=s:win_row
    " endif
    " if !s:is_vim_span() && s:is_win_vert()
    "     vertical resize
    " endif
endfunction "}}}
function! s:span_vert_win(force) "{{{
    if a:force || (s:is_win_vert() && !s:is_vim_span())
        if has("gui_running")
            " let &columns = s:win_col_span2
        endif
    endif
endfun "}}}
function! s:fold_vert_win(force) "{{{
    " if &lines != s:win_row
    "     let &lines=s:win_row
    " endif
    " if a:force || (!s:is_win_vert() && s:is_vim_span())
    "     if has("gui_running")
    "         let &columns = s:win_col
    "     endif
    "     exe "winpos ".s:win_pos." 0"
    " endif
endfun "}}}
function! s:place_vim() "{{{
    let s:win_pos = getwinposx()>=0 ? getwinposx() : s:win_pos
    if     s:win_pos <= 100 | let s:win_pos = 550
    elseif s:win_pos <= 600 | let s:win_pos = 1050
    else                    | let s:win_pos = 10
    endif
    " exe "winpos ".s:win_pos." 0"
endfunction "}}}
function! s:split() "{{{
"check win_span and filename to decide split direction
    if empty(expand('%'))
        return
    endif
    if winwidth(0) > 120
    "     if has("gui_running")
    "         " let &columns = s:win_col_span2
    "     endif
        vsplit
    else
        split
    endif
endfun
"}}}
command! -bar Split call <SID>split()
" 3.3.HJKL "{{{2
" hjkl "{{{
set scrolloff=1 scrolljump=1
nno   H   h
nno   L   l
nno   J   j
nno   K   k

nno   j   gj
nno   k   gk

" for insert
ino <m-j> <c-o>gj
ino <m-k> <c-o>gk
ino <m-h> <left>
ino <m-l> <right>
ino <m-s-h> <s-left>
ino <m-s-l> <s-right>
cno <m-h> <left>
cno <m-l> <right>
cno <m-s-h> <s-left>
cno <m-s-l> <s-right>
cno <C-C> <C-Y>

" xno: visual mode exclude select mode.
xno   j   gj
xno   k   gk

" nno   <silent>   <c-h>   K
nno   <silent>   <c-l>   :let @/=''\|redraw!<CR>
nno   <silent>   <c-j>   J
ino   <silent>   <c-j>   <c-k>
" ino   <silent>   <c-f>   <c-k>

" new line / join line
vno   <c-CR>   gq
nno   <c-CR>   kJ
ino   <c-CR>   <esc>kJi
vno <c-kEnter>   gq
nno <c-kEnter>   kJ
ino <c-kEnter>   <esc>kJi
nno   <m-CR>   o
ino   <m-CR>   <esc>o
nor   <s-CR>   o<ESC>
ino   <s-CR>   <esc>O

ino <m-o> <c-o>o
ino <m-O> <c-o>O

ino <m-c>  <esc>
"}}}
" 3.4.Editing "{{{2
" Wrap text "{{{
" TODO 
" VimwikiWord
nno <Leader>eW BvEc[[<C-r>"]]<ESC>`[
nno <Leader>ew bvec[[<C-r>"]]<ESC>`[
nno <Leader>el ^vg_c_*<C-r>"*_<ESC>`[
" if using surround.vim:  ysiw* and ysiw*l.
nno <Leader>e*w bvec*<C-r>"*<ESC>`[
nno <Leader>e**w bvec**<C-r>"**<ESC>`[

" php
nno <leader>ep ciw<?php <C-r>" ?><ESC>
vno <Leader>ep c<?php <C-r>" ?><ESC>`[
" html comment
nno <leader>e! ciw<!-- <C-r>" --><ESC>
vno <Leader>e! c<!-- <C-r>" --><ESC>`[
"}}}
" Todo text "{{{
nno <leader>et :call <SID>insert_t(" TODO:")<CR>
nno <leader>ef :call <SID>insert_t("FIXME:")<CR>
nno <leader>en :call <SID>insert_t(" NOTE:")<CR>
nno <leader>ee :call <SID>toggle_with_T()<CR>
" TODO:
"FIXED: 2012-04-24
" NOTE:
let s:rx_toggle = [['TODO',   'DONE'],
                \ ['FIXME',   'XXX',  'WKRND', 'WNTFX', 'FIXED'],
                \ ['NOTE',    'WARNING'],
                \ ]
let s:rx_timestamp = '\(\d\{6}\|\d\{4}-\d\{2}-\d\{2}\)'
let s:fm_timestamp = "%Y-%m-%d"
function! s:insert_t(text) "{{{
    if &syn=="vimwiki"
        let cmnt = a:text
    else
        let cmnt = substitute(&commentstring, '%s', a:text, "\x00")
    endif
    if getline('.')=~'^\s*$'
        exec 'normal! I' . cmnt
    else
        let fo=&fo
        set fo=2
        exec 'normal! o' . cmnt
        let &fo=fo
    endif
endfunction "}}}
function! s:toggle_with_T() "{{{
    let line = getline('.')
    for rx_list in s:rx_toggle
        for i in range(len(rx_list))
            let rx_lst = rx_list[i].':\='
            if line =~# rx_lst "{{{
                let r = i+1
                if i == len(rx_list)-1
                    let r = 0
                    " remove all timestamp when idx is list[0]
                    if line =~# rx_lst.' '.s:rx_timestamp
                        let line = substitute(line,' '.s:rx_timestamp,'','')
                    endif
                elseif i == len(rx_list)-2
                    let time = strftime(s:fm_timestamp)
                    " add timestamp when idx is list[-1]
                    if line =~# rx_lst.' '.s:rx_timestamp
                        let line = substitute(line,s:rx_timestamp, time,'')
                    else
                        let line = substitute(line,'\C'.rx_lst, '& '.time,'')
                    endif
                endif
                let rx_list[r]=printf("%".len(rx_list[i])."s", rx_list[r])
                let line = substitute(line,'\C'.rx_list[i],rx_list[r],'')
                break
                break
            endif "}}}
        endfor
    endfor
    if line !=# getline('.')
        call setline('.',line)
    endif
endfunction "}}}
"}}}
" Line format "{{{
nmap gUu :s/\v<(.)(\w*)/\u\1\L\2/g\|nohl<CR>
nmap gcw guiw~w


let s:chara="abcdefghijklmnopqrstuvwxyz"
" TODO: merge mode with fmt
" mode :
"   '-': left aligned
"   '03': padded with 3 '0'
"   '_3': padded with 3 ' '
"   '0': padded with filling '0' in visual mode
"   'd': from 1-n 'z': from:0-n  'a':a-z  'x':0-f
"   '_': with additional ' '
"   e.g: '-03d_':  
"   001 fejfoiej          
"   002 fejofiwji
"   003 fjeiofjwoe
"   ...
"   1001 fejofijweiofjiwe
" XXX: should we auto detect mode in viusal? with it's range and col_range

function! s:sequence(num,mode,fmt) "{{{
    if a:mode == "0"
        return map(range(a:num),'printf("%'.a:fmt.'d",v:val)')
    elseif a:mode ==  "1"
        return map(range(1,a:num),'printf("%'.a:fmt.'d",v:val)')
    elseif a:mode =~? "x"
        return map(range(a:num),'printf("%'.a:fmt.a:mode.'",v:val)')
    elseif a:mode =~# "a"
        " a-z  recursively
        return map(range(a:num),'printf("%'.a:fmt.'s",s:chara[( v:val % 26 )])')
    elseif a:mode =~# "A"
        " A-Z  recursively
        return map(range(a:num),'printf("%'.a:fmt.'s",toupper(s:chara[( v:val % 26 )]))')
    endif
endfunction "}}}
function! s:insert_seq(num,mode,fmt,row_s,row_e,col_s,col_e) "{{{
    let ilist = s:sequence(a:num,a:mode,a:fmt)
    let cnum = abs(a:col_e - a:col_s + 1)
    let i = 0
    for lnum in range(a:row_s,a:row_e)
        let line = getline(lnum)
        let ws = a:col_e-len(line)
        if ws <= 0
            let line = substitute(line, '\%>'.(a:col_s-1).'c.\{'.cnum.'}',
                        \ ilist[i] , '')
        else
            let line .= repeat(" ",ws)
            let line = substitute(line, '\%>'.(a:col_s-1).'c.\{'.cnum.'}',
                        \ ilist[i] , '')
        endif
        call setline(lnum,line)
        let i += 1
    endfor
endfunction "}}}
function! s:insert_seqn(mode,fmt,num,clen) "{{{
    call s:insert_seq(a:num,a:mode,a:fmt,
                \line("."),(line(".")+a:num-1),col("."),(col(".")+a:clen-1))
endfunction "}}}
function! s:insert_seqv(mode,fmt,first,last) "{{{
    call s:insert_seq((a:last-a:first+1),a:mode,a:fmt,
                \a:first,a:last,col("'<"),col("'>"))
endfunction "}}}
function! s:insert_s(mode,fmt,n1,n2,...) "{{{
    if a:0 == 2 && a:1==a:2
        " means have useless <line1> and <line2>
        call s:insert_seqn(a:mode,a:fmt,a:n1,a:n2)
    else
        call s:insert_seqv(a:mode,a:fmt,a:n1,a:n2)
    endif
endfunction "}}}
com! -nargs=* -range InsertSeq  call s:insert_s(<f-args>,<line1>,<line2>)

nno <leader>e=2 yyPVr=jyypVr=
nno <leader>e## yypVr#
nno <leader>e== yypVr=
nno <leader>e-- yypVr-
nno <leader>e*2 yyPVr*jyypVr*
"}}}
" Pairs "{{{
vno [p <esc>`>a]<esc>`<i[<esc>lv`>l
vno {{ <esc>`>a}<esc>`<i{<esc>lv`>l
vno (( <esc>`>a)<esc>`<i(<esc>lv`>l
vno "" <esc>`>a"<esc>`<i"<esc>lv`>l
vno '' <esc>`>a'<esc>`<i'<esc>lv`>l
vno ** <esc>`>a*<esc>`<i*<esc>lv`>l
vno __ <esc>`>a_<esc>`<i_<esc>lv`>l

let pair_list = [
            \['{','}'], ['[',']'], ['(',')'], ['<','>'],
            \['"','"'], ["'","'"],
            \['｛','｝'], ['［','］'], ['（','）'], ['＜','＞'],
            \['＂','＂'], ["＇","＇"],["`","`"]
            \]
for [s,e] in pair_list
    " input style 1 : 
    exec 'ino '.s.  ' '.s
    exec 'ino '.s.s.' '.s.e.'<left>'
    exec 'cno '.s.s.' '.s.e.'<left>'
    exec 'cno '.s.  ' '.s

    " " input style 2 : 
    " " easier to inpu a single s , but often mistake for two quote
    " exec 'ino '.s.' '.s.e.'<left>'
    " exec 'ino '.s.'<esc> '.s
    " exec 'ino '.s.s.' '.s
    " exec 'cno '.s.' '.s.e.'<left>'
    " exec 'cno '.s.s.' '.s
    " exec 'cno '.s.'<esc> '.s
    
    exec 'ino '.e.'<c-a> '.e.'<esc>m`^i'.s.'<esc>``a'
    exec 'ino '.e.'<c-b> '.e.'<esc>m`bi'.s.'<esc>``a'
    exec 'cno '.e.'<c-a> '.e.'<home>'.s
    exec 'cno '.e.'<c-b> '.e.'<s-left>'.s
    exec 'ino '.s.'<c-e> '.s.'<esc>m`$a'.e.'<esc>``a'
    exec 'ino '.s.'<c-w> '.s.'<esc>m`ea'.e.'<esc>``a'
    exec 'cno '.s.'<c-e> '.s.'<end>'.e
    exec 'cno '.s.'<c-w> '.s.'<s-right>'.e
    if s != e
        exec "ino ".s.e." ".s.e
    endif
    unlet s
    unlet e
endfor
ino {<CR>  {<CR>}<Esc>O<tab>
ino {<c-e> {<c-o>mz<end><cr>}<c-o>`z<cr><tab>
"}}}
" Wheel indent: X11 only "{{{

map   <ScrollWheelUp>       3k
map   <ScrollWheelDown>     3j
map   <S-ScrollWheelUp>     <c-b>
map   <S-ScrollWheelDown>   <c-f>
nno   <C-ScrollWheelDown>   >>
nno   <C-ScrollWheelUp>     <<
vno   <C-ScrollWheelDown>   >gv
vno   <C-ScrollWheelUp>     <gv
"}}}
" 3.5.MsWin "{{{2
source $VIMRUNTIME/mswin.vim
behave xterm
set mousemodel=popup " rightmouse in extend mode work wrong
" set mousemodel=extend " rightmouse in extend mode work wrong
"open fold while undo /redo
nor <C-Z>       uzv
ino <C-Z>       <C-O>u<C-O>zv
vno <C-Z>       <Nop>

nor <C-Y>       <C-R>zv
ino <C-Y>       <C-O><C-R><C-O>zv
vno <C-Y>       <Nop>

" Filter "+gP
nor <C-V>	    "+gp
nor <S-Insert>	"+gp
vno <C-V>	    c<C-O>"+gP<Esc>

" CTRL-A in n/v/o: Select all in VISUAL-MODE
nor <C-A> ggVG
" ono <c-a> ^
" remap <c-a> to <m-x>
nor <m-x> <c-a>

" terminal style
ino <c-a> <c-o>^
cno <c-a> <c-b>
ino <c-e><c-e> <esc>A
ino <c-left> <c-o>B
ino <c-b> <c-o>^

" noremap <C-S-Tab> <C-W>p

nno <C-Tab> gt
nno <C-S-Tab> gT
nno <S-Tab> gT

" 3.6.Search "{{{2
set hlsearch incsearch
set ignorecase smartcase
set nowrapscan
nno   #    g* | nno   g#   *
nno   *    g# | nno   g*   #
vno   /    <ESC>/<C-\>e<SID>p(<SID>r(),"e")<CR>
vno   ?    <ESC>?<C-\>e<SID>p(<SID>r(),"e")<CR>
vno   #    <ESC>/<C-\>e<SID>p(<SID>r(),"e")<CR><CR><C-G>
vno   *    <ESC>?<C-\>e<SID>p(<SID>r(),"e")<CR><CR><C-G>
vno   n    <ESC>/<C-\>e<SID>p(<SID>r(),"e")<CR><CR><C-G>
vno   N    <ESC>?<C-\>e<SID>p(<SID>r(),"e")<CR><CR><C-G>
function! s:p(p,mode) "{{{
    if a:mode =~ "s"
        let re_txt =  ''
    elseif a:mode =~ "e"
        let re_txt =  '*[]/~.$\'
    elseif a:mode =~ "r"
        let re_txt =  '&'
    endif
    return escape(a:p,re_txt)
endfunction "}}}
function! s:r() "{{{
    normal gv"yy
    let w = @y
    return w
endfunction "}}}
function! s:w(s,mode) "{{{
    let rs = a:s
    if a:mode =~ "b"
        let ss = "\\<".s:p(a:s,"s")."\\>"
    else
        let ss = s:p(a:s,"s")
    endif
    return 's/'.ss."/".s:p(rs,"r")."/gc"
endfunction "}}}

nno <silent> n :call <SID>wrapscan_warn('f')<CR>
nno <silent> N :call <SID>wrapscan_warn('b')<CR>
function! s:wrapscan_warn(d) "{{{
    " show an warning message when hit end of file.
    try
        if (a:d=='f' && v:searchforward == 1)
            \ || (a:d=='b' && v:searchforward == 0)
            //
        else
            ??
        endif
    catch /^Vim\%((\a\+)\)\=:E38[45]/
        echohl Comment
        echon ' Searching of '
        echohl Warningmsg
        if v:searchforward ==1
            echon @/[:15]
            echohl Comment
            echon ' hit END-Of-File.'
        else
            echon @/[:15]
            echohl Comment
            echon ' hit TOP-Of-File.'
        endif
        let c = nr2char(getchar(1))
        if  v:searchforward == 0
            call search(@/,'wb')
            echon ' Wrapscan to END'
        elseif v:searchforward == 1
            call search(@/,'w')
            echon ' Wrap to TOP'
        endif
        echohl Normal
    endtry
endfunction "}}}

" let g:UltiSnipsExpandTrigger="<C-l>f"
" let g:UltiSnipsListSnippets="<C-l>l"
" let g:UltiSnipsJumpForwardTrigger="<C-l>j"
" let g:UltiSnipsJumpBackwardTrigger="<C-l>k"
" 3.7.F1-F12 "{{{2
"{{{3 F1 Help
set keywordprg=":help"
set helplang=en
nor   <F1>     K
nno   <S-F1>   :Pydoc <C-R><C-F><CR>
"{{{3 F2 Replace reg/
nno   <F2>     :%<C-R>=<SID>w(@/,"\x00")<CR><Left><Left><Left>
vno   <F2>     :<C-R>=<SID>w(@/,"\x00")<CR><Left><Left><Left>
nno   <S-F2>   :%<C-R>=<SID>w(expand('<cword>'),"b")<CR><Left><Left><Left>
vno   <S-F2>   :<C-R>=<SID>w(expand('<cword>'),"b")<CR><Left><Left><Left>
"{{{3 F3 Ack-grep http://better-than-grep.com
nor   <F3>     :Ack <C-R><C-F> %<CR>
vno   <F3>     y:Ack <C-R>" %<CR>
nor   <S-F3>   :Ack <C-R><C-F><CR>
vno   <S-F3>   y:Ack <C-R>"<CR>
"{{{3 F4 Folder
nno <silent>  <F4>     :call <SID>toggle_nerdfind()<CR>
nno <silent>  <C-F4>     :RestartVim<CR>
function! s:toggle_nerdfind() "{{{
    if exists("t:nerdwin") && t:nerdwin==1
        NERDTreeClose
        let t:nerdwin=0
    else
        NERDTreeFind
        let t:nerdwin=1
    endif
endfunction "}}}
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
nno   <S-F4>   :Exp<CR>
"{{{3 F5 Execute
nno <silent> <F5> :call <SID>exe("n")<CR>
vno <silent> <F5> :call <SID>exe("v")<CR>
" if !exists("*s:exe")
function! s:exe(mode) "{{{
    update
    let bang="!"
    if has("unix")
        let browser = "firefox "
        let runner="xdg-open "
        let err_log=" 2>&1 | tee /tmp/.vim_exe.tmp"
        let term = "gnome-terminal "
    else
        let browser ="firefox.lnk "
        let runner="start "
        let err_log=" "
        let term = "cmd "
    endif

    if !exists("&syn")
        exec bang.runner.file
        return
    else
        let syn=&syn
    endif

    if a:mode=="n"
        let file=' "'.expand('%:p').'"'
        if    syn=="python"
            let    L=getline(1)
            if     L=~'python3' | exec "!python3 -d ".file.err_log
            elsei  L=~'pyfile'  
                if has("python")
                    pyfile %
                else
                    exec "!python -d ".file.err_log
                endif
            elsei  L=~'pypy'    | exec "!pypy -d ".file.err_log
            else                | exec "!python -d ".file.err_log
            endif
        elsei syn=="ruby"
            if has("ruby")
                rubyfile %:p
            else
                exec "!ruby ".file.err_log
            endif
        elsei syn=="perl"       | exec "!perl -D ".file.err_log
        elsei syn=="lua"        | exec "luafile %"
        elsei syn=='vim'        | exec "so %"
        elsei syn=~'html'       | exec bang.browser.file
        elsei syn=='rst'        | Riv2HtmlAndBrowse
        elsei syn=~'^coffee$'   | exec "CoffeeRun"
        elsei syn=="vimwiki"    | exec "Vimwiki2HTMLBrowse"
        elsei syn=='bat'        | exec "w !cmd"
        elsei syn=='go'         | exec "!go run %"
        elsei syn=='make'       | make
        elsei syn=='haskell'    | exec "!ghc %" | exec "!./%:t:r"
        elsei syn=='cpp' || syn=='c' | call s:gcp()  | exec "!./%:t:r"
        elsei syn=~'^\(sh\|expect\|bash\)$'     | exec "w !sh"
        else                    | exec bang.runner.file
        endif
    elseif a:mode=="v"
        if     syn=="python"    | exec "py ".getline('.')
        elseif syn=="ruby"      | exec "ruby ".getline('.')
        elseif syn=="lua"       | exec "lua".getline('.')
        elseif syn=='vim'       | exec getline('.')
        elseif syn=~'^\(sh\|expect\|bash\)$'    | exec ".w !sh"
        endif
    endif
endfunction "}}}
" endif
fun! s:rst() "{{{
    let bang="!"
    if has("unix")
        let browser = "firefox "
        let runner="xdg-open "
        let err_log=" 2>&1 | tee /tmp/.vim_exe.tmp"
        let term = "gnome-terminal "
    else
        let browser ="firefox.lnk "
        let runner="start "
        let err_log=" "
        let term = "cmd "
    endif
    " NOTE:
    " we should generate the css of external code by
    " pygmentize -f html -S colorful -a .syntax



    " and use it by
    " rst2html.py --stylesheet=html4css1.css,transition-stars.css

    " sil !rst2html.py % > /tmp/_rst.html
    " !rst2html.py
       " \ --stylesheet=/home/meoki/.vim/scripts/pygments-default.css % > /tmp/_rst.html
    " !python2 ~/.vim/scripts/pygments_code_block_directive.py
    "    \ --stylesheet=/home/meoki/.vim/scripts/pygments-default.css % > /tmp/_rst.html

    " !python2 ~/.vim/scripts/rst2html-pygments 
    "    \ --stylesheet=/home/meoki/.vim/scripts/pygments-default.css % > /tmp/_rst.html
    " !rst2html.py
    "     \ --stylesheet=/home/meoki/.vim/scripts/pygments-default.css % > /tmp/_rst.html

    " !python2 ~/.vim/scripts/rst-directive.py
    "    \ --stylesheet=/home/meoki/.vim/scripts/pygments-default.css % > /tmp/_rst.html
    let style = expand('~/.vim/scripts/css/trac.css')
    let style .= ",".expand('~/.vim/scripts/css/html4css1.css')
    " exec "!rst2html.py   --stylesheet=". style . " % > /tmp/_rst.html"
    exec "!rst2html2.py  % > /tmp/_rst.html"
    exec bang.browser."/tmp/_rst.html &"

    " for file in split(glob("~/.vim/scripts/css/*"))
    "     exec "!rst2html.py   --stylesheet=". file . " --title=".file." % > /tmp/_rst.html"
    "     exec bang.browser."/tmp/_rst.html"
    " endfor
endfun "}}}
function! s:gcp() "{{{
    let lf = ''
    for l in getline(1,10)
        if l =~ 'gtk\|gdk'
            let lf .= 'g'
        endif
        if l =~ 'math'
            let lf .= 'm'
        endif
    endfor
    let lib=''
    if lf =~ 'g' 
        let lib .=' `pkg-config --cflags --libs gtk+-2.0` '
    endif
    if lf =~ 'm'
        let lib .= ' -lm '
    endif
    exec "!gcc -Wall " . lib . " -o %:t:r %"
endfunction "}}}
"}}}3
nor   <F6>   :TagbarToggle<CR>
nor   <F7>   :GundoToggle<CR>
"{{{3 F8 File Manager
nor   <F8>   :call <SID>file_man('')<CR>
nor   <S-F8> :call <SID>file_man("sudo ")<CR>
nor   <C-F8> :CopyFull<CR>
function! s:file_man(mode) "{{{
    if s:os=="windows" | exec '!start explorer "%:p:h"'
    else            | exec "!".a:mode."nautilus '%:p:h' & "
    endif
endfunction "}}}
"{{{3 F9 Termnial
map   <silent><F9>   :VimShellBufferDir -toggle -split<CR>
imap   <silent><F9>   <Esc>:VimShellBufferDir -toggle -split<CR>
" nor   <silent><F9>   :call <SID>terminal()<CR>
function! s:terminal() "{{{
    if s:os=="windows" | exec '!start cmd "%:p:h"'
    else            | exec "!urxvt -cd %:p:h &"
    endif
endfunction "}}}
"}}}3
nor   <F10>   :options<CR>
" nor   <F11>   :script<CR>
noremap <silent> <F11> :cal VimCommanderToggle()<CR>
"{{{3 F12 Session
set sessionoptions=blank,curdir,help,tabpages,winpos,winsize,resize
" if has("unix")
"     nma <F12> :Hex! ~/.vim/sessions<CR>G$mfms
"     nma <M-F12> :Hex! ~/.vim/sessions<CR>
" else
"     nma <F12> :Hex $HOME\.vim\sessions<CR>G$mfms
"     nma <M-F12> :Hex $HOME\.vim\sessions<CR>
" endif
if !exists("*s:load_session") "{{{
    fun! s:load_session(...)
        let flist = split(glob("~/.vim/sessions/*"),'\n')
        call reverse(sort(flist))
        if a:0 && a:1
            let sp = 'new'
            exec 'noa keepa '.sp.' +setl\ nobl '. "Session_Files"
            call append(0, flist)
            setl nomodifiable readonly
            map <buffer> <Enter> :exe "source " getline('.')<CR>
        else
            exe "source ".get(flist,0)
        endif
    endfun
endif "}}}
" nma <F12>   :call <SID>load_session()<CR>
nma <F12>   :OpenSession<CR>
nma <S-F12> :SaveSession<CR>
" nma <M-F12> :ViewSession<CR>
" nma <F12>   :call SourceSession()<CR>
" nma <S-F12> :Obses ~/.vim/sessions/default<CR>
nma <M-F12> :call <SID>load_session(1)<CR>
" nma <C-F12> :call SaveSession("name")<CR>
function! SaveSession(...) "{{{
    wall
    let ses_dir = expand('~/.vim/sessions')
    call s:auto_mkdir(ses_dir,1)
    let time=strftime("%y%m%d_%H%M%S")
    if exists("a:1") && a:1=="name"
        let ses =  input("Please Input your session name:")
        if  ses != ""
            let sesname = time."_".ses
        else
            echo "Invalid Input name. Stop!"
            return
        endif
    else
        let sesname = time
    endif

    try
        exe "Obses "."~/.vim/sessions/".sesname
        echom "mks success! session file : ".sesname
    catch /^vim\%((\a\+)\)\=:/
        echoe "mks failure! error: " .v:exception
    endtry
endfunction "}}}
" 4.Plugins "{{{1
" 
aug au_Plugins "{{{
    au!
    au colorscheme *.vwk call s:vimwiki_my_set()
    au FileType,Syntax vimwiki  call s:vimwiki_my_set()
    au FileType netrw    call s:netrw_my_set()
    autocmd CmdwinEnter * map <buffer> <F5> <CR>q:
aug END "}}}
" NERDTree
let NERDTreeIgnore = ['\~$','\.pyc$']
" Netrw "{{{2
let g:netrw_keepdir        = 0
let g:netrw_preview        = 1
let g:netrw_liststyle      = 1
let g:netrw_winsize        = 30
let g:netrw_browse_split   = 0
let g:netrw_cursor         = 3
let g:netrw_banner         = 1
let g:netrw_mousemaps      = 0
let g:netrw_special_syntax = 1
let g:netrw_timefmt        = "%y-%m-%d  %H-%M-%S"
let g:netrw_list_hide      = '^[.]\w\|.*\.swp$'
let g:netrw_cursor         = 0
let g:netrw_errorlvl       = 1
let g:netrw_home           = expand('~/.vim')

function! s:netrw_my_set() "{{{
    nor   <buffer>qq               :close<CR>
    map   <buffer><2-leftmouse>    <CR>
    map   <buffer><space><space>   mf
endfunction "}}}
" Neocomplcache "{{{2
nno <leader>nt :NeoComplCacheToggle<CR>
nno <leader>nb :NeoComplCacheCachingBuffer<CR>
let g:acp_enableAtStartup                      = 0
let g:neocomplcache_enable_at_startup          = 1
let g:neocomplcache_enable_smart_case          = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_ignore_case         = 0
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length          = 2
let g:neocomplcache_lock_buffer_name_pattern   = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" let g:neocomplcache_disable_caching_file_path_pattern="fuf"
" let g:neocomplcache_quick_match_patterns={'default':'`'}
" let g:neocomplcache_quick_match_table = {
"             \'1' : 0, '2' : 1, '3' : 2, '4' : 3, '5' : 4, '6' : 5, '7' : 6, '8' : 7, '9' : 8, '0' : 9,
"             \}

if exists("*neocomplcache#smart_close_popup")
    ino <expr><C-h>   neocomplcache#smart_close_popup()."\<left>"
    ino <expr><C-l>   neocomplcache#smart_close_popup()."\<right>"
    ino <expr><Space> neocomplcache#smart_close_popup()."\<Space>"
    ino <expr><CR>    neocomplcache#smart_close_popup()."\<CR>"
    ino <expr><BS>    neocomplcache#smart_close_popup()."\<BS>"
    ino <expr><C-y>   neocomplcache#close_popup()
endif

"{{{ omni comp
aug neocomp_omni_compl "{{{
    au! neocomp_omni_compl
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
aug END "}}}
" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
"}}}

" neocompl cache snippets_complete
" nmap <c-k> a<c-k><esc>
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" ino <expr>.   pumvisible() ? "." : "."
" ino <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
" ino <expr><s-TAB> pumvisible() ? "\<C-p>" : "\<s-TAB>"
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
let g:neosnippet#snippets_directory = "~/Dropbox/vim/my_snips/snippets_complete/"

map <leader>se :sp\|NeoSnippetEdit<cr>
map <leader>sr :sp\|NeoSnippetSource<cr>
map <leader>s_ :sp\|e ~/Dropbox/vim/my_snips/snippets_complete/_.snip <cr>

" VimShell
if exists("*vimshell#set_execute_file")
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
	" let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
	let g:vimshell_enable_smart_case = 1
	
	if has('win32') || has('win64')
	  " Display user name on Windows.
	  let g:vimshell_prompt = $USERNAME."% "
	else
	  " Display user name on Linux.
	  let g:vimshell_prompt = $USER."% "
	
	  call vimshell#set_execute_file('bmp,jpg,png,gif', 'gexe eog')
	  call vimshell#set_execute_file('mp3,m4a,ogg', 'gexe amarok')
	  let g:vimshell_execute_file_list['zip'] = 'zipinfo'
	  call vimshell#set_execute_file('tgz,gz', 'gzcat')
	    call vimshell#set_execute_file('tbz,bz2', 'bzcat')
	endif
	
	" Initialize execute file list.
	let g:vimshell_execute_file_list = {}
	call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
	let g:vimshell_execute_file_list['rb'] = 'ruby'
	let g:vimshell_execute_file_list['pl'] = 'perl'
	let g:vimshell_execute_file_list['py'] = 'python'
	call vimshell#set_execute_file('html,xhtml', 'gexe firefox')
	
	autocmd FileType vimshell
	\ call vimshell#altercmd#define('g', 'git')
	\| call vimshell#altercmd#define('i', 'iexe')
	\| call vimshell#altercmd#define('l', 'll')
	\| call vimshell#altercmd#define('ll', 'ls -l')
	\| call vimshell#hook#add('chpwd', 'my_chpwd', 'g:my_chpwd')
	
	function! g:my_chpwd(args, context)
	  call vimshell#execute('ls')
	endfunction
	
	autocmd FileType int-* call s:interactive_settings()
	function! s:interactive_settings()
	endfunction
endif
" Vimwiki "{{{2
map <Leader>ww <Plug>VimwikiIndex

let wiki_1 = {}
if &term=='cygwin'
    let wiki_1.path      = '/d/Dropbox/vimwiki'
    let wiki_1.path_html = '/d/Documents/vimwiki_html'
else
    let wiki_1.path      = '~/Dropbox/Vimwiki'
    let wiki_1.path_html = '~/Documents/vimwiki_html'
endif
let wiki_1.maxhi = 0
let wiki_1.ext   = '.vwk'
let wiki_1.diary_index   = 'index'
let wiki_1.diary_rel_path   = 'Writing/Diary/'
let wiki_1.css_name = 'style.css'
let wiki_1.nested_syntaxes = { 'python': 'python',
            \'cpp': 'cpp', 'c': 'c','vim': 'vim', 'sh': 'sh',
            \'html': 'html'}
let g:vimwiki_list = [wiki_1]

let g:vimwiki_file_exts='pdf,txt,doc,rtf,xls,zip,rar,7z,gz
            \,py,sh,rb,pl,lua,go,hs,conf,j,vim,vba,vwk
            \,c,cpp,h,java,xml
            \,js,css,html,php,coffee'
let g:vimwiki_camel_case    = 0
let g:vimwiki_menu          = ""
let g:vimwiki_dir_link      = 'index'
if has("unix")
    let g:vimwiki_browsers      = ['firefox']
else
    let g:vimwiki_browsers      = ['d:\SoftWareD\Browser\firefox4\firefox.exe']
endif
" let g:vimwiki_conceallevel  = 2
let g:vimwiki_lower         = "a-z0-9\u0430-\u044f"
let g:vimwiki_list_ignore_newline =0
let g:vimwiki_url_mingain   = 99                " url Conceal length
let g:vimwiki_use_mouse     = 1
let g:vimwiki_folding       = 1
let g:vimwiki_fold_lists    = 0
let g:vimwiki_hl_cb_checked = 1
function! s:sub_list(sym) "{{{
    let line=getline('.')
    if a:sym != " "
        let sym = a:sym
    else
        let sym = ""
    endif
    let m=substitute(line,'^\(\s*\)\%([*#-]\s\|\%(\d\.\)\+\s\)\=\ze.*',
                \'\1'.sym.' ','')
    if a:sym == " "
        let m =substitute(m,'^\s','','')
    endif
    call setline(line('.'),m)
endfunction "}}}
function! s:cindex(ftype) "{{{
    let idx = "index.".a:ftype
    if filereadable(idx)
        if expand('%') == idx
            edit #
        else
            exe "edit ". idx
        endif
    else
        echo "No index for current page"
    endif
endfunction "}}}
function! s:vimwiki_my_set() "{{{

    hi VimwikiBold NONE
    hi link VimwikiBold Title
    hi VimwikiItalic NONE
    hi link VimwikiItalic Character
    hi VimwikiItalicBold NONE
    hi link VimwikiItalicBold Exception
    hi VimwikiBoldItalic NONE
    hi link VimwikiBoldItalic Exception
    hi VimwikiStrikeOut NONE

    silent! syn clear VimwikiTimeStamp
    syn match VimwikiTimeStamp /\%(\d\{4}-\d\{2}-\d\{2}\|\d\{6}_\d\{4}\)/

    " syn clear VimwikiPre
    " execute 'syntax region VimwikiInPre matchgroup=VimwikiPre'
    "             \.' start=/^\s*'.g:vimwiki_rxPreStart.'/'
    "             \.' end=/^\s*'.g:vimwiki_rxPreEnd.'\s*$/'
    "             \.' contains=@Spell'
    hi link VimwikiInPre String
    hi link VimwikiPre SpecialComment

    silent! syn clear vimwikiList
    let rxListBullet = '^\s*\zs\%(\*\|-\|#\)\ze\s'
    execut 'syn match VimwikiList /'.rxListBullet.'/'
    silent! syn clear vimwiki_rx_list_num
    syn match vimwiki_rx_list_num /^\s*\(\d\+\.\)\+\ze\s/
    hi default link vimwiki_rx_list_num VimwikiList

    for i in range(1,6)
        let g:vimwiki_rxH{i} = '^\s*=\{'.i.'}[^=]\+.*[^=]\+=\{'.i.'}\s*$'
        silent! exe 'syn clear VimwikiHeader'.i
        exe 'syn match VimwikiHeader'.i.' /'.g:vimwiki_rxH{i}.'/ contains=VimwikiTodo,VimwikiNoExistsLink,VimwikiLink,@Spell'
    endfor

    let g:vimwiki_rxListBullet = '^\s*\%(\*\|-\|#\)\s'
    let g:vimwiki_rxListNumber = '^\s*\(%\d\+[\.)]\)\+\s'
    syn clear VimwikiList
    execute 'syntax match VimwikiList /'.g:vimwiki_rxListBullet.'/'
    execute 'syntax match VimwikiList /'.g:vimwiki_rxListNumber.'/'
    hi link VimwikiList Label
    hi link VimwikiTimeStamp SpecialComment


    if g:vimwiki_hl_cb_checked
        syn clear VimwikiCheckBoxDone
        execute 'syntax match VimwikiCheckBoxDone /'.
                    \ g:vimwiki_rxListBullet.'\s*\['.g:vimwiki_listsyms[4].'\].*$/'.
                    \ ' contains=VimwikiNoExistsLink,VimwikiLink'
        execute 'syntax match VimwikiCheckBoxDone /'.
                    \ g:vimwiki_rxListNumber.'\s*\['.g:vimwiki_listsyms[4].'\].*$/'.
                    \ ' contains=VimwikiNoExistsLink,VimwikiLink'
    endif

    map <buffer><leader>ee <Plug>VimwikiToggleListItem
    map <buffer><leader>e1 :call <SID>sub_list('1.')<cr>
    map <buffer><leader>e2 :call <SID>sub_list('*')<cr>
    map <buffer><leader>e3 :call <SID>sub_list('#')<cr>
    map <buffer><leader>e4 :call <SID>sub_list('-')<cr>
    map <buffer><leader>e5 :call <SID>sub_list(' ')<cr>


    map <buffer><leader>wlg <Plug>VimwikiGenerateLinks
    map <buffer><Leader>wlr <Plug>VimwikiRenameLink
    map <buffer><Leader>wld <Plug>VimwikiDeleteLink
    map <buffer><Leader>wli :call <SID>cindex("vwk")<CR>
    map <buffer><Char-28> :call <SID>cindex("vwk")<CR>


    map <buffer><Leader>wt :VimwikiTable<CR>

    map <buffer><Leader>w2h :Vimwiki2HTML<CR>

    map <buffer><c-s-Up> :VimwikiDiaryPrevDay<CR>
    map <buffer><c-s-Down> :VimwikiDiaryNextDay<CR>
    map <buffer><c-up> :tabclose<CR>
    map <buffer><c-down> :tabnew<CR>

    map <buffer><expr> <rightmouse><leftmouse> "<Plug>VimwikiGoBackLink"
    ima <buffer><expr> <rightmouse><leftmouse> "<Plug>VimwikiGoBackLink"

    imap <buffer><expr><TAB> 
    \ pumvisible() ? "\<C-n>" :  vimwiki#tbl#kbd_tab()
    imap <buffer><expr><S-TAB> 
    \ pumvisible() ? "\<C-p>" :  vimwiki#tbl#kbd_shift_tab()

    vno <buffer><c-CR>   gq
    nno <buffer><c-CR>   kJ
    ino <buffer><c-CR>   <esc>kJi
    vno <buffer><c-kEnter>   gq
    nno <buffer><c-kEnter>   kJ
    ino <buffer><c-kEnter>   <esc>kJi
    nor <buffer><s-CR>   o<ESC>
    ino <buffer><s-CR>   <esc>O
    setl shiftwidth=4 softtabstop=4
    setl cms=%%%%\ %s
    setl foldmethod=expr
    setl foldexpr=VimwikiFoldLevel(v:lnum)
endfun "}}}
" Git "{{{2
nmap  <leader>ga :call <SID>git_add()<cr>
nmap  <leader>gc :Gcommit<cr>
nmap  <leader>gp :Git push<cr>
nmap  <leader>gl :Git pull<cr>
nmap  <leader>gsi :Git submodule init <CR>:Git submodule update<cr>
nmap  <leader>gdf :Gsdiff<CR>
nmap  <leader>gb :Git branch -r<CR>
nmap  <leader>grs :Git reset<CR>
nmap  <leader>gds :Git diff -stat<CR>
nmap  <leader>grb :Git rebase --interactive --autosquash master<CR>
nmap  <leader>gf  y<C-G>:Git commit --fixup <C-R>
            \"<del><del><del><del><del><del><del><del><del><del><del><del>
            \<del><del><del><del><del><del><del><del><CR>



" nmap  <leader>gk :Git checkout
" nmap  <leader>gr :Git branch
nmap  <leader>wc :bot cw<CR>
function! s:git_add() "{{{
    LastUpdate | update! | redraw
    try
        Git add %
    catch /^Vim\%((\a\+)\)\=:E492/
        echohl WarningMsg
        echo "[Warning]Not a git repo..."
        echohl Normal
    endtry
endfunction "}}}
" Gist "{{{2
nmap <leader>gss :Gist<CR>
nmap <leader>gsl :Gist -l<CR>
" Python "{{{2
" " Execute the tests
" nmap <silent><Leader>tf <Esc>:Pytest file<CR>    
" nmap <silent><Leader>tc <Esc>:Pytest class<CR>   
" nmap <silent><Leader>tm <Esc>:Pytest method<CR>  
" " cycle through test errors 
" nmap <silent><Leader>tn <Esc>:Pytest next<CR>     
" nmap <silent><Leader>tp <Esc>:Pytest previous<CR> 
" nmap <silent><Leader>te <Esc>:Pytest error<CR>    

function! s:py_aug()
    
syn keyword pythonClass	self
hi link pythonClass	Keyword
endfunction



" " Add the virtualenv's site-packages to vim path
" py << EOF
" import os.path
" import sys
" import vim
" if 'VIRTUAL_ENV' in os.environ:
"     project_base_dir = os.environ['VIRTUAL_ENV']
"     sys.path.insert(0, project_base_dir)
"     activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"     execfile(activate_this, dict(__file__=activate_this))
" EOF


" Syntasic "{{{2
" let g:syntastic_python_checker = 'pyflakes'
nmap <leader>ln :lne<CR>
nmap <leader>lp :lpr<CR>

" Misc Plugins "{{{2

    let g:python_fold_block = "all"

    let g:gundo_preview_bottom    = 1
    let g:gundo_width             = 30
    let g:gundo_right             = 1

    let g:tagbar_compact          = 1
    let g:tagbar_width            = 30
    let g:ctrlp_dotfiles  = 0
    let g:ctrlp_max_depth = 10
    let g:ctrlp_clear_cache_on_exit = 0
    let g:ctrlp_max_depth = 20

    let g:user_emmet_settings       = { 'indentation' : '    '}
    let g:user_emmet_leader_key     = '<c-f>'
    let g:user_emmet_expandabbr_key = '<c-f>f'    "e
    let g:user_emmet_expandword_key = '<c-f>F'    "e
    let g:user_emmet_next_key       = '<c-f>j'    "n
    let g:user_emmet_prev_key       = '<c-f>k'    "p
    let g:user_emmet_removetag_key  = '<c-f>d'    "k
    " let g:pydoc_cmd = "/usr/bin/pydoc"
let g:ropevim_guess_project=1
let g:ropevim_autoimport_modules = ["os", "sys"]
let g:ropevim_enable_autoimport = 1

" vim-session
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 60

nor <leader>cc :TComment<cr>
nor \\ :TComment<cr>

nma <leader>cE :ColorVEditAll<CR>

vma <leader>ft :Tab /
nma <leader>ft :.Tab /
" 5.Functions "{{{1
" fun! SourceSession()
"     " Check variable is useless.
"     " We should check process and pid file
"     " NOTE: if has "+clientserver" we could use serverlist()
"     if has('clientserver') && len(split(serverlist())) == 1
"     " if !exists("g:session_default_loaded") || g:session_default_loaded == 0
"         " let g:session_default_loaded = 1
"         source ~/.vim/sessions/default
"     else
"         source ~/.vim/sessions/default
"     endif
"     " endif
" endfun

" 6.FileTypes "{{{1
aug au_Filetypes "{{{
    au!
    au BufRead,BufNewFile *.j,*.wct setf jass
    au BufRead,BufNewFile *.mako    setf mako
    au BufRead,BufNewFile *.conf    setf conf
    au BufRead,BufNewFile tmux.conf setf tmux
    au FileType c,cpp    setl fdm=syntax
    au FileType jass     setl wrap fdm=syntax
    au FileType jass     nor <buffer> gD :call <SID>jass_goDef()<CR>
    au FileType javascript call <SID>js_fold()
    au FileType python map <buffer> <F1> :Pydoc <C-R><C-W><CR>
    au FileType python map <buffer> K k
    au FileType python setl wrap foldtext=MyFoldText()
    au FileType python  call <SID>py_aug()
    au FileType python  setl fdm=indent
    " au FileType javascript setl fdm=syntax
    au Filetype php,html,xhtml,xml setl shiftwidth=4 softtabstop=4
    au Filetype php,html,xhtml,xml setl foldmethod=indent
    au FileType help setl isk+=-,:
    au FileType help call <SID>hlp_fold()
    au FileType vim setl isk+=:
    au FileType html cal <SID>check_ft()
    " au FileType rst syn spell toplevel
aug END "}}}
fun! s:check_ft() "{{{
    " The django file place
    if expand('<afile>:p') =~ '[/\\]templates[/\\]'
        set ft=htmldjango
    endif
endfun "}}}
" PHP "{{{2
let php_sql_query = 1
let php_folding=2
let php_htmlInStrings = 1
let php_parent_error_close = 1
" Help "{{{2
function! s:hlp_fold() "{{{
    setl foldmethod=syntax
    setl foldtext=MyHlpFoldText()
    syn region foldBraces start=/[-=]\{50,}/
                \ end=#\ze[-=]\{50,}# transparent fold keepend
endfunction "}}}
function! MyHlpFoldText() "{{{
    let dash = getline(v:foldstart)[0]
    let line = getline(v:foldstart+1)
    let num  = printf("%4s",(v:foldend-v:foldstart))
    let line = substitute(line, '\%>44c\%<53c', '['.dash.num.']', '')
    return line
endfunction "}}}
" JavaScript {{{2
function! s:js_fold() "{{{
    setl foldmethod=syntax
    syn region foldBraces start=/{/ skip=#/\%([^/]\|\/\)*/\|'[^']*'\|"[^"]*"#
                \ end=/}/ transparent fold keepend extend 
endfunction "}}}
" MarkDown "{{{2
aug au_blog_MARKDOWN "{{{
    au!
    au! BufRead,BufNewFile */Rykka.github.com/**.md    call <SID>blog_setup()
aug END "}}}
function! s:blog_setup() "{{{
    set ft=markdown 
    map <silent><buffer> <leader>mp  :!rake post title=""<left>
    map <silent><buffer> <leader>mg  "!rake page name="pages/"<left>
endfunction "}}}
" TEST
" let g:_riv_debug=1
let proj1 = { 'path': '~/Dropbox/rst',}
let proj2 = { 'path': '~/Dropbox/riv_test', 'build_path': '~/Documents/riv_test_build',
            \'scratch_path': '~/Documents/riv_test_scratch'}
let proj3 = { 'path': '~/Documents/RIV_TEST'}
let proj4 = { 'path': '~/Documents/sphinx'}
let proj5 = { 'path': '~/Documents/django/docs/',
            \'source_suffix':'.txt',
            \'file_link_style':2,}
let proj6 = { 'path': '~/Dropbox/wiki/'}



" let proj2 = { 'path': '~/Dropbox/riv', 'build_path': '~/Documents/riv_build',}
let g:riv_projects = [proj1,proj2,proj3,proj4,proj5,proj6]
" map <silent> <leader>ww <Plug>RivIndex
" let g:riv_file_link_style = 2
" let g:riv_todo_datestamp = 1
" let g:virtualenv_directory = '~/vir/'
let g:riv_fold_text_align = 'right'
let g:riv_file_link_ext = 'vim,cpp,c,py,rb,lua,pl,html,htm'
" let g:riv_file_ext_link_hl = 'vim,cpp,c,py,rb,lua,pl,html,htm'
let g:riv_highlight_code = 'lua,python,cpp,javascript,vim,sh,jinja'



" let g:riv_fold_auto_update = 0
let $EDITOR='gvim'
" unlet! g:riv_default.buf_imaps["<Tab>"]
" let g:riv_i_tab_pum_next = 0
" let g:riv_i_tab_user_cmd = "\<c-g>u\<c-r>=snipMate#TriggerSnippet()\<cr>"


" update remote file
fun! s:update_remote() "{{{
    let file = expand('%:p')
    let work_dir = '/home/rykk/workspace/ltproject/djlingtong'
    let project = 'qzlingtong.com'
    let r_dir = '/var/www/qzlingtong.com'
    if file =~ work_dir
        let r_file = substitute(file, work_dir, r_dir, '')
        echo r_file
        exe '!scp % root@qzlingtong.com:'.r_file
        " exe '!ssh root@qzlingtong.com dja collectstatic'
    else
        echo 'NOT in work dir'
    endif
endfun "}}}

map <leader>ur :call <SID>update_remote()<cr>

" com! -nargs=? OpenWork OpenSession <args>
com! -nargs=? SetWork  SaveSession <args>

com! -nargs=0 JsBeautify call JsBeautify() | setf javascript
com! -nargs=0 CssBeautify call CssBeautify() | setf css
com! -nargs=0 HtmlBeautify call HtmlBeautify() | setf html

fun! s:find_undo() "{{{
    let fname = expand('~/.vim_undo/').substitute(expand('%:p'), '/','%','g')
    if filereadable(fname)  
        if input("Delete current undo file: ".fname." ?(y/n)") == 'y'
            call delete(fname)
        endif
    else
        echo 'file not readable: '.fname
    endif
endfun "}}}
map <leader>uf :call <SID>find_undo()<CR>
map <leader>3v :view /usr/lib/python2.7/<CR>
map <leader>2v :edit ~/.vim/bundle/<CR>
map <leader>4v :edit ~/.virtualenvs/aimi/lib/python2.7<CR>
" let g:riv_basic_path = '~/Doc/Riv'

" Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
fun! s:mv_file(fname) "{{{
    let fname = expand(a:fname)
    let ext = fnamemodify(fname, ':e')
    if filereadable(fname)
        if ext=~ '^\d\+$'
            let ext = ext + 1
            let file = fnamemodify(fname, ':p:r')
        else
            let ext = '1'
            let file = fname 
        endif
        let n_f = file . '.'.ext
        call s:mv_file(n_f)
        call s:sys('mv '.fname. ' '. n_f )
        echom 'mv '.fname. ' '.n_f 
    endif
endfun "}}}
fun! s:sys(arg) abort
    call system(a:arg)
endfun
fun! s:profile_riv()
    call s:mv_file('/home/ryk/Desktop/riv.profile')
    exec 'profile start '.'/home/ryk/Desktop/riv.profile'
    " profile func riv#fold#init
    profile func *_parse_from_start
    profile func *_check
    profile func *_set_obj_dict
    e ~/Dropbox/rst/directives_instruction.rst
    qall
    " RestartVim 
endfun
com! -nargs=0 ProRiv call <SID>profile_riv()
map '' <nop>
