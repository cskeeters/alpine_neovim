" Set this to higher numbers to increase vim's speed (while losing features)
"  0 : Slowest, all features enabled
"  1 : Disables features that slow down vim the most
"  2 : Disables custom color highlighting
"  3 : Disables syntax highlighting all together
let g:speed=0


set nocompatible
" vi-compatible sentences have two spaces after them.
set cpo+=J " Recognize sentences by two spaces after punctuation

scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8

set tags=tags
set tags+=../tags
set tags+=../../tags
set tags+=../../../tags

set expandtab                   " tabs are spaces, not tabs (et)
set shiftwidth=4                " use indents of 4 spaces (sw)
set tabstop=4                   " an indentation every four columns (ts)
set softtabstop=8               " Column text should be easily aligned with this at 8
set shiftround                  " >> and << will round to the nearest shiftwidth
set smarttab                    " Make shiftwidth affect spaces added when tabs are typed

set linebreak                   " When wrap is on, break at word boundaries

set nospell
set spelllang=en_us
set dictionary=/usr/share/dict/words

" Enable 'vim: tw=80 noet sw=2' in files
set modeline

set printoptions=left:2cm,top:1in,right:2cm,bottom:1in,duplex:off,paper:letter,syntax:y,number:y

" Ignore settings
let g:ack_wildignore=0 " Otherwise error ack.vim line 31
set wildignore=tags,a.out,depmod,*.so,*.a,*.o,*.dep,*.class,*.pyc

set hidden                      " Allow buffers (unsaved) in the background (like tabs)
set virtualedit=block           " Block mode allows cursor to go where spaces don't exist
"set virtualedit+=onemore        " Allow cursor to stay one character past the end of the line
set autoindent                  " indent at the same level of the previous line
set cindent
set smartindent                 " New lines start indented appropriately
set nowrap                      " wrap long lines
set breakindent                 " When wrapping, the next line should be indented the same as the first

set textwidth=0                 " Used in autoformatting (tw)

"set comments=sl:/*,mr:*,elx:*/  " auto format comment blocks with gq see help format-comments
set comments=n:\"
set comments=n:>
set comments=n://
set comments=sr:/***,m:*,elx:***/
" set formatoptions+=a " to get format as you type in comments (fo)
" set formatoptions-=a " to disable
set formatoptions+=j " Delete comment character when joining commented lines

" works for normal and insert.  I want insert to work
set backspace=indent,eol,start

set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when upper is present in search

set number
if version > 703
    if g:speed == 0
        " This is a redraw hog!
        set relativenumber
    endif
endif

set splitbelow
set splitright

set showcmd " Shows partial key sequences

set scrolloff=3      " minimum lines to keep above and below cursor
set scrolljump=5     " lines to scroll when cursor leaves screen
set sidescrolloff=5

set display+=lastline

set noshowmatch                   " Use pi_paren plugin instead
set matchtime=5
"let loaded_matchparen = 1       " Disable pi_paren plugin
" see guicursor, cpoptions
"disable/enable with NoMatchParen/DoMatchParen
"highlight MatchParen cterm=lightblue guibg=lightblue
"highlight MatchParen guibg=lightred
set matchpairs=(:),{:},[:]

set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.

set laststatus=2                " 2 - Always show status line

" statusline Colors
"   directory
hi default link User1 Directory
"   filename
hi default link User2 String
"   filetype
hi default link User3 Type

" This will be overwritten if vim-statusline is loaded
set statusline=\ \ %1*\ %{getcwd()}\ %0*                        " current root or dir
set statusline+=\ \ %2*\ %f%m\ %0*                              " Filename/Modified
set statusline+=%=                                              " Right Aligned
set statusline+=%v/%l/%L\                                       " cursor pos
set statusline+=\ \ %3*\ %{&ft}\ %0*\                           " Filetype
set statusline+=%{&fenc?&fenc:&enc}/%{&ff}\                     " Encoding/EOL
set statusline+=%w                                              " Preview
set statusline+=%r\                                             " Read Only

set history=1000 " : command history size

" Highlight problematic whitespace
set list
set listchars=tab:>\ ,trail:+,extends:#,nbsp:.
if has('multi_byte')
    if $TERM != "konsole"
        " For some reason UTF characters are not showing in vim
        set listchars=trail:·,precedes:«,extends:»,tab:▸·
        set listchars+=nbsp:·
        "set listchars+=eol:↲
    endif
