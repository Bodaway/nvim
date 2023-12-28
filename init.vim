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

set autoread

if has('win32')
    source ~\AppData\Local\nvim\.vimrc.bepo
else
    source ~/.config/nvim/.vimrc.bepo
endif

inoremap <C-x><C-o> <Cmd>lua require('cmp').complete()<CR>
lua require('plugins')
