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

Plug 'honza/vim-snippets'

" Navigation
"Plug 'tpope/vim-vinegar'
"Plug 'ctrlpvim/ctrlp.vim' " TODO: I don't really use that anymore.
"Plug 'mileszs/ack.vim'

" Theming
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" Tag management
Plug 'ludovicchabant/vim-gutentags'

Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'

" 'IDE' features
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-dispatch'
"Plug 'janko/vim-test'

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'


Plug 'kien/ctrlp.vim'
Plug 'OmniSharp/omnisharp-vim'

" Mappings, code-actions available flag and statusline integration
Plug 'nickspoons/vim-sharpenup'

" Linting/error highlighting
Plug 'dense-analysis/ale'

" Vim FZF integration, used as OmniSharp selector
"Plug 'junegunn/fzf'
"Plug 'junegunn/fzf.vim'

" Autocompletion
"Plug 'prabirshrestha/asyncomplete.vim'

" Statusline
Plug 'maximbaz/lightline-ale'

" Snippet support
"if s:using_snippets
  "Plug 'sirver/ultisnips'
"endif

Plug 'carlsmedstad/vim-bicep'

call plug#end()

" CoC extensions
if has('win32')
    source ~\AppData\Local\nvim\.vimrc.coc
else
    source ~/.config/nvim/.vimrc.coc
endif

" CoC extensions
if has('win32')
    source ~\AppData\Local\nvim\.vimrc.omnisharp
else
    source ~/.config/nvim/.vimrc.omnisharp
endif


let g:solarized_termcolors=256
colorscheme nord "ron
let g:rainbow_active = 1


let mapleader = "$"
nnoremap <leader>a <C-]>
inoremap <C-n> <C-x><C-o>

let g:ctrlp_cmd = 'cp'
 let g:ctrlp_prompt_mappings = {
    \ 'PrtBS()':              ['<bs>', '<c-]>'],
    \ 'PrtDelete()':          ['<del>'],
    \ 'PrtDeleteWord()':      ['<c-w>'],
    \ 'PrtClear()':           ['<c-u>'],
    \ 'PrtSelectMove("j")':   ['<c-t>', '<down>'],
    \ 'PrtSelectMove("k")':   ['<c-s>', '<up>'],
    \ 'PrtSelectMove("t")':   ['<Home>', '<kHome>'],
    \ 'PrtSelectMove("b")':   ['<End>', '<kEnd>'],
    \ 'PrtSelectMove("u")':   ['<PageUp>', '<kPageUp>'],
    \ 'PrtSelectMove("d")':   ['<PageDown>', '<kPageDown>'],
    \ 'PrtHistory(-1)':       ['<c-n>'],
    \ 'PrtHistory(1)':        ['<c-p>'],
    \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
    \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-u>'],
    \ 'AcceptSelection("t")': ['<c-è>'],
    \ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>'],
    \ 'ToggleFocus()':        ['<s-tab>'],
    \ 'ToggleRegex()':        ['<c-r>'],
    \ 'ToggleByFname()':      ['<c-d>'],
    \ 'ToggleType(1)':        ['<c-f>', '<c-up>'],
    \ 'ToggleType(-1)':       ['<c-b>', '<c-down>'],
    \ 'PrtExpandDir()':       ['<tab>'],
    \ 'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
    \ 'PrtInsert()':          ['<c-\>'],
    \ 'PrtCurStart()':        ['<c-a>'],
    \ 'PrtCurEnd()':          ['<c-e>'],
    \ 'PrtCurLeft()':         ['<c-h>', '<left>', '<c-^>'],
    \ 'PrtCurRight()':        ['<c-l>', '<right>'],
    \ 'PrtClearCache()':      ['<F5>'],
    \ 'PrtDeleteEnt()':       ['<F7>'],
    \ 'CreateNewFile()':      ['<c-y>'],
    \ 'MarkToOpen()':         ['<c-z>'],
    \ 'OpenMulti()':          ['<c-o>'],
    \ 'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
    \ }

augroup MyGutentagsStatusLineRefresher
            autocmd!
            autocmd User GutentagsUpdating call lightline#update()
            autocmd User GutentagsUpdated call lightline#update()
augroup END

let g:gutentags_cache_dir="C:/tags"
let g:gutentags_ctags_exclude_wildignore=1

" Lightline: {{{
let g:lightline = {
\ 'colorscheme': 'nord',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'fugitive','ctags','readonly', 'filename', 'modified', 'spell'] ],
\   'right': [
\     [ 'gutentags#statusline'],
\     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
\     ['lineinfo'], ['percent'],
\     ['fileformat', 'fileencoding', 'filetype']
\   ]
\ },
\ 'inactive': {
\   'right': [['lineinfo'], ['percent']]
\ },
"\ 'component': {
"\   'sharpenup': sharpenup#statusline#Build()
"\ },
\ 'component_expand': {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_infos': 'lightline#ale#infos',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok'
  \  },
  \ 'component_type': {
  \   'linter_checking': 'right',
  \   'linter_infos': 'right',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'right'
\  },
  \ 'component_function': {
  \   'fugitive': 'FugitiveHead',
  \   'filename': 'LightlineFilename',
  \   'ctags': 'gutentags#statusline',
  \ },
\}
" Use unicode chars for ale indicators in the statusline
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "

function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction
" }}}

let g:user_emmet_leader_key='<C-t>'
let g:user_emmet_complete_tag='s'


let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*\\bin\\*,*\\obj\\*,*\\node_modules\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|bin|obj|node_modules)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }



if has('win32')
    source ~\AppData\Local\nvim\.vimrc.bepo
else
    source ~/.config/nvim/.vimrc.bepo
endif
