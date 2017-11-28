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
"    -> FZF or CtrlP
"    -> YouCompleteMe
"    -> Markdown
"    -> EasyMotion
"    -> Vim-go
"    -> Others
"    -> END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => DL vim-plug if necessary
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Download vim-plug: VIM Plugin Manager
"https://github.com/junegunn/vim-plug
let vimplug_path=expand('~/.vim/autoload/plug.vim')
if empty(glob(vimplug_path))
    echo "Install vim-plug.."
    echo ""
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
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
" => FZF or CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let isFZF=1
if isFZF==1
    "For gWindows, download the fzf.exe:
    "https://github.com/junegunn/fzf-bin/releases

    "Need install ag:https://github.com/ggreer/the_silver_searcher
    "ripgrep may be better:https://github.com/BurntSushi/ripgrep
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'pbogut/fzf-mru.vim'
    " [Buffers] Jump to the existing window if possible
    let g:fzf_buffers_jump = 1

    " [[B]Commits] Customize the options used by 'git log':
    let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

    " [Tags] Command to generate tags file
    let g:fzf_tags_command = 'ctags -R'

    let $FZF_DEFAULT_COMMAND  = 'find . -type f ! -path "./node_modules/*" ! -path "./bower_components/*" ! -path "./.git/*" ! -path "*.swp"'
    if executable('ag')
        let $FZF_DEFAULT_COMMAND = 'ag -l -g "" --nocolor --hidden --ignore=".git" --ignore="*.pyc"'
        "   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
        "   :Ag! - Start fzf in fullscreen and display the preview window above
        command! -bang -nargs=* Ag
                    \ call fzf#vim#ag(<q-args>,
                    \                 <bang>0 ? fzf#vim#with_preview('up:60%')
                    \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
                    \                 <bang>0)
    endif
    if executable('rg')
        let $FZF_DEFAULT_COMMAND = 'rg --column --line-number --no-heading --color=never --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --files'
        "command! -bang -nargs=* Rg
        command! -bang -nargs=* Ag
                    \ call fzf#vim#grep(
                    \   'rg --column --line-number --no-heading --color=always --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" '.shellescape(<q-args>), 1,
                    \   <bang>0 ? fzf#vim#with_preview('up:60%')
                    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                    \   <bang>0)
    endif
    let $FZF_FIND_FILE_COMMAND = "$FZF_DEFAULT_COMMAND"

    map  <C-P> :FZF<CR>
    nmap <C-B> :Buffer<CR>
    nmap <C-H> :History:<CR>
    nmap <C-L> :Lines<CR>
    nmap <C-F> :FZFMru<CR>
    nmap <C-T> :Tags <C-R>=expand("<cword>")<CR>
    nmap <C-A> :Ag <C-R>=expand("<cword>")<CR>
    nmap <leader>bl :BLines<CR>

else
    "Use CtrlP
    Plug 'kien/ctrlp.vim'
    if executable('ag')
        set grepprg=ag\ --nogroup\ --nocolor
        "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
        let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
        let g:ctrlp_use_caching = 0
    endif
    "let g:ctrlp_map = '<Leader>p'
    "let g:ctrlp_cmd = 'CtrlP'

    nmap <C-F> :CtrlPMRUFiles<CR>
    nmap <C-B> :CtrlPBuffer<CR>
    nmap <C-T> :CtrlPTag<CR>

    let g:ctrlp_custom_ignore = {
                \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
                \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
                \ }
    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_match_window_bottom = 1

    let g:ctrlp_max_height = 15
    let g:ctrlp_match_window_reversed = 0

    let g:ctrlp_mruf_max = 500
    let g:ctrlp_follow_symlinks = 1

    let g:ctrlp_by_filename = 1
    let g:ctrlp_regexp = 0
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe: a code-completion engine for Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
    Plug 'ervandew/supertab'
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
" => EasyMotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'easymotion/vim-easymotion'

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>W <Plug>(easymotion-bd-w)
nmap <Leader>W <Plug>(easymotion-overwin-w)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'fatih/vim-go'
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
let g:go_list_type = "quickfix"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Others
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"highlight several words in different colors simultaneously
Plug 'vim-scripts/Mark--Karkat'

"vim-signature is a plugin to place, toggle and display marks.
Plug 'kshenoy/vim-signature'

Plug 'mbbill/undotree'
nnoremap <F3> :UndotreeToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#end()
