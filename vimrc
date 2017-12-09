" -- Non-Google plugins
if has('vim_starting')
  set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
endif

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')

" Themes
call dein#add('itchyny/lightline.vim')
call dein#add('chriskempson/base16-vim')
call dein#add('dkarwowski/vim-base16-lightline')

" Extensions
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler.vim')
call dein#add('easymotion/vim-easymotion')
call dein#add('vim-scripts/taglist.vim')
call dein#add('tpope/vim-fugitive')

" Editing
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-surround')
call dein#add('godlygeek/tabular')

" Languages
call dein#add('fatih/vim-go')

call dein#end()

" Enable file type based indent configuration and syntax highlighting.
" Note that when code is pasted via the terminal, vim by default does not detect
" that the code is pasted (as opposed to when using vim's paste mappings), which
" leads to incorrect indentation when indent mode is on.
" To work around this, use ":set paste" / ":set nopaste" to toggle paste mode.
" You can also use a plugin to:
" - enter insert mode with paste (https://github.com/tpope/vim-unimpaired)
" - auto-detect pasting (https://github.com/ConradIrwin/vim-bracketed-paste)
filetype plugin indent on
syntax on

if dein#check_install()
  call dein#install()
endif

"{{{ Settings
" -----------------------------------------------------------------------------

" General
set completeopt-=preview " don't show preview window
set fcs=vert:│,fold:-    " solid instead of broken line for vert splits
set hidden               " hide when switching buffers, don't unload
set lazyredraw           " don't update screen when executing macros
set mouse=a              " enable mouse in all modes
set number               " show absolute line number on current line
set relativenumber       " show relatively around
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
"set foldignore=          " don't ignore anything when folding
"set foldlevelstart=99    " no folds closed on open
"set foldmethod=marker    " collapse code using markers

" Tabs
set expandtab            " replace tabs with spaces
set shiftwidth=2         " spaces for autoindenting
set softtabstop=2        " spaces for editing, e.g. <Tab> or <BS>
set tabstop=2            " spaces for <Tab>

" Searches
set hlsearch             " highlight search results
set incsearch            " incremental search as you type
set ignorecase           " case insensitive searching
set smartcase            " override ignorecase if upper case typed

" Colours
" colorscheme termorrow
syntax enable
"let base16colorspace=256
set background=dark
colorscheme base16-default-dark

" Font
if has('gui_running')
    set guifont=Fantasque_Sans_Mono:h11
endif

" Status line
hi StatusLine ctermbg=11 ctermfg=0
set statusline=\ \      " blank space
set statusline+=\ \     " blank space
set statusline+=%f      " Path to the file in the buffer
set statusline+=%m      " Modified flag
set statusline+=%5{v:register} "Which active register
set statusline+=%=      " Align to the right from now on
"set statusline+=[%{fugitive#head()}]   " Current branch
set statusline+=\ \     " Blank space
set statusline+=%y      " Type of file in the buffer
set statusline+=%5l     " Current line
set statusline+=,       " Comma
set statusline+=%c      " Current Column
set statusline+=/       " Slash
set statusline+=%-5L    " Total lines
set statusline+=%p%%    " Percentage through the file

"}}}

"{{{ Mapping
" -----------------------------------------------------------------------------

" Map Leader
let mapleader = " "

" Tags search goes up
set tags+=tags;$HOME

" Allow for easier escaping
inoremap jj <Esc>

" Search for trailing whitespace
"nnoremap <leader>t :%s/\s\+$//<CR>

" Toggle last active bufer
"nnoremap <leader><Tab> :b#<CR>

" Delete a buffer without closing the window
"nnoremap <leader>d :bp<bar>sp<bar>bn<bar>bd<CR>

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

" Keep search pattern at the center of the screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz

"SILENCE!
set t_vb=

"}}}

"{{{ Plugin Settings
" -----------------------------------------------------------------------------

" Lightline
let g:lightline={
    \ 'colorscheme': 'base16',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'readonly': 'LightLineReadOnly'
    \ },
    \ 'separator': { 'left': "", 'right': "" },
    \ 'subseparator': { 'left': "│", 'right': "│" }
    \ }
"    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
"    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
set laststatus=2

" VimFiler
let g:vimfiler_as_default_explorer = 1

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

" Go
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

"}}}

"{{{ Functions
" -----------------------------------------------------------------------------

function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

function! LightLineReadOnly()
    return &ft !~? 'help\|vimfiler' && &readonly ? "\ue0a2" : ""
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

" restore cursor
augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

"}}}
