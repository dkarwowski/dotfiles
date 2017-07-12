" Welcome to Vim (http://go/vim).
"
" If you see this file, your homedir was just created on this workstation.
" That means either you are new to Google (in that case, welcome!) or you
" got yourself a faster machine.
" Either way, the main goal of this configuration is to help you be more
" productive; if you have ideas, praise or complaints, direct them to
" vi-users@google.com (http://g/vi-users). We'd especially like to hear from you
" if you can think of ways to make this configuration better for the next
" Noogler.
" If you want to learn more about Vim at Google, see http://go/vimintro.

" Use the 'google' package by default (see http://go/vim/packages).
source /usr/share/vim/google/google.vim
source /usr/share/vim/google/gtags.vim

nnoremap <C-]> :exe 'let searchtag= "' . expand('<cword>') . '"' \| :exe 'let @/= "' . searchtag . '"'<CR> \| :exe 'Gtlist ' . searchtag <CR>

" Plugin configuration.
" See http://google3/devtools/editors/vim/examples/ for example configurations
" and http://go/vim/plugins for more information about vim plugins at Google.

" Plugin loading is commented out below - uncomment the plugins you'd like to
" load.

" Load Grok to handle proper jumping around google3.
" Handles this by relationships (references, definitions, declarations, call
" stack) to easily navigate usage of a function.
" Seems better than Gtags...
Glug grok

" Load google's formatting plugins (http://go/vim/plugins/codefmt-google).
" The default mapping is \= (or <leader>= if g:mapleader has a custom value),
" with
" - \== formatting the current line or selected lines in visual mode
"   (:FormatLines).
" - \=b formatting the full buffer (:FormatCode).
"
" To bind :FormatLines to the same key in insert and normal mode, add:
"   noremap <C-K> :FormatLines<CR>
"   inoremap <C-K> <C-O>:FormatLines<CR>
Glug codefmt plugin[mappings] gofmt_executable="goimports"
Glug codefmt-google

" Enable autoformatting on save for the languages at Google that enforce
" formatting, and for which all checked-in code is already conforming (thus,
" autoformatting will never change unrelated lines in a file).
"augroup autoformat_settings
"  " For BUILD files and Go all of Google's files must be formatted.
"  autocmd FileType bzl AutoFormatBuffer buildifier
"  autocmd FileType go AutoFormatBuffer gofmt
"augroup END

" Load YCM (http://go/ycm) for semantic auto-completion and quick syntax
" error checking. Pulls in a google3-enabled version of YCM itself and
" a google3-specific default configuration.
"Glug youcompleteme-google

" Load the automated blaze dependency integration for Go.
" Note: for Go, blazedeps uses the Go team's glaze tool, which is fully
" supported by the Go team; for other languages. Note that the plugin is
" currently unsupported for other languages.
"Glug blazedeps auto_filetypes=`['go']`

" Load piper integration (http://wiki/Main/VimPerforce).
Glug piper plugin[mappings]

" Load the Critique integration. Use :h critique for more details.
"Glug critique plugin[mappings]

" Load blaze integration (http://go/blazevim).
Glug blaze plugin[mappings]

" Load the syntastic plugin (http://go/vim/plugins/syntastic-google).
" Note: this requires installing the upstream syntastic plugin from
" https://github.com/scrooloose/syntastic.
"Glug syntastic-google

" Load the ultisnips plugin (http://go/ultisnips).
" Note: this requires installing the upstream ultisnips plugin from
" https://github.com/SirVer/ultisnips.
"Glug ultisnips-google

" All of your plugins must be added before the following line.

" -- Non-Google plugins
if has('vim_starting')
  set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
endif

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')

" Themes
call dein#add('itchyny/lightline.vim')
call dein#add('chriskempson/base16-vim')
call dein#add('daviesjamie/vim-base16-lightline')

" Extensions
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler.vim')
call dein#add('easymotion/vim-easymotion')
call dein#add('vim-scripts/taglist.vim')

" Editing
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-surround')
call dein#add('godlygeek/tabular')

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
"set expandtab            " replace tabs with spaces
"set shiftwidth=4         " spaces for autoindenting
"set softtabstop=4        " spaces for editing, e.g. <Tab> or <BS>
"set tabstop=4            " spaces for <Tab>

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
