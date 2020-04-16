set nocompatible
execute pathogen#infect()
Helptags

syntax on
filetype plugin indent on

" Getting vim to work with latex
set grepprg=grep\ -nH\ $*
let g:tex_flavor='xelatex'
set iskeyword+=:
let g:Tex_CompileRule_pdf='xelatex --interaction=nonstopmode $*'

" SML
au Filetype sml setlocal conceallevel=2

" Limit to 16 colors
set t_Co=16

" Leader key / remaps
let mapleader = ","
inoremap jk  <Esc>

" Trailing whitespace
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Plugins
" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 3
let g:neocomplcache_max_list = 10
" let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_ignore_case = 1
set completeopt+=longest
set completeopt-=preview
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <expr><C-g>     neocomplcache#undo_completion()
" inoremap <expr><C-l>     neocomplcache#complete_common_string()
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" Airline
set laststatus=2 " statusline with one file
set encoding=utf-8
let g:airline#extensions#tabline#enabled = 1 " top bar
let g:airline#extensions#tabline#fnamemod = ':t' " just show filename
let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme = "dark"
let g:airline_powerline_fonts = 1
let g:airline_detect_paste=1
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" let g:airline_left_sep = '⮀'
" let g:airline_left_alt_sep = '⮁'
" let g:airline_right_sep = '⮂'
" let g:airline_right_alt_sep = '⮃'
" let g:airline_symbols.branch = '⭠'
" let g:airline_symbols.readonly = '⭤'
" let g:airline_symbols.linenr = '⭡'
" " Open help in a new tab
cabbrev help tab help
cabbrev e tabedit
" Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
let g:unite_source_history_yank_enable = 1
noremap <leader>f : <C-u>Unite -start-insert file<CR>
nnoremap <leader>F :<C-u>Unite -start-insert file_rec<CR>
noremap <leader>b : <C-u>Unite buffer<CR>
nnoremap <leader>y :<C-u>Unite history/yank<CR>
nnoremap <silent><leader>ll :<C-u>UniteResume<CR>
" C-g to exit
" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol = '✖'
let g:syntastic_warning_symbol = '▲'
let g:syntastic_style_warning_symbol = '▲'
let g:syntastic_style_error_symbol = '▲'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Ignore some warnings
let g:Tex_IgnoredWarnings =
    \'Underfull'."\n".
    \'Overfull'."\n".
    \'Intersentence spacing'."\n".
    \'specifier changed to'."\n".
    \'You have requested'."\n".
    \'Missing number, treated as zero.'."\n".
    \'There were undefined references'."\n".
    \'Citation %.%# undefined'."\n".
    \'Double space found.'."\n" .
    \'possible'."\n"
let g:Tex_IgnoreLevel = 10

set showcmd         " Show command sequence as entering
set ruler           " Show row / col
" set cursorline      " Show line with cursor

" Line Numbers
set number
set numberwidth=3

nmap <silent> ,<SPACE> :nohlsearch<CR>

" TABS
map <C-l> :tabnext<CR>
map <C-h> :tabprevious<CR>

" Tabs / Spacing
set nowrap          " Don't wrap lines
set tabstop=2       " Hard tabstop is 4 spaces
set shiftwidth=2    " Spaces for autoindent
set smarttab        " Use shiftwidth not tabstoset smarttab at start
set softtabstop=2   " Combination of spaces/tabs to simulate tabstops
set expandtab       " always use spaces instead of tab characters
set autoindent      " always set autoindenting on
set copyindent      " copy the previous indentation on autoindenting

set showmatch       " Show matching parentheses
set smartcase       " Ignore case if all lowercase search
set hlsearch        " Highlight search terms
set incsearch       " Show matches as search
set hlsearch        " Highlight search terms
set incsearch       " Show matches as search
set backspace=indent,eol,start  " allow backspacing over everything in insert mode

" No backups
set nobackup
set noswapfile

" Paste mode
set pastetoggle=<F2>

" Hide rather than close files in background
set hidden

" Folding
set foldmethod=indent
set foldlevel=99

" Python syntax
let python_highlight_all = 1
let python_highlight_space_errors = 0

" Toggle pastemode with F2
set pastetoggle=<F2>

" Haskell bindings
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsClear<CR>

" ---------------------------------------------------------------------
" EXTRA FUNCTIONS
" ---------------------------------------------------------------------
" Show highlighting gropus for current word
highlight SpellBad ctermbg=196
highlight SpellCAP ctermbg=226
highlight Folded ctermbg=242
highlight SignColumn ctermbg=0
highlight SyntasticErrorSign ctermfg=160
highlight SyntasticWarningSign ctermfg=226
highlight SyntasticWarningStyleSign ctermfg=226
highlight SyntasticErrorStyleSign ctermfg=226

function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

command W w
command Q q
command WQ wq
command Wq wq
