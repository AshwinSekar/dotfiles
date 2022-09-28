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

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

Plug 'Shougo/echodoc.vim'
Plug 'preservim/tagbar'
Plug 'flazz/vim-colorschemes'
Plug 'milkypostman/vim-togglelist'
Plug 'kana/vim-altercmd'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

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
colorscheme gruvbox

" ------------------------------------------------------------------------------
" Autocomplete
set completeopt+=noinsert
set completeopt+=noselect
set completeopt-=preview

let g:deoplete#enable_at_startup = 1
" Don't truncate
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#max_info_width = 0
call deoplete#custom#source('_', 'max_abbr_width', 0)
call deoplete#custom#source('_', 'max_info_width', 0)
call deoplete#custom#source('_', 'max_menu_width', 0)
" Sort matches alphabetically
call deoplete#custom#source('_', 'sorters', ['sorter_word'])
" Disable shorter or equal length matches
call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy', 'matcher_length'])
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" Ctrl-space for manual autocomplete window
inoremap <silent> <C-Space> <C-X><C-O>

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

" buffers
nnoremap <Leader>T :bp<CR>
nnoremap <Leader>t :bn<CR>

" editing source code
inoremap {<CR> {<CR><BS>}<ESC>ko
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ` ``<Esc>ha
inoremap <expr> ) getline('.')[col('.')-1]==')' ? '<C-G>U<right>' : ')'
inoremap <expr> ] getline('.')[col('.')-1]==']' ? '<C-G>U<right>' : ']'
inoremap <expr> > getline('.')[col('.')-1]=='>' ? '<C-G>U<right>' : '>'
inoremap <expr> " getline('.')[col('.')-1]=='"' ? '<C-G>U<right>' : '"'

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
" LSP
let g:LanguageClient_serverCommands = {
      \ 'rust': ['rust-analyzer'],
      \ }
let g:LanguageClient_enableExtensions = {
      \ 'rust': v:true,
      \ }
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_loggingFile = expand('~/.vim/lsp.log')
let g:LanguageClient_serverStderr = expand('~/.vim/lsp.err')
let g:LanguageClient_settingsPath = expand('~/.vim/lsp-settings.json')
let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_selectionUI = 'LOCATIONLIST'

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
  call LanguageClient#textDocument_definition()
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
  call LanguageClient#textDocument_references()
  if dotag
    let curidx = gettagstack().curidx + 1
    call settagstack(win_getid(), {'curidx': curidx})
  endif
endfunction


nnoremap gd         :call GoToDef()<CR>
nnoremap <leader>gr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>gt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>s  :call GoToReferences()<CR>
nnoremap <leader>gg :call LanguageClient#textDocument_codeAction()<CR>
nnoremap K          :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>gm :call LanguageClient_contextMenu()<CR>
nnoremap <leader><Enter> :call LanguageClient#handleCodeLensAction()<CR>

command SplitTerm split | b#

if has('nvim')
  augroup TermSplit
    autocmd!
    autocmd TermOpen term://*cargo* SplitTerm
  augroup end
endif