endif

" show the ruler (only if statusline isn't shown - laststatus=0 or 1
set ruler
set rulerformat=%30(%=%y%m%r%w\ %l,%r%V\ %p%)

set autoread
set nobackup
if $TMUX == ''
    set swapfile   " Swap file lets you know the buffer is open in another window
else
    set noswapfile
endif

set backupdir=~/.vim/backup
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif

set directory=~/.vim/tmp  " Where the swap file will go
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif

if executable('ag')
    " Make :grep use the silver searcher (ag)
    set grepprg=ag\ --nogroup\ --nocolor\ --column\  "this comment prevents trailing space on this line
    "set grepprg=grep\ -n\
    set grepformat=%f:%l:%c:%m
endif


if g:speed < 1
    set cursorline
    " This slows things down
    set colorcolumn=+0              " Use textwidth variable
endif

if g:speed > 0
    set synmaxcol=200
    set lazyredraw
    set regexpengine=1
endif

augroup vimdiff
    autocmd!
    " Run diffupdate everytime Cursor is moved
    " autocmd CursorMoved,CursorMovedI * if &diff == 1 | diffupdate | endif
    " in case CursorMoved,CursorMovedI is too CPU intensive
    autocmd BufWritePost * if &diff == 1 | diffupdate | endif
augroup END

augroup quickfix
    autocmd!
    " Open quickfix window by default after helpgrep or the like
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
augroup END

let mapleader = ','
let maplocalleader = ' '

nnoremap Q :echom "Exmode Disabled"<cr>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Don't overwrite unnamed register with deleted character
nnoremap x "_x

" Removes highlighting on insert
" https://vi.stackexchange.com/questions/10407/stop-highlighting-when-entering-insert-mode
autocmd InsertEnter * setlocal nohlsearch
autocmd InsertLeave * setlocal hlsearch
inoremap <silent><Esc> <Esc>:nohl<CR>
inoremap <silent><C-c> <Esc>:nohl<CR>
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

"junegunn/fzf.vim
if !has("gui_running")
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    imap <c-x><c-l> <plug>(fzf-complete-line)
endif

