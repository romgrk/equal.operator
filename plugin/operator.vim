" File: operator.vim
" Author: romgrk
" Date: 01 Feb 2016
" Description: LHS/RHS operators
" !::exe [so %]

onoremap <silent> <Plug>(operator-lhs) :<C-u>normal! <C-r>=<SID>selectLeftOperand('i')<CR><CR>
onoremap <silent> <Plug>(operator-rhs) :<C-u>normal! <C-r>=<SID>selectRightOperand('i')<CR><CR>
onoremap <silent> <Plug>(operator-Lhs) :<C-u>normal! <C-r>=<SID>selectLeftOperand('a')<CR><CR>
onoremap <silent> <Plug>(operator-Rhs) :<C-u>normal! <C-r>=<SID>selectRightOperand('a')<CR><CR>

vnoremap <silent> <expr><Plug>(visual-lhs) "\<Esc>" . <SID>selectLeftOperand('i')
vnoremap <silent> <expr><Plug>(visual-rhs) "\<Esc>" . <SID>selectRightOperand('i')
vnoremap <silent> <expr><Plug>(visual-Lhs) "\<Esc>" . <SID>selectLeftOperand('a')
vnoremap <silent> <expr><Plug>(visual-Rhs) "\<Esc>" . <SID>selectRightOperand('a')

if get(g:, 'equal_operator_default_mappings', 1)
    omap il <Plug>(operator-rhs)
    omap ih <Plug>(operator-lhs)
    omap al <Plug>(operator-Rhs)
    omap ah <Plug>(operator-Lhs)

    xmap il <Plug>(visual-rhs)
    xmap ih <Plug>(visual-lhs)
    xmap al <Plug>(visual-Rhs)
    xmap ah <Plug>(visual-Lhs)
end


" Specs                                                   {{{
"
" 1. operate on left/right side of equal sign
" 2. if no equal sign is present, tries to match colon sign
" 3. if no match is made, fails
"
" Test:
"
" let value = get_value()
" String->Value("ok");
"        key: "value"
" let value += 'string'
"      key => "value"
" let value >>= 'string'
" return value
"
" }}}

fu! s:selectLeftOperand(target) "                                       {{{
    let pos = s:findAssignment(0)
    if empty(pos)
        return ''
    end

    let column =
        \ a:target == 'i' ?
        \     pos[0] : pos[1]

    let keys = column.'|v^'
    return keys
endfu
fu! s:selectRightOperand(target) "                                      {{{
    let pos = s:findAssignment(1)
    if empty(pos)
        return ''
    end

    let column =
        \ a:target == 'i' ?
        \     pos[1] : pos[0]
    let column += 1
    let end = pos[2]

    let keys = column . '|v'

    if end != -1
        let keys .= end . '|'
    else
        let keys .= '$h'
    end

    return keys
endfunction "                                                                }}}

fu! s:findAssignment(dir, ...) "                                                   {{{
    let line = a:0 ? a:1 : getline('.')
    let i = 0

    let patterns = [
    \ '[><+\-*=/!@#$%^?&:.~]{,2}\=[><+\-*=/!@#$%^?&:.~]{,2}',
    \ ':',
    \ '-\>',
    \ 'return',
    \ ]

    for pattern in patterns
        let realPattern =
        \ '\v' .
        \ (a:dir == 0 ? '\s*' : '') .
        \ pattern .
        \ (a:dir == 1 ? '\s*(\s*)@=' : '')

        let end = -1
        if a:dir == 1
            let m = matchstrpos(line, '\v[;,]\s*$')
            if m[1] != -1
                let end = m[1]
            end
        end
        let m = matchstrpos(line, realPattern)
        if m[1] != -1
            return m[1:2] + [end]
        end
    endfor

    " Fail & return
    return v:null
endfu "                                                                }}}

" let x = 42;
" let g:s = 'let x = 42;'
" let g:R = s:findAssignment(1, g:s)
" Pp R, !empty(R) ? s[R[1] - 1:R[2] - 1] : s

" if !empty(g:R)
    " Pp [R, g:s[R[0]:R[1]]]
" else
    " Pp g:R
" end
