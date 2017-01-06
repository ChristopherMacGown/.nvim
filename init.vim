
" Pathogen ********************************************************************
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
set nocompatible


" Colors **********************************************************************
"set t_Co=256 " 256 colors
syntax on " syntax highlighting
set background=dark
colorscheme gruvbox


" Filetype specific tab styles ************************************************
syntax on
filetype plugin indent on

autocmd Filetype c      call languagestyles#C()
autocmd Filetype go     call languagestyles#Go()
autocmd Filetype vim    call languagestyles#Vimscript()
autocmd Filetype python call languagestyles#Python()


" Handle new tab CD properly **************************************************
autocmd BufEnter * silent! tcd %:p:h
autocmd TabNewEntered * call ontabenter#OnTabEnter(expand("<amatch>"))


" Windows *********************************************************************
set equalalways " Multiple windows, when created, are equal in size


"Vertical split then hop to new buffer
:noremap ,v :vsp^M^W^W<cr>
:noremap ,h :split^M^W^W<cr>


" Moving around windows
map <C-j> <C-w>j<C-w><Esc>
map <C-k> <C-w>k<C-w><Esc>
map <C-l> <C-w>l<C-w><Esc>
map <C-h> <C-w>h<C-w><Esc>


" Misc ************************************************************************
set backspace=indent,eol,start
set number " Show line numbers
set matchpairs+=<:>
set vb t_vb= " Turn off bell, this could be more annoying, but I'm not sure how


" Directories *****************************************************************
" Setup backup location and enable
set backupdir=~/.config/nvim/backups
set directory=~/.config/nvim/backups
set undodir=~/.config/nvim/backups/undos/
set undofile
set backup


" Inser New Line **************************************************************
let maplocalleader = ","
map <S-Enter> O<ESC> " awesome, inserts new line without going into insert mode
map <Enter> o<ESC>
set fo-=r " do not insert a comment leader after an enter, (no work, fix!!)


" Invisible characters *********************************************************
set listchars=trail:.,tab:>-,eol:$
set nolist
:noremap ,i :set list!<CR> " Toggle invisible chars


" Don't search for python.
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1

" Status Line *****************************************************************
set showcmd
set ruler " Show ruler


" Line Wrapping ***************************************************************
set nowrap
set linebreak  " Wrap at word



" Sessions ********************************************************************
" Sets what is saved when you save a session
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize


" NeoMake *****************************************************************
autocmd! BufWritePost * Neomake
autocmd Filetype python let b:neomake_pylint_args = g:neomake_pylint_args + [GetPylintRCArgs()]


let g:neomake_open_list=2
let g:neomake_error_sign   = {'text': 'E➤', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': 'W➤', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': 'M➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign    = {'text': 'I➤', 'texthl': 'NeomakeInfoSign'}

"let g:neomake_pylint_append_file = 0
let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_pylint_args = neomake#makers#ft#python#pylint()['args']
let g:neomake_go_enabled_makers     = ['go', 'gometalinter']
let g:neomake_go_gometalinter_maker = {
\     'args': ['--disable-all', '-E', 'vet', '-E', 'golint', '-E', 'errcheck', '--message-overrides', 'errcheck:{message}', '--sort', 'line', '--tests', '--exclude', 'bindata', '--exclude', '.pb.', '--enable-gc'],
\     'append_file': 0,
\     'cwd': '%:h',
\     'mapexpr': 'neomake_bufdir . "/" . v:val',
\     'errorformat': '%W%f:%l:%c:%m',
\ }


" NERDTree ********************************************************************
:noremap ,n :NERDTreeToggle<CR>

" User instead of Netrw when doing an edit /foobar
let NERDTreeHijackNetrw=1

" Single click for everything
let NERDTreeMouseMode=1


" incsearch ***************************************************************
let g:incsearch#auto_nohlsearch = 1

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)


" deoplete ********************************************************************
let g:deoplete#enable_at_startup = 1


" Airline *********************************************************************
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme = 'serene'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1

" -----------------------------------------------------------------------------
" |                               PylintRC stuff                              |
" -----------------------------------------------------------------------------

function! FindFileInTree(filename) 
  if ! exists("t:filecache") 
    let t:filecache = {}
  endif
  if ! has_key(t:filecache, a:filename)
    let maybe_file = UncachedFindFileInTree(a:filename)
    if maybe_file != ''
      let t:filecache[a:filename] = maybe_file
      return maybe_file
    endif
  endif
endfunction

function! UncachedFindFileInTree(filename) 
  let tmp = findfile(a:filename, ".;")
  if tmp != ''
    return fnamemodify(tmp, ":p")
  endif
endfunction

function! GetPylintRCArgs()
    let rc = FindFileInTree(".pylintrc")
    if rc != ''
        return '--rcfile=' . rc
    endif
endfunction

Helptags
