" File: operator.vim
" Author: romgrk
" Date: 01 Feb 2016
" Description: LHS/RHS operators:                                                   {{{
" !::exe [redraw | so % | call EchoHL('Warning', 'sourced') ]
" (see ../autoload/equal.vim) }}}

onoremap <Plug>(operator-lhs) :<C-u>normal <C-r>=equal#selectLeft('i')<CR><CR>
onoremap <Plug>(operator-rhs) :<C-u>normal <C-r>=equal#selectRight('i')<CR><CR>
onoremap <Plug>(operator-Lhs) :<C-u>normal <C-r>=equal#selectLeft('a')<CR><CR>
onoremap <Plug>(operator-Rhs) :<C-u>normal <C-r>=equal#selectRight('a')<CR><CR>

vmap <expr><Plug>(visual-lhs) "\<Esc>" . equal#selectLeft('i')
vmap <expr><Plug>(visual-rhs) "\<Esc>" . equal#selectRight('i')
vmap <expr><Plug>(visual-Lhs) "\<Esc>" . equal#selectLeft('a')
vmap <expr><Plug>(visual-Rhs) "\<Esc>" . equal#selectRight('a')

