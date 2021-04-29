""""""""""""""""""""""""""""""""""""""""""""""""""
"   inspired from https://github.com/Chewie/configs
""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""
" General parameters
""""""""""""""""""""""""""""""""""""""""""""""""""
source ~\AppData\Local\nvim\init.vim


"---------------------------------------------------------------------------------
"------------------cursor Shape--------------------------------------------------
"----------------------------------------------------------------------------------
" Cursor in terminal:
" Link: https://vim.fandom.com/wiki/Configuring_the_cursor
" 0 -> blinking block not working in wsl
" 1 -> blinking block
" 2 -> solid block
" 3 -> blinking underscore
" 4 -> solid underscore
" Recent versions of xterm (282 or above) also support
" 5 -> blinking vertical bar
" 6 -> solid vertical bar


" to fix cursor shape in WSL bash add 
" echo -ne "\e[2 q"
" to .bashrc
if &term =~ "xterm"
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[2 q"
endif


set termguicolors


" Set the time (in milliseconds) spent idle until various actions occur
" In this configuration, it is particularly useful for the tagbar plugin
"set updatetime=500

" For some stupid reason, vim requires the term to begin with "xterm", so the
" automatically detected "rxvt-unicode-256color" doesn't work.
"set term=xterm-256color

""""""""""""""""""""""""""""""""""""""""""""""""""
" User interface
""""""""""""""""""""""""""""""""""""""""""""""""""

" Make backspace behave as expected
set backspace=eol,indent,start

" Set the minimal amount of lignes under and above the cursor
" Useful for keeping context when moving with j/k
set scrolloff=5

" Show current mode
set showmode

" Show command being executed
set showcmd

" Show line number
set number

" Always show status line
set laststatus=2

" Format the status line
" This status line comes from Pierre Bourdon's vimrc
set statusline=%f\ %l\|%c\ %m%=%p%%\ (%Y%R)

" Enhance command line completion
set wildmenu

" Set completion behavior, see :help wildmode for details
set wildmode=longest:full,list:full

set wildignore+=**/node_modules/**

" Disable bell completely
set visualbell
set t_vb=

" Color the column after textwidth, usually the 80th
if version >= 703
    set colorcolumn=+1
endif

" Display whitespace characters
set list
set listchars=tab:>─,eol:¬,trail:\ ,nbsp:¤

set fillchars=vert:│

" Enables syntax highlighting
syntax on

" Enable Doxygen highlighting
let g:load_doxygen_syntax=1

" Allow mouse use in vim
set mouse=a

" Briefly show matching braces, parens, etc
set showmatch

" Enable line wrapping
set wrap

" Wrap on column 80
set textwidth=240

" Disable preview window on completion
"set completeopt=longest,menuone

" Highlight current line
set cursorline

""""""""""""""""""""""""""""""""""""""""""""""""""
" Search options
""""""""""""""""""""""""""""""""""""""""""""""""""

" Ignore case on search
set ignorecase

" Ignore case unless there is an uppercase letter in the pattern
set smartcase

" Move cursor to the matched string
set incsearch

" Don't highlight matched strings
set nohlsearch

""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation options
""""""""""""""""""""""""""""""""""""""""""""""""""

" The length of a tab
" This is for documentation purposes only,
" do not change the default value of 8, ever.
set tabstop=8

" The number of spaces inserted/removed when using < or >
set shiftwidth=4

" The number of spaces inserted when you press tab.
" -1 means the same value as shiftwidth
set softtabstop=-1

" Insert spaces instead of tabs
set expandtab

" When tabbing manually, use shiftwidth instead of tabstop and softtabstop
set smarttab

" Set basic indenting (i.e. copy the indentation of the previous line)
" When filetype detection didn't find a fancy indentation scheme
set autoindent

" This one is complicated. See :help cinoptions-values for details
set cinoptions=(0,u0,U0,t0,g0,N-s

""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""

" Set "," as map leader
"let mapleader = ","

" Toggle paste mode
"noremap <leader>pp :setlocal paste!<cr>

" Open the quickfix window if there are errors, or close it if there are no
" errors left
"noremap <leader>cw :botright :cw<cr>

" Run make silently, then skip the 'Press ENTER to continue'
"noremap <leader>m :silent! :make! \| :redraw!<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Persistence options
""""""""""""""""""""""""""""""""""""""""""""""""""

" Set location of the viminfo file
"set viminfo='20,\"50,<100,n~/.vimtmp/viminfo

" See :h last-position-jump
"augroup last_position_jump
"    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
"augroup END

" Persistent undo
"if version >= 703
"    set undofile
"    set undodir=~/.vimtmp/undo
"    silent !mkdir -p ~/.vimtmp/undo
"endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin mappings and options
""""""""""""""""""""""""""""""""""""""""""""""""""

" Use a slightly darker background color to differentiate with the status line
"let g:jellybeans_background_color_256='232'

" Feel free to switch to another colorscheme
"colorscheme jellybeans

" Disable Ack.vim's mappings on the quickfix and location list windows
" We use vim-qf mappings instead
"let g:ack_apply_qmappings = 0
"let g:ack_apply_lmappings = 0
"let g:qf_mapping_ack_style = 1

" Override unimpaired quickfix and loc-list mappings to use vim-qf wrapparound
"let g:nremap = {"[q": "", "]q": "", "[l": "", "]l": ""}
"nmap [q <Plug>(qf_qf_previous)
"nmap ]q <Plug>(qf_qf_next)
"nmap [l <Plug>(qf_loc_previous)
"nmap ]l <Plug>(qf_loc_next)

" Launch fugitive's gstatus
"noremap <leader>gs :Gstatus<cr>

" Mappings for vim-test
"nmap <silent> <leader>ts :TestSuite<cr>

" Tell vim-test to use dispatch to run our tests
"let test#strategy = "dispatch"

" Tell Dispatch to use the pytest compiler when we call pytest (the compiler
" file looks for py.test instead of pytest)
"let g:dispatch_compilers = {'pytest': 'pytest'}

" Add the termdebug built-in plugin
"if version >= 801
"    packadd termdebug
"endif


source ~\AppData\Local\nvim\.vimrc.bepo