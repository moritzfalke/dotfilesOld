" Configuration for neovim

" get standard vim config
source ~/.vimrc

" load Plug (plugin manager)
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" load plugins
call plug#begin('~/.vim/plugged')

" Nord theme
Plug 'arcticicestudio/nord-vim'

" vim-airline
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" Show open buffers in airline
Plug 'bling/vim-bufferline'

" Useful for Markdown editing
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" set the colorscheme
colorscheme nord

" Display the current buffers inside airline
let g:bufferline_echo = 0

let g:airline_powerline_fonts = 1

set noshowmode             " Hide the current mode because it gets displayed in airline
