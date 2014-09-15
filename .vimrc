set nocompatible

"{{{General
filetype plugin indent on
syntax enable
set number
set autoindent
set cindent
set ruler
set ignorecase
set showmatch
set incsearch
"}}}

"{{{Color Schemes
" Color scheme and adjustments
colorscheme jellybeans
" colorscheme solarized
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi Operator ctermbg=NONE
hi Folded ctermbg=NONE
"}}}

"{{{Misc
" unbind arrow keys
for prefix in ['n', 'v']
	for key in ['<Up>', '<Down>', '<Left>', '<Right>']
		exe prefix . "noremap " . key . " <Nop>"
	endfor
endfor

" Set tab rules
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab

set foldmethod=marker

" no swap or backup, save it yourself
set nobackup
set nowritebackup
set noswapfile

" Status line
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [$l,%v][%p%%]
"}}}

"{{{Remap
let mapleader=","

"" Normalize for wrapped lines
map j gj
map k gk

" Easier use
nnoremap ; :
nnoremap : ;
inoremap jj <Esc>

" DOS sucks
nnoremap <silent> <F9> :%s/$//g<CR>:%s// /g<CR>

" SOrting
vnoremap <Leader>s :sort<CR>

" Indenting
vnoremap < <gv
vnoremap > >gv

" Blank newlines
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Toggle folds
nnoremap <space> za
"}}}

"{{{Pathogen
execute pathogen#infect()
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "jellybeans"
"}}}

" Highlight over 80 columns
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%121v.\+/
