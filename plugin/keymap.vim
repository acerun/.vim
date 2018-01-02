"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Maintainer:
"    Run
"
"Info:
"For VIM plugins
"Some plugins are in plugin directory
"
"Sections:
"    -> gtags.vim
"    -> END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => gtags.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Version: 0.6.8
"Comes from GUN GLOBAL: https://www.gnu.org/software/global/
vnoremap <leader>g "gy:Gtags <C-R>g
nnoremap <leader>g :Gtags <C-R>=expand("<cword>")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

