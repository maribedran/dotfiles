scriptencoding utf8

filetype plugin on
syntax on

set nocp
set nobackup
set noswapfile

autocmd VimEnter * NERDTree

" Navigation
set mouse=a
set bs=2
set whichwrap=<,>,b,s,[,]

" Prompt
set wildmode=longest:list,full " Fix tab completion

" Search
set magic
set is hls ic scs

" Tab
set expandtab
set tabstop=4
set smarttab
set softtabstop=4
set shiftwidth=4
"auto ident that doesn't make comments go to the begging of a line
set smartindent
inoremap # X#
set autoindent
filetype indent on
set textwidth=79

" Create file with pah shortcut
command -nargs=1 E execute('silent! !mkdir -p "$(dirname "<args>")"') <Bar> e <args>


""""""""""""""""""""""""""""""
" Color and UI configuration "
""""""""""""""""""""""""""""""
set number
set title
set visualbell

" Statusbar
set ruler
set showcmd
set laststatus=1

"colorscheme synic
" For some reason synic colorscheme does not work on gnome-terminal
"if ($COLORTERM == 'gnome-terminal')
"    colorscheme desert
"endif

if has("gui_running")
   set guioptions-=T " disable toolbar
   set guioptions-=t " disable tear-off
   set guioptions-=m " disable menu
   set guioptions-=l
   set guioptions-=r
   set guioptions-=b

   colorscheme synic
   set gfn=Inconsolata\ 15
   set lines=40 columns=90
endif

let g:molokai_original = 1

" highlight characters after 80 columns
highlight OverLength ctermbg=lightred ctermfg=black guibg=#592929
match OverLength /\%81v.*/


""""""""""""""""""""""""""""
" Buffer text manipulation "
""""""""""""""""""""""""""""

" Stolen from http://docs.google.com/View?docid=dfkkkxv5_65d5p3nk
" This enables you to see tab characters and stray whitespace
" Show tabs and trailing whitespace visually
if (&termencoding == "utf-8") || has("gui_running")
    if v:version >= 700
        set list listchars=tab:»\ ,trail:·,extends:…,nbsp:‗
    else
        set list listchars=tab:»\ ,trail:·,extends:…
    endif
else
    if v:version >= 700
        set list listchars=tab:>\ ,trail:.,extends:>,nbsp:_
    else
        set list listchars=tab:>\ ,trail:.,extends:>
    endif
endif

"Code folding
function ToggleFold()
   if foldlevel('.') == 0
      " No fold exists at the current line,
      " so create a fold based on indentation

      let l_min = line('.')   " the current line number
      let l_max = line('$')   " the last line number
      let i_min = indent('.') " the indentation of the current line
      let l = l_min + 1

      " Search downward for the last line whose indentation > i_min
      while l <= l_max
         " if this line is not blank ...
         if strlen(getline(l)) > 0 && getline(l) !~ '^\s*$'
            if indent(l) <= i_min

               " we've gone too far
               let l = l - 1    " backtrack one line
               break
            endif
         endif
         let l = l + 1
      endwhile

      " Clamp l to the last line
      if l > l_max
         let l = l_max
      endif

      " Backtrack to the last non-blank line
      while l > l_min
         if strlen(getline(l)) > 0 && getline(l) !~ '^\s*$'
            break
         endif
         let l = l - 1
      endwhile

      "execute "normal i" . l_min . "," . l . " fold"   " print debug info

      if l > l_min
         " Create the fold from l_min to l
         execute l_min . "," . l . " fold"
      endif
   else
      " Delete the fold on the current line
      normal zd
   endif
endfunction
nmap <space> :call ToggleFold()<CR>

"http://vim.wikia.com/wiki/Remove_unwanted_spaces#Automatically_removing_all_trailing_whitespace
autocmd BufWritePre * :%s/\s\+$//e


""""""""""""
" Mappings "
""""""""""""
inoremap <C-space> <C-p>
imap <Nul> <C-p>
map <F9> :NERDTreeMirror<return>
map <F10> :NERDTreeToggle<return>


""""""""""""""""""""""""""""""""""""
" Language-specific configurations "
""""""""""""""""""""""""""""""""""""

"" Python

" Include system python in path
set path+=/usr/lib/python2.5/site-packages/
" Include current dir in path
set path+=

"Python code completion
autocmd FileType python set omnifunc=pythoncomplete#Complete
let g:pydiction_location='/home/flavio/.vim/complete_dict'

let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" pylint.vim configurations
autocmd FileType python compiler pylint "Use pylint as a Python compiler
let g:pylint_cwindow = 0
let g:pylint_onwrite = 0

" ledger
autocmd BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
let g:ledger_maxwidth = 70
let g:ledger_fillstring = '·'

" LaTeX
autocmd FileType tex set spell spelllang=pt_br

" Other languages
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd BufNewFile,BufRead *.pde setf arduino
autocmd FileType c set noexpandtab


"""""""""""""""""
" NeoComplCache "
"""""""""""""""""

" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" " Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" " Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" " Enable heavy features.
" " Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" " Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
"
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"
"
" For cursor moving in insert mode(Not recommended)
inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
"
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
