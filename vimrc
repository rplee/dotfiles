" Turn on syntax highlighting.
syntax on

" New lines inherit the indentation of previous lines.
set autoindent

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" Ignore included files in tab completion.
set complete-=i

" Enable hidden buffers.
set hidden

" Include more history
set history=8192

" Highlight all search matches
set hlsearch

" Make search case-insensitive when all characters in the string being searched
" are lowercase, and case-sensitive if string contains any capital letters.
set ignorecase smartcase

" Enable incremental searching (eg. show partial matches as you type).
set incsearch

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But it's included here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Disable audible bell
set noerrorbells visualbell t_vb=

" Do not show mode (lightline plugin already shows mode)
set noshowmode

" Show line numbers. Enable relative line numbering mode.
set number relativenumber

" Enable mouse support
set mouse+=a

" Disable the default Vim startup message.
set shortmess+=I

"Enhance command line completion
set wildmenu

" Unbind some useless default key bindings. 'Q' in normal mode enters Ex mode.
nmap Q <Nop> 

" Automatically install vim-plug if it is not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Add vim-plug plugins
call plug#begin('~/.vim/plugged')

" Add plugin for git
Plug 'tpope/vim-fugitive'

" Add status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Integrate fzf with vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Navigate and manipulate files in a tree view
Plug 'scrooloose/nerdtree'

" Use the vim-one color scheme
Plug 'rakr/vim-one'

" Improve syntax highlighting for languages
Plug 'sheerun/vim-polyglot'

call plug#end()

" Set color scheme
colorscheme one
set background=dark

" Set airline color scheme
let g:airline_theme='onedark'

" Automatically display all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" Nerdtree configuration
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
