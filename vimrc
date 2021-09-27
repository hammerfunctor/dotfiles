" YCM - ./install.py --clang-completer --system-libclang --rust-completer --go-completer

" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" install end


" Basic
set nocompatible      " be iMproved, required
set laststatus=2
set nu                " display line number
set langmenu=en_US
set noerrorbells
set cursorline
set scrolloff=3
set list
set listchars=tab:--
set wrap

" Statusline
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")} 
set wildmenu
set wildmode=longest,list,full

" Indentation
set tabstop=4
set expandtab
set softtabstop=4
set autoindent
set shiftwidth=4

" Fold
set foldmethod=indent " too mang codes, wrap
set foldlevel=99
set completeopt=menuone,longest,preview
"set textwidth=99

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch          " search highlight

" Edit
set showcmd
set showmode
set showmatch         " display matched bracket
"set linebreak
set report=0
set encoding=utf-8
"set spell
"set nowrap

" File
set autoread
set autowrite
set hidden
set nobackup
set fileformat=unix

" GUI
set mouse=a           " enable mouse
"set ambiwidth=double


"colorscheme monokai
colorscheme koehler
syntax on             " syntax highlight
filetype on
filetype plugin indent on


call plug#begin('~/.vim/plugged')
Plug 'luochen1990/rainbow'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'Valloric/YouCompleteMe'
Plug 'junegunn/fzf.vim'
Plug 'JuliaEditorSupport/julia-vim'
"Plug 'dpc/vim-smarttabs'
call plug#end()

" EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swo','\.swp','\.git','.DS_Store']
map <leader>n :NERDTreeTabsToggle<CR>


let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:rainbow_active = 1
"let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_add_pre_view_to_completeopt=0
let g:ycm_filepath_blacklist = {
    \ 'html': 1,
    \ 'jsx': 1,
    \ 'xml': 1,
    \}


map <F5> :call Run()<CR>
func! Run()
    exec "w"
    if &filetype == 'python'
        exec "!python %"
    elseif &filetype == 'c'
        exec "!gcc % -lm"
        exec "!./a.out"
    endif
endfunc


" Rime
au BufNewFile,BufRead *.dict.yaml set softtabstop=0 noexpandtab

" resume last closed line
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

au BufNewFile,BufRead *.rb set shiftwidth=4
