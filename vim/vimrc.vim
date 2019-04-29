" General Vim settings
        set nocompatible           " do not load vi
        filetype plugin indent on  " Load plugins accoriding to detected filetype
        syntax on                  " Enable szntax highlighting
        let mapleader=","          " Custom hotkey for specific functions


        set list                   " Display unprintable characters f12 - switches
        set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping

        set autoindent              " Indent at the same level of the previous line
        set expandtab               " Use spaces instead of tabs
        set softtabstop=4           " Let backspace delete indents
        set shiftwidth=4            " Use indents of 4 spaces
        set shiftround

        set splitright              " Puts new vsplit windows to the right of the current
        set splitbelow              " Puts new split windows to the bottom of the current

        set backspace   =indent,eol,start  " Make backspace work as you would expect.
        set hidden                 " Switch between buffers without having to save first.
        set laststatus  =2         " Always show statusline.
        set display     =lastline  " Show as much as possible of the last line.

        set showmode               " Show current mode in command-line.
        set showcmd                " Show already typed keys when more are expected.

        set ttyfast                " Faster redrawing.
        set lazyredraw             " Only redraw when necessary.

        set splitbelow             " Open new windows below the current window.
        set splitright             " Open new windows right of the current window.

        set dir=/tmp/              " Direcotory where swap files etc. are stored

        set relativenumber         " Show the relative numbers on the left
        set number                 " Show the number of the current line

        set hlsearch
        set incsearch
        set wrapscan               " Searches wrap around end-of-file.

" allow for a key sequence to exit insert mode
        inoremap jj <Esc>
        inoremap jk <Esc>
        inoremap kj <Esc>

" Insert a singel character
        nnoremap <C-i> i_<Esc>r

" Reselects the previous selection after shifting to allow for continuous shifting
        xnoremap < <gv
        xnoremap > >gv

" File and Window Management
        inoremap <leader>w <Esc>:w<CR>
        nnoremap <leader>w :w<CR>

        inoremap <leader>q <ESC>:q<CR>
        nnoremap <leader>q :q<CR>

        inoremap <leader>b <ESC>:bd<CR>
        nnoremap <leader>b :bd<CR>

" Buffer management
        :nnoremap <C-n> :bnext<ESC>
        :nnoremap <C-p> :bprevious<ESC>


" Return to the same line you left off at
augroup line_return
    au!
        au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \	execute 'normal! g`"zvzz' |
                \ endif
augroup END

" Auto load
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
set autoread
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
