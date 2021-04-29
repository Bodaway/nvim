syntax enable
filetype plugin on

set background=dark
set path+=**
set wildmenu
set wildignore+=**/node_modules/**

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set title
set number
set ruler
set wrap
set expandtab
set shiftwidth=4
set softtabstop=4

"set scrolloff=3
" -- Recherche
set ignorecase            " Ignore la casse lors d'une recherche
set smartcase             " Si une recherche contient une majuscule,
                          " re-active la sensibilite a la casse
set incsearch             " Surligne les resultats de recherche pendant la
                          " saisie
set hlsearch              " Surligne les resultats de recherche

" -- Beep
set visualbell            " Empeche Vim de beeper
set noerrorbells          " Empeche Vim de beeper

" Reload a file when it is changed from the outside
set autoread

" Write the file when we leave the buffer
set autowrite

" Disable backups, we have source control for that
set nobackup

" Force encoding to utf-8, for systems where this is not the default
set encoding=utf-8

" Disable swapfiles too
set noswapfile

" Hide buffers instead of closing them
set hidden

""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: At some point I'll need to switch over to the native Vim 8.0 package
" feature. Either via manual git subtree management, or maybe through minpac?
"
" Install vim-plug if we don't already have it
" Credit to github.com/captbaritone
"if empty(glob("~/.vim/autoload/plug.vim"))
" Ensure all needed directories exist  (Thanks @kapadiamush)
"    execute 'mkdir -p ~/.vim/plugged'
"    execute 'mkdir -p ~/.vim/autoload'
" Download the actual plugin manager
"    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
"endif

call plug#begin('~/.config/nvim/bundle')

Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' }
Plug 'altercation/solarized'
Plug 'itchyny/lightline.vim'

" Bag of mappings
Plug 'tpope/vim-surround'
"Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdcommenter'
"Plug 'romainl/vim-qf'

"Plug 'honza/vim-snippets'

" Navigation
"Plug 'tpope/vim-vinegar'
"Plug 'ctrlpvim/ctrlp.vim' " TODO: I don't really use that anymore.
"Plug 'mileszs/ack.vim'

" Theming
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" Tag management
"Plug 'ludovicchabant/vim-gutentags'

Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'

" 'IDE' features
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-dispatch'
"Plug 'janko/vim-test'
"Plug 'pangloss/vim-javascript'    " JavaScript support
"Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'OmniSharp/omnisharp-vim'

call plug#end()

" CoC extensions
if has('win32')
    source ~\AppData\Local\nvim\.vimrc.coc
else
    source ~/.config/nvim/.vimrc.coc
endif

let g:solarized_termcolors=256
colorscheme nord "ron
let g:rainbow_active = 1


let mapleader = "ê"


if has('win32')
    source ~\AppData\Local\nvim\.vimrc.bepo
else
    source ~/.config/nvim/.vimrc.bepo
endif
