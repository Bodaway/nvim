
set background=dark

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

" Active le comportement 'habituel' de la touche retour en arriere
call plug#begin('~/.config/nvim/bundle')
Plug 'rust-lang/rust.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'racer-rust/vim-racer'
Plug 'altercation/solarized'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
"Plug 'sjbach/lusty'
Plug 'tomtom/tcomment_vim' " gc comments
Plug 'tpope/vim-surround'
Plug 'milkypostman/vim-togglelist'
Plug 'neomake/neomake', { 'for': ['rust'] }
Plug 'airblade/vim-gitgutter'
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'ionide/Ionide-vim', {
      \ 'do':  'make fsautocomplete',
      \}
call plug#end()

let g:solarized_termcolors=256
colorscheme solarized "ron

let g:rainbow_active = 1

" Activation de NERDTree au lancement de vim semble provoquer un bug avec
" gvim, le curseur deviens invisible dans le fichier.
"autocmd vimenter * NERDTree

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif 

if has('win32')
    source ~\AppData\Local\nvim\.vimrc.bepo
else
    source ~/.config/nvim/.vimrc.bepo
endif
