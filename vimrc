" ------------------------------------------------------------------------------
" Plugins

call plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug '~/.fzf'
Plug 'rust-lang/rust.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

Plug 'Shougo/echodoc.vim'
Plug 'preservim/tagbar'
Plug 'flazz/vim-colorschemes'
Plug 'milkypostman/vim-togglelist'
Plug 'kana/vim-altercmd'

call plug#end()

" ------------------------------------------------------------------------------
" General

set nocompatible
filetype plugin indent on
syntax on
syntax enable
cabbrev e tabedit
set foldmethod=syntax
set foldlevel=20

" System clipboard
if $TMUX == ''
  set clipboard=unnamed
endif

set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set mouse=a
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F10>
set ttyfast
set noshowmode
set t_Co=256
colorscheme gruvbox
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes

" ------------------------------------------------------------------------------
" Autocomplete
" set completeopt+=noinsert
" set completeopt+=noselect
" set completeopt-=preview

let g:deoplete#enable_at_startup = 0
" Don't truncate
" let g:deoplete#max_abbr_width = 0
" let g:deoplete#max_menu_width = 0
" let g:deoplete#max_info_width = 0
" call deoplete#custom#source('_', 'max_abbr_width', 0)
" call deoplete#custom#source('_', 'max_info_width', 0)
" call deoplete#custom#source('_', 'max_menu_width', 0)
" " Sort matches alphabetically
" call deoplete#custom#source('_', 'sorters', ['sorter_word'])
" " Disable shorter or equal length matches
" call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy', 'matcher_length'])
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" " Ctrl-space for manual autocomplete window
" inoremap <silent> <C-Space> <C-X><C-O>

let g:echodoc#enable_at_startup = 1
let b:echodoc_enabled = 1
let g:echodoc#type = 'virtual_lines'

" ------------------------------------------------------------------------------
" Mappings

let mapleader=","

nnoremap <Leader>r :source ~/.vimrc<CR>:echo "Reloaded vimrc."<CR>

imap jk <Esc>
nnoremap ; :
nnoremap Y y$

" toggle list
nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>
nnoremap <leader>w :lnext<CR>
nnoremap <leader>W :lprev<CR>
let g:toggle_list_copen_command = "copen"

" Strip trailing whitespace
nnoremap <Leader>z :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Easier split switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

vmap <Leader>a= :Tabularize /=
vmap <Leader>a: :Tabularize /:

" fzf
nnoremap <Leader>e :GFiles<CR>
nnoremap <Leader>f :Buffers<CR>
nnoremap <Leader>; :Commands<CR>
nnoremap <Leader>l :Lines<CR>

" buffers
nnoremap <Leader>T :bp<CR>
nnoremap <Leader>t :bn<CR>

" Toggle pastemode with F2
set pastetoggle=<F2>

" typos
command W w
command Q q
command WQ wq
command Wq wq

" turn off hlsearch
nmap <silent> <Leader><SPACE> :nohlsearch<CR>

" Nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>

" Syntastic
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol = '✖'
let g:syntastic_warning_symbol = '▲'
let g:syntastic_style_warning_symbol = '▲'
let g:syntastic_style_error_symbol = '▲'
let g:syntastic_auto_jump = 3
let g:syntastic_always_populate_location_list = 0
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" Airline
set laststatus=2 " statusline with one file
set encoding=utf-8
let g:airline#extensions#tabline#enabled = 1 " top bar
let g:airline#extensions#tabline#fnamemod = ':t' " just show filename
let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme = "deus"
let g:airline_powerline_fonts = 1
let g:airline_detect_paste=1

" Ack
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack!
cnoreabbrev aG Ack!
cnoreabbrev Ag Ack!
cnoreabbrev AG Ack!
" nnoremap <Leader>s :Ack! -Q "<cword>"<CR>

" ------------------------------------------------------------------------------
" Visual

set cursorline
set fillchars=vert:│

" Enable transparent background (let's terminal colors take precedence)
hi Normal guibg=NONE ctermbg=NONE
hi SpellBad ctermbg=NONE
"
" augroup BlendVertSplit
"   autocmd!
"   autocmd ColorScheme * highlight VertSplit cterm=NONE ctermbg=NONE guibg=NONE
" augroup END

" ------------------------------------------------------------------------------
" Editing

" TODO: Use editorconfig
set expandtab

set shiftwidth=2
set softtabstop=2
set tabstop=2
set shiftwidth=2

" C++ options
set cino+=N-s
set cino+=g0

