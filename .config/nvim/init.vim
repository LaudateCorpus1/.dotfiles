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

" Syntax checking
Plug 'vim-syntastic/syntastic'
Plug 'neomake/neomake', {'for': 'haskell'}

" Comment blocks
Plug 'scrooloose/nerdcommenter'

" File Explorer
Plug 'scrooloose/nerdtree'

" File finding
Plug 'ctrlpvim/ctrlp.vim'

" Coq
Plug 'tounaishouta/coq.vim'

" PureScript necessities
Plug 'FrigoEU/psc-ide-vim'
Plug 'purescript-contrib/purescript-vim'

" Haskell necessities
Plug 'parsonsmatt/intero-neovim'
Plug 'eagletmt/ghcmod-vim', {'for': 'haskell'}
Plug 'shougo/vimproc.vim', {'do' : 'make'}
Plug 'neovimhaskell/haskell-vim'

call plug#end()


"
" Theme
"

" https://gist.github.com/paulrouget/ad44d1a907a668d012d23b0c1bdf72f9
set background=dark
set termguicolors
colorscheme base16-grayscale-dark

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
set fillchars=vert:\ ,stl:\ ,stlnc:\

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
let g:syntastic_quiet_messages = { "!level":  "errors" }


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

" Spaces, not tabs.
set tabstop=2
set shiftwidth=2
set expandtab

" Indents
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

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

nm <buffer> <silent> <leader>t :<C-U>call PSCIDEtype(PSCIDEgetKeyword(), v:true)<CR>
nm <buffer> <silent> <leader>T :<C-U>call PSCIDEaddTypeAnnotation(matchstr(getline(line(".")), '^\s*\zs\k\+\ze'))<CR>
nm <buffer> <silent> <leader>s :<C-U>call PSCIDEapplySuggestion()<CR>
nm <buffer> <silent> <leader>a :<C-U>call PSCIDEaddTypeAnnotation()<CR>
nm <buffer> <silent> <leader>i :<C-U>call PSCIDEimportIdentifier(PSCIDEgetKeyword())<CR>
nm <buffer> <silent> <leader>r :<C-U>call PSCIDEload()<CR>
nm <buffer> <silent> <leader>p :<C-U>call PSCIDEpursuit(PSCIDEgetKeyword())<CR>
nm <buffer> <silent> <leader>C :<C-U>call PSCIDEcaseSplit("!")<CR>
nm <buffer> <silent> <leader>f :<C-U>call PSCIDEaddClause("")<CR>
nm <buffer> <silent> <leader>qa :<C-U>call PSCIDEaddImportQualifications()<CR>
nm <buffer> <silent> <leader>da :<C-U>call PSCIDEgoToDefinition("", PSCIDEgetKeyword())<CR>
