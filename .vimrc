
"{{{ Load Plugins
" -----------------------------------------------------------------------------

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" NeoBundle
NeoBundle 'Shougo/neobundle.vim'

" VimProc
" NeoBundle 'Shougo/vimproc.vim', {
"   \ 'build' : {
"   \   'mac' : 'make -f make_mac.mak',
"   \   'unix': 'make -f make_unix.mak'
"   \   }
"   \ }

" Themes
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Yggdroot/indentLine'

" Extensions
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'tpope/vim-sensible'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'xolox/vim-notes'
NeoBundle 'xolox/vim-misc'

" Editing
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-surround'
NeoBundle 'godlygeek/tabular'
" NeoBundle 'bbchung/clighter'

" Languages
NeoBundle 'mips.vim'

call neobundle#end()

filetype plugin indent on

" Check for uninstalled plugins
NeoBundleCheck

"}}}

"{{{ Settings
" -----------------------------------------------------------------------------

" General
set completeopt-=preview " don't show preview window
" set fcs=vert:│,fold:-    " solid instead of broken line for vert splits
set hidden               " hide when switching buffers, don't unload
set lazyredraw           " don't update screen when executing macros
set mouse=a              " enable mouse in all modes
set number               " show absolute line number on current line
set spelllang=en_us      " spell check with English
set gdefault             " replace everything by default
set visualbell           " stop the beep
set colorcolumn=120       " for cleaner code
set nowrap               " no softwrapping

" cursor position for saving
set viminfo='10,\"100,:20,%,n~/.viminfo

" Backup swap files
set backup
set backupdir=~/.vim/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim/tmp
set writebackup

" Infinite undo
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000

" Folding
set foldignore=          " don't ignore anything when folding
set foldlevelstart=99    " no folds closed on open
set foldmethod=marker    " collapse code using markers

" Tabs
set expandtab            " replace tabs with spaces
set shiftwidth=4         " spaces for autoindenting
set softtabstop=4        " spaces for editing, e.g. <Tab> or <BS>
set tabstop=4            " spaces for <Tab>

" Searches
set hlsearch             " highlight search results
set ignorecase           " case insensitive searching
set smartcase            " override ignorecase if upper case typed

" Colours
" colorscheme termorrow
syntax enable
colorscheme solarized
set background=dark

" Font
if has('gui_running')
    set guifont=Meslo_LG_M_for_Powerline:h11
endif

" Status line
hi StatusLine ctermbg=11 ctermfg=0
set statusline=\ \      " blank space
set statusline+=\ \     " blank space
set statusline+=%f      " Path to the file in the buffer
set statusline+=%m      " Modified flag
set statusline+=%5{v:register} "Which active register
set statusline+=%=      " Align to the right from now on
set statusline+=[%{fugitive#head()}]   " Current branch
set statusline+=\ \     " Blank space
set statusline+=%y      " Type of file in the buffer
set statusline+=%5l     " Current line
set statusline+=,       " Comma
set statusline+=%c      " Current Column
set statusline+=/       " Slash
set statusline+=%-5L    " Total lines
set statusline+=%p%%    " Percentage through the file


" map <ScrollWheelUp> <C-Y>
" map <ScrollWheelDown> <C-E>

"}}}

"{{{ Mapping
" -----------------------------------------------------------------------------

" Map Leader
let mapleader = " "

" Map : to ; and the other way around
nnoremap ; :
nnoremap : ;

" Allow for easier escaping
inoremap jj <Esc>

" Remap Tab to %
map <BS> %

" Toggle fold
nnoremap <leader><space> za

" Toggle hlsearch for current results
nnoremap <leader>h :nohlsearch<CR>

" Search for trailing whitespace
nnoremap <leader>w /\s\+$<CR>

" Toggle last active bufer
nnoremap <leader><Tab> :b#<CR>

" Delete a buffer without closing the window
nnoremap <leader>d :bp<bar>sp<bar>bn<bar>bd<CR>

" Remember selection when indenting
vnoremap > >gv
vnoremap < <gv

" Better movement over wrapped lines
nnoremap j gj
nnoremap k gk

" Paste mode for terminals
nnoremap <leader>P :set invpaste paste?<CR>
vnoremap <leader>y y:call ClipboardYank()<cr>
vnoremap <leader>d d:call ClipboardYank()<cr>
nnoremap <leader>p :call ClipboardPaste()<cr>p

" Quick save
nnoremap <leader>s :w<CR>

" Shortcut for Tabularize
vnoremap <leader>t :Tabularize /

" Check file for errors
nnoremap <leader>c :SyntasticCheck<CR>

" Show Quickfix window for Syntastic errors
nnoremap <leader>e :Errors<CR>

" Unite.vim
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async<CR>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<CR>
nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer  -start-insert buffer<CR>
nnoremap <leader>/ :<C-u>Unite -no-split -buffer-name=buffer  -start-insert grep:.<CR>

" Vimfiler
nnoremap <leader><space> :VimFilerExplorer<CR>

" Keep search pattern at the center of the screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz

"}}}

"{{{ Plugin Settings
" -----------------------------------------------------------------------------

" Airline
"let g:airline_powerline_fonts=1
"set laststatus=2
"set ttimeoutlen=50

" clighter
" let g:clighter_libclang_file = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
" let g:clighter_highlight_blacklist = ['clighterNamespaceRef', 'clighterFunctionDecl', 'clighterFieldDecl', 'clighterDeclRefExprCall', 'clighterMemberRefExprCall', 'clighterMemberRefExprVar', 'clighterNamespace', 'clighterNamespaceRef', 'cligherInclusionDirective', 'clighterVarDecl']

" indentLine
let g:indentLine_color_term = 10 
let g:indentLine_char = '│'

" Notes
let g:notes_directories = ['/home/dave/notes']

" Lightline
let g:lightline={
    \ 'colorscheme': 'solarized',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'readonly': 'LightLineReadOnly',
    \   'fugitive': 'LightLineFugitive'
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
    \ }
set laststatus=2

" " Syntastic
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '!'

" VimFiler
let g:vimfiler_as_default_explorer = 1

" Unite
let g:unite_source_history_yank_enable = 1
let g:unite_source_grep_max_candidates = 200

" Let's use ag
let g:unite_source_rec_async_command =
\ 'ag --follow --nocolor --nogroup --hidden -g ""'
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
\ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
\  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  " Reload directory contents
  imap <buffer> <C-r>   <Plug>(unite_redraw)
endfunction

"}}}

"{{{ Functions
" -----------------------------------------------------------------------------

function! ClipboardYank()
  call system('pbcopy', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('pbpaste')
endfunction

function! LightLineReadOnly()
    return &ft !~? 'help\|vimfiler' && &readonly ? "\ue0a2" : ""
endfunction

function! LightLineFugitive()
    if &ft !~? 'vimfiler' && exists("*fugitive#head")
        let _ = fugitive#head()
        return strlen(_) ? "\ue0a0 "._ : ""
    endif
    return ''
endfunction

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

"}}}

"{{{ Autocommands
" -----------------------------------------------------------------------------

" Indent rules
autocmd FileType markdown setlocal ts=4 sw=4 sts=4 tw=79

" Folding rules
autocmd FileType coffee setlocal foldmethod=indent nofoldenable

" Silverstripe
au BufNewFile,BufRead *.ss setfiletype xhtml

" JSON
au BufRead,BufNewFile *.json setfiletype json

" restore cursor
augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

"}}}
