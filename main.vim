"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Maintainer:
"    Run
"
"Info:
"    For main config without plugins
"
"Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Fold method
"    -> Status line
"    -> Editing mappings
"       -> Moving windows, tabs and buffers
"       -> Command mode related
"       -> Spell checking
"       -> Parenthesis/bracket
"       -> Misc
"    -> Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set history=1000 "Lines of history VIM has to remember
set autoread "Auto read when a file is changed from the outside
set bsdir=buffer
"set autochdir "Auto change to the dir of current file
set mouse=a "Set mouse enable

"Enable filetype plugins
filetype plugin on
filetype indent on

"Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
"set relativenumber "May disable it in console vim
set softtabstop=7 "When moving vertically using j/k, start of lines to cursor

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set wildmenu "Turn on the wild menu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set cmdheight=1 "Height of the command bar
set hid "A buffer becomes hidden when it is abandoned

"Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"Search settings
set ignorecase "Ignore case when searching
set smartcase "When searching try to be smart about cases 
set hlsearch "Highlight search results
set incsearch "Makes search act like search in modern browsers

set lazyredraw "Don't redraw while executing macros (good performance config)
set magic "For regular expressions turn magic on

set showmatch "Show matching brackets when text indicator is over them
set mat=2 "How many tenths of a second to blink when matching brackets

"No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set foldcolumn=1 "Add a bit extra margin to the left



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme desert
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
    if has('gui_win32')
        set guifont=Consolas:h11
    else
        set guifont=DejaVu\ Sans\ Mono\ 10
    endif
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"persistent undo
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

"Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fold Method
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=indent  "The kind of folding used for the current window
set foldlevel=99
autocmd FileType c,cpp  setl fdm=syntax | setl fen


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set softtabstop=4
set shiftwidth=4

set smarttab
set expandtab "Use the spaces to instead of tabs
set autoindent "Copy indent from current line when starting a new line
set smartindent
set cindent

"Linebreak on 500 characters
set lbr
set tw=500

set wrap "Wrap lines 

"Show tab and trail space
set list
set listchars=tab:>-,trail:-
"Not display above list
nmap <leader>l :set list!<CR>


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
set laststatus=2 "Always show the status line
set ruler "Always show current position
"Format the status line
set statusline=
set statusline+=\ [%n]
set statusline+=\ %{HasPaste()}%F%m%r%h\ %w
set statusline+=\ \ CWD:\ %r%{getcwd()}%h
set statusline+=\ \ \ Line:\ %l\/%L\ (%03p%%)
set statusline+=\ \ Column:\ %c
set statusline+=%=                                "right align
set statusline+=%{''.(&fenc!=''?&fenc:&enc).''}   "encoding
set statusline+=\ %{(&bomb?\",BOM\":\"\")}
set statusline+=\ %{&ff}                          "file format
set statusline+=%y                                "file type
set statusline+=\ \                               "leave 2 space


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"With a map leader it's possible to do extra key combinations
"like <leader>w saves the current file
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Moving windows, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"===> windows
"Zoom / Restore window
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>

"Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"===> quickfix
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

"===> tabs
map <leader>tn :tabedit<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabm<cr>
map <leader>to :tabonly<cr>
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

"===> buffers
" Close the current buffer
map <leader>bc :Bclose<cr>:tabclose<cr>gT
" Close all the buffers
map <leader>ba :bufdo bd<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap ( <esc>`>i)<esc>`<i(<esc>
vnoremap [ <esc>`>i]<esc>`<i[<esc>
vnoremap { <esc>`>i}<esc>`<i{<esc>
vnoremap " <esc>`>i"<esc>`<i"<esc>
vnoremap ' <esc>`>i'<esc>`<i'<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"change CWD with path of current file
nnoremap <silent> <leader>. :cd %:p:h<CR>

"Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

"Fast saving
nmap <leader>w :w!<cr>

":W sudo saves the file
"(useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null


" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>rm mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

"Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Delete trailing white space on save, useful for some filetypes
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