nnoremap ]f :next<cr>
nnoremap [f :prev<cr>

nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>
nnoremap ]Q :cnewer<cr>
nnoremap [Q :colder<cr>

" Location List :lgrep :lvimgrep
nnoremap ]l :lnext<cr>
nnoremap [l :lprev<cr>
nnoremap ]L :lnewer<cr>
nnoremap [L :lolder<cr>

" Tag Stack (Although I normall use the jump list CTRL-O)
nnoremap ]t :tag<cr>
nnoremap [t :pop<cr>

" Jump List
nnoremap ]j <c-I>
nnoremap [j <c-O>

" Matching Tag List - Loaded with :tselect or g]
nnoremap ]g :tnext<cr>
nnoremap [g :tprevious<cr>

" CTRL-W_} then cycle through matches in preview window
nnoremap ]p :ptnext<cr>
nnoremap [p :ptprev<cr>

nnoremap ]T :tabnext<cr>
nnoremap [T :tabprevious<cr>

nnoremap ]w :wincmd l<cr>
nnoremap [w :wincmd h<cr>

" Delete to black hole
vnoremap <leader>d "_d

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv


""""""""""""""""""""""""""""""""" Keyboard Mappings: Settings Modification
nnoremap \2 :setlocal sw=2 ts=2<cr>
nnoremap \3 :setlocal sw=3 ts=3<cr>
nnoremap \4 :setlocal sw=4 ts=4<cr>
nnoremap \8 :setlocal sw=8 ts=8<cr>
nnoremap \t :setlocal expandtab!<cr>
nnoremap \\2 :set sw=2 ts=2<cr>
nnoremap \\3 :set sw=3 ts=3<cr>
nnoremap \\4 :set sw=4 ts=4<cr>
nnoremap \\8 :set sw=8 ts=8<cr>
nnoremap \\t :set expandtab!<cr>

" This facilitates copying multiple lines of text from terminal vim
nnoremap \n :set number relativenumber<cr>
nnoremap \N :set nonumber norelativenumber<cr>

" Reload to force line endings
nnoremap \\d :e ++ff=dos<cr>
nnoremap \\u :e ++ff=unix<cr>
nnoremap \d :set ff=dos<cr>
nnoremap \u :set ff=unix<cr>

":retab to convert

nnoremap \s :set spell!<cr>        " Toggles Spelling

nnoremap \w :set wrap<cr>    " Go into wrap mode
nnoremap \W :set nowrap<cr>  " Exit wrap mode

nnoremap \\v :source $MYVIMRC<cr>

" junegunn/rainbow_parentheses.vim
nnoremap \r :RainbowParentheses!!<cr>

" tpope/vim-commentary
" For changing comment characters in html/script/style
nnoremap \c/  :set commentstring=//\ %s<cr>
nnoremap \c*  :set commentstring=/*\ %s\ */<cr>
nnoremap \c-  :set commentstring=<!--\ %s\ --><cr>

" Toggle diff
nmap <space>d :ToggleDiff<cr>

" When text doesn't highlight
nnoremap \\5 :syntax sync minlines=500<cr>
nnoremap \\x :syntax sync fromstart<cr>

" Change Working Directory to that of the current file
nnoremap <c-j>. :lcd %:p:h<cr>
nnoremap <c-j>u :lcd ..<cr>
nnoremap <c-j>1 :lcd ..<cr>
nnoremap <c-j>2 :lcd ../..<cr>
nnoremap <c-j>3 :lcd ../../..<cr>

"junegunn/fzf.vim
nnoremap <c-j>t :Tag<CR>
nnoremap g] :Tags '<C-r>=expand('<cword>')<CR> <CR>

nnoremap g/ :Ag <C-r>=expand('<cword>')<CR><CR>
nnoremap <c-j>; :BLines<CR>
nnoremap <c-j>: :Lines<CR>
noremap <C-j>b :Buffers<CR>
noremap <C-j>v :Files ~/.vim/plugged<CR>
noremap <C-j><C-j> :Files<CR>
noremap <C-j>f :Files<CR>

"cskeeters/closer.vim
nmap <silent> <C-j>c <Plug>OpenCloser

" Use sudo and tee to write the file as root
nmap <leader><leader>w :w !sudo tee % >/dev/null<cr>

"cskeeters/vim-leave-window
nnoremap <silent> <leader>gw :LWClose!<cr>
nnoremap <silent> <leader>w :LWClose<cr>

noremap <leader>q :q<CR>

" cskeeters/vim-simple-alt
nmap <leader>l :Alt<cr>

" Choose first spelling suggestion
nnoremap <localleader>. z=1<cr><cr>

" Remove trailing whitespace in current buffer
nnoremap <localleader><localleader>w :%s/\s\+$//<cr>

" cskeeters/vim-simple-comment
vmap <localleader><localleader>c <Plug>MultiLineComment

" tpope/vim-commentary
xmap <localleader>c  <Plug>Commentary
nmap <localleader>c  <Plug>Commentary
omap <localleader>c  <Plug>Commentary
nmap <localleader>cc <Plug>CommentaryLine
nmap c<localleader>c <Plug>ChangeCommentary
nmap <localleader>cu <Plug>Commentary<Plug>Commentary

iab <expr> dts strftime("%FT%T%z")
iab <expr> ds strftime("%Y-%b-%d")

nmap <C-k> :make<cr>

"Disable netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
let g:netrw_liststyle    = 1

let g:netrw_liststyle=1

call plug#begin('~/.vim/plugged')

" cia (change, in, argument)
Plug 'https://github.com/vim-scripts/argtextobj.vim'

" cii (change, in, indent)
Plug 'https://github.com/michaeljsmith/vim-indent-object'

Plug 'https://github.com/tpope/vim-repeat'

if version > 800
    " Addresses a possible bug where vim (term) doesn't fall back to underline
    " from undercurl
    let &t_Cs = "\e[4:3m"
    let &t_Ce = "\e[4:0m"
endif

Plug 'https://github.com/chriskempson/base16-vim',
    \ { 'do': 'git clone https://github.com/chriskempson/base16-shell.git ~/.vim/base16-shell' }
if $TERM != "konsole"
    " As a work around for the following bugs in kde4's konsole:
    " https://github.com/chriskempson/base16-shell/issues/31
    let g:base16_shell_path = $HOME."/.vim/base16-shell/scripts"
    let base16colorspace=256
endif
set background=dark

Plug 'https://github.com/junegunn/rainbow_parentheses.vim'
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [7, 10, 12]

Plug 'https://github.com/moll/vim-bbye'
Plug 'https://github.com/cskeeters/vim-leave-window'
Plug 'https://github.com/cskeeters/closer.vim'
Plug 'https://github.com/cskeeters/vim-simple-alt'
Plug 'https://github.com/cskeeters/vim-map-enter'
Plug 'https://github.com/mbbill/undotree'
Plug 'https://github.com/tpope/vim-abolish'
Plug 'https://github.com/cskeeters/vim-simple-comment'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/cskeeters/vim-diff-settings'

Plug 'https://github.com/preservim/tagbar'
"Plug 'https://github.com/majutsushi/tagbar'
" Add support for markdown files in tagbar.
" https://github.com/majutsushi/tagbar/wiki#markdown
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/bin/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

Plug 'https://github.com/justinmk/vim-dirvish'

Plug 'https://github.com/mileszs/ack.vim'
if executable('ag')
    let g:ackprg = 'ag --nogroup --nocolor --column'
endif

Plug 'https://github.com/junegunn/vim-easy-align'

"junegunn/vim-easy-align doesn't work for tables
Plug 'https://github.com/godlygeek/tabular'

Plug 'https://github.com/cskeeters/vim-jump'

Plug 'tpope/vim-surround'

" This defines :FZF
"If installed with brew, we don't need this
"Plug '/usr/local/opt/fzf'
Plug 'https://github.com/junegunn/fzf'

" Adds useful commands for fzf
Plug 'https://github.com/junegunn/fzf.vim'

let g:fzf_layout = {'up': '~100%'}
let g:fzf_files_options = '--reverse --preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'
let g:fzf_buffers_jump = 1
let g:fzf_tags_command = 'ctags -R'

if g:speed < 1
    Plug 'https://github.com/SirVer/ultisnips', { 'tag': '3.2' }
    " For python 2, use: Plug 'https://github.com/SirVer/ultisnips', { 'tag': '3.2' }
endif

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" vim runtime/filetype autoload/dist/ft.vim will detect htmldjango.
" This dot syntax makes html snippets accessible
autocmd FileType htmldjango set ft=htmldjango.js.css.html
autocmd FileType html set ft=js.css.html

" Personal snippets
Plug 'https://github.com/cskeeters/vim-snippets'

Plug 'https://github.com/cskeeters/vim-vcvars'
Plug 'https://github.com/cskeeters/vim-statusline'

Plug 'https://github.com/cskeeters/vim-status'

Plug 'https://github.com/cskeeters/vim-make'

"keyboard mappings and settings per file type
Plug 'https://github.com/cskeeters/vim-maps'

" from plasticboy/vim-markdown without netrw#BrowseX
Plug 'https://github.com/cskeeters/vim-markdown'

" Disable ]c to move to header since it disrupts ]c - next difference
map <Plug> <Plug>Markdown_MoveToCurHeader
let g:vim_markdown_folding_disabled = 1

Plug 'https://github.com/cskeeters/vim-markdown-maps'

Plug 'https://github.com/cskeeters/vim-md-doc'
let g:md_doc = [
            \ ["/Users/chad/working/bcst-doc", "bcst-doc"],
            \ ["/Users/chad/Dropbox/notes", "notes"] ]
let g:md_doc_auto_commit = 0

Plug 'https://github.com/itspriddle/vim-marked'
" Use Marked (version 1)
let g:marked_app = "Marked"

" HTML
Plug 'https://github.com/alvan/vim-closetag'

call plug#end()

if has('nvim')
    if $TERM_PROGRAM == "iTerm.app"
        set termguicolors
    endif
endif

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

if g:speed < 1
    " Load matchit.vim, but only if the user hasn't installed a newer version.
    if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
        runtime! macros/matchit.vim
    endif
endif

if g:speed < 2
    if has('autocmd')
        filetype plugin indent on
    endif

    colorscheme base16-default-dark
    " Vim 8 sets cterm=underline, reset that here
    highlight CursorLine   ctermbg=18 term=NONE cterm=NONE
    highlight CursorLineNr ctermbg=18 term=NONE cterm=NONE
elseif g:speed > 2
    hi clear
    syntax off
endif
