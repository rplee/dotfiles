" VI compatible mode is disabled so that VIm things work
set nocompatible

" vim can autodetect this based on $TERM (e.g. 'xterm-256color')
" but it can be set to force 256 colors
" set t_Co=256
if has('gui_running')
    colorscheme onedark
else
    colorscheme default
    set nocursorline " looks bad in this mode
endif

" SETTINGS
" Turn on syntax highlighting
syntax on

" Use an encoding that supports utf-8
set encoding=utf-8

" New lines inherit the indentation of previous lines
set autoindent

" Set tabs to be 4 spaces
set shiftwidth=4 softtabstop=4 expandtab

" Backspace over anything
set backspace=indent,eol,start

" Ignore included files in tab completion
set complete-=i

" Enable hidden buffers
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

" Enable mouse support
set mouse+=a

" Disable audible bell
set noerrorbells visualbell t_vb=

" Do not show mode
set noshowmode

" Show line numbers. Enable relative line numbering mode.
set number relativenumber

" Disable the default Vim startup message.
set shortmess+=I

"Enhance command line completion
set wildmenu
set wildmode=list:longest,full

" MAPPINGS
" Unbind some useless default key bindings. 'Q' in normal mode enters Ex mode.
nmap Q <Nop>

" Allow FZF.vim to select or deselect all search results using Alt-a and ALt-d
execute "set <M-a>=\ea"
noremap <M-a> <Esc>a
"execute set <A-d>=\ed"
"tnoremap <A-d> <Esc>d

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors)
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" Source Vim config file
map <Leader>sv :source $MYVIMRC<CR>

" PLUGINS
" Enable loading the plugin files for specific file types
filetype plugin on

" Enhances the % command to jump between HTML tags, if/else/endif in Vim
" scripts, and more
runtime macros/matchit.vim

" Automatically install vim-plug if it is not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Add vim-plug plugins
call plug#begin()

" Use vim color scheme
Plug 'joshdick/onedark.vim'

" Add status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Better navigation of directories
Plug 'scrooloose/nerdtree'

" Improve syntax highlighting for many languages
Plug 'sheerun/vim-polyglot'

" Better display of unwanted whitespace
Plug 'ntpeters/vim-better-whitespace'

" Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Surround text with quotes, parenthesis, brackets, and more.
Plug 'tpope/vim-surround'

" Pairs of handy bracket mappings, such as for navigating buffers, scrolling
" through the argument, quickfix, location, and tag lists, and more.
Plug 'tpope/vim-unimpaired'

" Repeat non-native commands used by supported plugins such as vim-surround
Plug 'tpope/vim-repeat'

" Toggle comments in various ways
Plug 'tpope/vim-commentary'

" Work with several variant of a word at once and change cases easily
Plug 'tpope/vim-abolish'

" Integrate fzf with vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Modify * to also work with visual selection
Plug 'nelstrom/vim-visual-star-search'

" Automatically clear search highlights after you move your cursor
Plug 'haya14busa/is.vim'

" Easier navigation
Plug 'easymotion/vim-easymotion'

call plug#end()

" PLUGIN CONFIGURATIONS
" Set color scheme
colorscheme onedark

" Set status line color scheme
let g:airline_theme='onedark'

" Automatically display all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" Nerdtree configuration (<Leader> is \ by default)
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

" Enable FZF to search for strings within hidden files
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case '.(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