" ------------------------------------------------------------------------------
" Tagbar
nnoremap <silent> <Leader>h :TagbarToggle<CR>
" nnoremap <silent> <Leader>h :TagbarShowTag<CR>
let g:tagbar_width = max([25, winwidth(0) / 3])
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_help_visibility = 1
let g:tagbar_show_data_type = 1

" ------------------------------------------------------------------------------
" Ctags
" autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
" autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" ------------------------------------------------------------------------------
" Rust
autocmd BufRead *.rs setlocal filetype=rust
let g:rustfmt_autosave = 0

" ------------------------------------------------------------------------------
" COC

function! GoToDef()
  let dotag = &tagstack && exists('*gettagstack') && exists('*settagstack')
  if dotag
    let from = [bufnr('%'), line('.'), col('.'), 0]
    let tagname = expand('<cword>')
    let stack = gettagstack()
    if stack.curidx > 1
      let stack.items = stack.items[0:stack.curidx-2]
    else
      let stack.items = []
    endif
    let stack.items += [{'from': from, 'tagname': tagname}]
    let stack.curidx = len(stack.items)
    call settagstack(win_getid(), stack)
  endif
  call CocAction('jumpDefinition')
  if dotag
    let curidx = gettagstack().curidx + 1
    call settagstack(win_getid(), {'curidx': curidx})
  endif
endfunction

function! GoToReferences()
  let dotag = &tagstack && exists('*gettagstack') && exists('*settagstack')
  if dotag
    let from = [bufnr('%'), line('.'), col('.'), 0]
    let tagname = expand('<cword>')
    let stack = gettagstack()
    if stack.curidx > 1
      let stack.items = stack.items[0:stack.curidx-2]
    else
      let stack.items = []
    endif
    let stack.items += [{'from': from, 'tagname': tagname}]
    let stack.curidx = len(stack.items)
    call settagstack(win_getid(), stack)
  endif
  call CocAction('jumpReferences')
  if dotag
    let curidx = gettagstack().curidx + 1
    call settagstack(win_getid(), {'curidx': curidx})
  endif
endfunction

function! GoToTypeDefinition()
  let dotag = &tagstack && exists('*gettagstack') && exists('*settagstack')
  if dotag
    let from = [bufnr('%'), line('.'), col('.'), 0]
    let tagname = expand('<cword>')
    let stack = gettagstack()
    if stack.curidx > 1
      let stack.items = stack.items[0:stack.curidx-2]
    else
      let stack.items = []
    endif
    let stack.items += [{'from': from, 'tagname': tagname}]
    let stack.curidx = len(stack.items)
    call settagstack(win_getid(), stack)
  endif
  call CocAction('jumpTypeDefinition')
  if dotag
    let curidx = gettagstack().curidx + 1
    call settagstack(win_getid(), {'curidx': curidx})
  endif
endfunction

function! GoToImplementation()
  let dotag = &tagstack && exists('*gettagstack') && exists('*settagstack')
  if dotag
    let from = [bufnr('%'), line('.'), col('.'), 0]
    let tagname = expand('<cword>')
    let stack = gettagstack()
    if stack.curidx > 1
      let stack.items = stack.items[0:stack.curidx-2]
    else
      let stack.items = []
    endif
    let stack.items += [{'from': from, 'tagname': tagname}]
    let stack.curidx = len(stack.items)
    call settagstack(win_getid(), stack)
  endif
  call CocAction('jumpImplementation')
  if dotag
    let curidx = gettagstack().curidx + 1
    call settagstack(win_getid(), {'curidx': curidx})
  endif
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

augroup cocgroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType rust,typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent> gd         :call GoToDef()<CR>
nnoremap <silent> <leader>gr <Plug>(coc-rename)
nnoremap <silent> <leader>gR <Plug>(coc-refactor)
nnoremap <silent> <leader>gt :call GoToTypeDefinition()<CR>
nnoremap <silent> <leader>s  :call GoToReferences()<CR>
nnoremap <silent> <leader>i  :call GoToImplementation()<CR>
nnoremap <silent> K          :call <SID>show_documentation()<CR>

xmap <leader>ga <Plug>(coc-codeaction-selected)
nmap <leader>ga <Plug>(coc-codeaction-selected)
nmap <leader>gg <Plug>(coc-codeaction-cursor)
nmap <leader>qf <Plug>(coc-fix-current)

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

command SplitTerm split | b#

if has('nvim')
  augroup TermSplit
    autocmd!
    autocmd TermOpen term://*cargo* SplitTerm
  augroup end
endif
