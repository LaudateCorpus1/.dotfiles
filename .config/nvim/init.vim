"
" Remap <Leader>
"
nnoremap <silent> <SPACE> <Nop>
let g:mapleader="\<SPACE>"

"
" Plugins
"

call plug#begin()

" Theme
Plug 'chriskempson/base16-vim'

" Show Git
Plug 'tpope/vim-fugitive'

" Time tracking
" Plug 'wakatime/vim-wakatime'

" Syntax checking
Plug 'vim-syntastic/syntastic'

" Comment blocks
Plug 'scrooloose/nerdcommenter'

" File Explorer
Plug 'scrooloose/nerdtree'

" File finding
Plug 'ctrlpvim/ctrlp.vim'

" Coq
Plug 'tounaishouta/coq.vim', {'for': 'coq'}

" PureScript necessities
Plug 'FrigoEU/psc-ide-vim', {'for': 'purescript'}
Plug 'purescript-contrib/purescript-vim', {'for': 'purescript'}

" Haskell necessities
Plug 'neomake/neomake', { 'for': 'haskell' }
Plug 'shougo/vimproc.vim', {'do' : 'make'}
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }

call plug#end()


"
" Theme
"

" https://gist.github.com/paulrouget/ad44d1a907a668d012d23b0c1bdf72f9
set background=dark
set termguicolors
colorscheme base16-bear

hi vertsplit ctermfg=238 ctermbg=235
hi LineNr ctermfg=237
hi StatusLine ctermfg=235 ctermbg=245
hi StatusLineNC ctermfg=235 ctermbg=237
hi Search ctermbg=58 ctermfg=15
hi Default ctermfg=1
hi clear SignColumn
hi SignColumn ctermbg=235
hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245
hi EndOfBuffer ctermfg=237 ctermbg=235


"
" Status Line
"

set statusline=%{fugitive#statusline()}
set statusline+=%m
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=%f\ [\ %l\/%L\ ]

" Always show statusline
set laststatus=2

" Don't show the insert mode
set noshowmode


"
" Syntax highlighting settings
"

syntax on
filetype on
filetype plugin indent on
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" let g:syntastic_quiet_messages = { "!level":  "errors" }


"
" Comment settings
"

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Better Haskell / PureScript defaults
let g:NERDCustomDelimiters = {
	\ 'haskell': { 'leftAlt': '{-','rightAlt': '-}', 'left': '-- ', 'right': '' },
	\ 'purescript': { 'leftAlt': '{-','rightAlt': '-}', 'left': '-- ', 'right': '' },
\ }


"
" Remap nerdtree toggle with space-nt
"

nnoremap <leader>nt :NERDTreeToggle<CR>


"
" Some commands
"

noremap <leader>lo :lopen<CR>
noremap <leader>lc :lclose<CR>


"
" Quality of life settings
"

" Text
set encoding=utf-8
set tabstop=2
set softtabstop=2
set shiftwidth=2
set backspace=2
set expandtab
set autoindent
set listchars=tab:▸▸

" Trim whitespace on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


"
" Ctrl P
"

" Ignore file types in ctrlp
set wildignore+=*/tmp/*,*/output/*.js,*/node_modules/*,*/bower_components/*,*.so,*.swp,*.zip


"
" PureScript
"

" See https://github.com/FrigoEU/psc-ide-vim/blob/master/doc/psc-ide-vim.txt
au FileType purescript nm <buffer> <silent> <leader>L :Plist<CR>
au FileType purescript nm <buffer> <silent> <leader>l :Pload!<CR>
au FileType purescript nm <buffer> <silent> <leader>r :Prebuild!<CR>
au FileType purescript nm <buffer> <silent> <leader>f :PaddClause<CR>
au FileType purescript nm <buffer> <silent> <leader>t :PaddType<CR>
au FileType purescript nm <buffer> <silent> <leader>a :Papply<CR>
au FileType purescript nm <buffer> <silent> <leader>A :Papply!<CR>
au FileType purescript nm <buffer> <silent> <leader>C :Pcase!<CR>
au FileType purescript nm <buffer> <silent> <leader>i :Pimport<CR>
au FileType purescript nm <buffer> <silent> <leader>qa :PaddImportQualifications<CR>
au FileType purescript nm <buffer> <silent> <leader>g :Pgoto<CR>
au FileType purescript nm <buffer> <silent> <leader>p :Pursuit<CR>
au FileType purescript nm <buffer> <silent> <leader>T :Ptype<CR>

"
" Haskell
"

let g:syntastic_haskell_checkers=['']


"
" JavaScript
"

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = "yarn lint"
