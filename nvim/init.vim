filetype plugin on
lua require('basic')
lua require('kbd')

" resume last closed line
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

" Rime
au BufNewFile,BufRead *.dict.yaml set softtabstop=0 noexpandtab

call plug#begin('~/.vim/plugged')
Plug 'Yggdroot/indentLine'
" Plug 'projekt0n/github-nvim-theme'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdcommenter'
Plug 'luochen1990/rainbow'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'JuliaEditorSupport/julia-vim'
Plug 'voldikss/vim-mma'
Plug 'zah/nim.vim'
"Plug 'rsmenon/vim-mathematica.git'
call plug#end()


fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i

" lua << EOF
" require("github-theme").setup({
"   themeStyle = "dark",
"   functionStyle = "italic",
"   sidebars = {"qf", "vista_kind", "terminal", "packer"},

"   -- Change the "hint" color to the "orange" color, and make the "error" color bright red
"   colors = {hint = "orange", error = "#ff0000"}
" })
" EOF

" onedark theme
"source $HOME/.config/nvim/themes/onedark.vim
"
"colorscheme default
"colorscheme delek
"colorscheme desert
colorscheme elflord
colorscheme evening
colorscheme industry
colorscheme koehler
"colorscheme morning
colorscheme murphy
colorscheme pablo
"colorscheme peachpuff
"colorscheme ron
"colorscheme shine
colorscheme slate
colorscheme torte
"colorscheme zellner


" indentLine
" let g:indent_guides_guide_size = 1	" indent line size
" let g:indent_guides_start_level = 2	" indent from the second level

" powerline
let g:airline_enable_hunks = 0
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
" status bar
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme = 'desertink'  " 主题
let g:airline#extensions#keymap#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {
       \ '0': '0 ',
       \ '1': '1 ',
       \ '2': '2 ',
       \ '3': '3 ',
       \ '4': '4 ',
       \ '5': '5 ',
       \ '6': '6 ',
       \ '7': '7 ',
       \ '8': '8 ',
       \ '9': '9 '
       \}
" <leader> + i -> switch to i th tab
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
" <leader> + (+ | -) -> switch to previous or next tab
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
" <leader> + q -> quit tab
nmap <leader>q :bp<cr>:bd #<cr>

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = "CL" " current line
let g:airline_symbols.whitespace = '|'
let g:airline_symbols.maxlinenr = 'Ml' "maxline
let g:airline_symbols.branch = 'BR'
let g:airline_symbols.readonly = "RO"
let g:airline_symbols.dirty = "DT"
let g:airline_symbols.crypt = "CR" 

let g:rainbow_active = 1

