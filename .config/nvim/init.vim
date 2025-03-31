" Plugins

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
"Plug 'cohama/lexima.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'  }
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'mhartington/formatter.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'windwp/nvim-ts-autotag'
Plug 'dart-lang/dart-vim-plugin'
Plug 'rose-pine/neovim', { 'as': 'rose-pine' }
Plug 'christoomey/vim-tmux-navigator'
"Plug 'sainnhe/gruvbox-material'
"Plug 'rebelot/kanagawa.nvim'
Plug 'github/copilot.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
"Plug 'ramojus/mellifluous.nvim'
"Plug 'zenbones-theme/zenbones.nvim'
Plug 'rktjmp/lush.nvim'
"Plug 'savq/melange-nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'stevearc/oil.nvim'

call plug#end()

" Fundamentals "{{{
" ---------------------------------------------------------------------

" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

set nocompatible
set relativenumber number
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set nobackup
set hlsearch
set showcmd
set cmdheight=1
set winbar=%f
set laststatus=2
set scrolloff=10
set expandtab
"let loaded_matchparen = 1
set shell=zsh
set backupskip=/tmp/*,/private/tmp/*

" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

set nosc noru nosm
" Don't redraw while executing macros (good performance config)
set lazyredraw
"set showmatch
" How many tenths of a second to blink when matching brackets
"set mat=2
" Ignore case when searching
set ignorecase
" Be smart when using tabs ;)
set smarttab
" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines
set mouse= "disable mouse
set backspace=start,eol,indent
" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

" Open new windows on right and bottom side
set splitbelow
set splitright

" nvim-cmp
set completeopt=menu,menuone,noselect

let mapleader = " " " map leader to space

"}}}

" Highlights "{{{
" ---------------------------------------------------------------------
"set cursorline
"set cursorcolumn
set guicursor=i:block

" Set cursor line color on visual mode
"highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

"highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif

"}}}

" File types "{{{
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mdx set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

"Global keybindings
"
"Runs python file
autocmd FileType python map <buffer><leader>pp :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

nnoremap <silent>+ :vertical resize +5<CR>
nnoremap <silent>- :vertical resize -5<CR>
nnoremap <silent>[ :resize -5<CR>
nnoremap <silent>] :resize +5<CR>
" nnoremap <silent><leader>ve :Vex<CR>
" nnoremap <silent><leader>ee :Exp<CR>
" nnoremap <silent><leader>he :Sex<CR>
nnoremap <silent><leader>,m :G mergetool<CR>
nnoremap <silent><leader>,b :G blame<CR>
nnoremap <silent><leader>,s :Gvdiffsplit!<CR>
nnoremap <silent><leader>,h :diffget //2<CR>
nnoremap <silent><leader>,l :diffget //3<CR>
nnoremap <silent><leader>lr :LspRestart<CR>
nnoremap <silent><leader>cab :bufdo bw<CR>

" Quickfix lists
function! ToggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction

" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction

:command! RemoveQFItem :call RemoveQFItem()
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>

nnoremap <silent> <leader>qt :call ToggleQuickFix()<CR>
nnoremap <silent> <leader>qn :cnext<CR>
nnoremap <silent> <leader>qp :cprevious<CR>
nnoremap <silent> <leader>qf :cfirst<CR>
nnoremap <silent> <leader>ql :clast<CR>
nnoremap <silent> <leader>qc :call setqflist([])<CR>
nnoremap <silent> <leader>qr <cmd>exe 'Cfilter! ' .. matchstr(getline('.'), '.\{-}\ze<bar>')<CR>
"

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nnoremap <silent> <buffer> <c-l> :TmuxNavigateRight<CR>
endfunction

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap J mzJ`z

" Theme

if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set background=dark
  highlight Normal     ctermbg=NONE guibg=NONE
  highlight LineNr     ctermbg=NONE guibg=NONE
  highlight SignColumn ctermbg=NONE guibg=NONE
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
