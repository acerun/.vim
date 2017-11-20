"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Maintainer:
"    Run
"
"Info:
"For VIM plugins
"
"Sections:
"    -> DL vim-plug if necessary
"    -> Nerdtree
"    -> Tagbar
"    -> Git
"    -> FZF
"    -> YouCompleteMe
"    -> Markdown
"    -> END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => DL vim-plug if necessary
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Download vim-plug: VIM Plugin Manager
"https://github.com/junegunn/vim-plug
let isFirstInstall=0
let vimplug_path=expand('~/.vim/autoload/plug.vim')
if !filereadable(vimplug_path)
    echo "Install vim-plug.."
    echo ""
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let isFirstInstall=1
endif

call plug#begin('~/.vim/plugged')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
map <F1> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'majutsushi/tagbar'
nmap <F2> :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"For Windows, download the fzf.exe:
"https://github.com/junegunn/fzf-bin/releases

"Need install ag:https://github.com/ggreer/the_silver_searcher
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

:let $FZF_DEFAULT_COMMAND  = 'find . -type f ! -path "./node_modules/*" ! -path "./bower_components/*" ! -path "./.git/*" ! -path "*.swp"'
map <C-P> :tabnew<CR>:FZF<CR>
nmap <C-B> :Buffer<CR>
nmap <C-L> :Lines<CR>
nmap <C-H> :History:<CR>
nmap <C-T> :Tags<CR>
nmap <leader>r :FZFMru<CR>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe: a code-completion engine for Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
    Plug 'shougo/neocomplete.vim'
    source ~/.vim/neocomplete_config.vim
else
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'jszakmeister/markdown2ctags'
Plug 'iamcco/markdown-preview.vim'

" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/.vim/plugged/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => END  -Install the plugins if first run
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Install the plugins if first run
if isFirstInstall == 1
    echo "Install vim plugins, please ignore key map error message"
    echo ""
    :PlugInstall
endif
call plug#end()
