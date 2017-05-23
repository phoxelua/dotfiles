" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually justG
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim74/vimrc_example.vim or the vim manual
" and configure vim to your own liking!


let mapleader=','
execute pathogen#infect()


" ------------------------------------------------------------------------------------
" BASIC CONFIGURATION
" ------------------------------------------------------------------------------------

set nocompatible

" Color
syntax on
set encoding=utf-8
set number
set background=dark
set t_Co=256
colorscheme PaperColor

" White space
" Tab/white space Config
filetype indent on
filetype plugin on
filetype plugin indent on

" Turn on incremental search with ignore case (except explicit caps)
set incsearch
set ignorecase
set smartcase
set hlsearch

" show existing tab with 4 spaces width
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" Put all swap files in one place
set directory^=$HOME/.vim_swap//

" Clear all highlights with space
nnoremap <Space> :noh<CR>

" Select all
map <C-a> <esc>ggVG

" Have actually sane navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Shorten wait from insert mode to normal
set timeoutlen=1000 ttimeoutlen=0

" Toggle paste mode
set pastetoggle=<leader>p

" Open new file in tab
nnoremap te  :tabedit<Space>

" Get vim to actually f*cking recognize markdown
au BufRead,BufNewFile *.md set filetype=markdown

" Remove annoying ass omni-complete tip window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"" Escape too far away
imap jk <Esc>

" ------------------------------------------------------------------------------------
" LIGHTLINE
" ------------------------------------------------------------------------------------
" set laststatus=2
" colorscheme PaperColor
" let g:lightline = { 'colorscheme': 'PaperColor' }
" let g:lightline = {
"       \ 'component_function': {
"       \   'filename': 'LightLineFilename',
"       \ }
"       \ }
" function! LightLineFilename()
"     return expand('%:p')
" endfunction


" ------------------------------------------------------------------------------------
" AIRLINE
" ------------------------------------------------------------------------------------
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#hunks#enabled=1
let g:airline_theme='powerlineish'

" Tabs
let g:airline#extensions#tabline#tab_nr_type = 1
hi TabLine      ctermfg=white  ctermbg=Black     cterm=NONE
hi TabLineFill  ctermfg=White  ctermbg=Black     cterm=NONE
hi TabLineSel   ctermfg=22     ctermbg=148       cterm=NONE


" ------------------------------------------------------------------------------------
" CONTROL-P
" ------------------------------------------------------------------------------------
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Faster search with ag
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --ignore ''bower_components'' --ignore ''media'' --ignore ''.pyc'' --hidden -g ""'
endif

"Make open new tab default
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }


" ------------------------------------------------------------------------------------
" Easy Motion
" ------------------------------------------------------------------------------------
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>b <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


" ------------------------------------------------------------------------------------
" MULTIPLE CURSORS
" ------------------------------------------------------------------------------------
let g:multi_cursor_start_key='<C-m>'
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-D>'
let g:multi_cursor_quit_key='<C-m>'


" ------------------------------------------------------------------------------------
" NERD TREE
" ------------------------------------------------------------------------------------
map <C-n> :NERDTreeTabsToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" ------------------------------------------------------------------------------------
" SNIPPETS
" ------------------------------------------------------------------------------------
nnoremap <leader>i oimport ipdb; ipdb.set_trace()<Esc>

" ------------------------------------------------------------------------------------
" SYNTASTIC
" ------------------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
let g:syntastic_python_checkers=['python', 'flake8']
let g:syntastic_python_flake8_args = "--max-line-length=150"
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_typescript_checkers = ['tslint', 'tsc']
let g:syntastic_typescript_tslint_args = "--config ~/.tslint.json"
let JSHintUpdateWriteOnly=1
nnoremap <C-e> :SyntasticCheck<CR>


" ------------------------------------------------------------------------------------
" YCM
" ------------------------------------------------------------------------------------
nnoremap <leader>jt :YcmCompleter GoTo<CR>
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_ljg_level = 'debug'
let g:ycm_server_use_vim_stdout = 0
