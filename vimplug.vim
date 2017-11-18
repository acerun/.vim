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
map <F1> :NERDTreeToggle<CR>
Plug 'Xuyuanp/nerdtree-git-plugin'

"Install the plugins if first run
if isFirstInstall == 1
    echo "Install vim plugins, please ignore key map error message"
    echo ""
    :PlugInstall
endif
call plug#end()
