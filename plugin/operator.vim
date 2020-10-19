" File: operator.vim
" Author: romgrk
" Date: 01 Feb 2016
" Description: LHS/RHS operators:                                                   {{{
" !::exe [So]
"
" 1. operate on left/right side of equal sign
" 2. if no equal sign is present, tries to match colon sign
" 3. if no match is made, fails
"
" Test:
" let value = 'string'
" key: "value"
" let value += 'string'
"
" }}}

onoremap <Plug>(operator-lhs) :<C-u>normal! <C-r>=<SID>selectLeftOperand('i')<CR><CR>
onoremap <Plug>(operator-rhs) :<C-u>normal! <C-r>=<SID>selectRightOperand('i')<CR><CR>
onoremap <Plug>(operator-Lhs) :<C-u>normal! <C-r>=<SID>selectLeftOperand('a')<CR><CR>
onoremap <Plug>(operator-Rhs) :<C-u>normal! <C-r>=<SID>selectRightOperand('a')<CR><CR>

vnoremap <expr><Plug>(visual-lhs) "\<Esc>" . <SID>selectLeftOperand('i')
vnoremap <expr><Plug>(visual-rhs) "\<Esc>" . <SID>selectRightOperand('i')
vnoremap <expr><Plug>(visual-Lhs) "\<Esc>" . <SID>selectLeftOperand('a')
vnoremap <expr><Plug>(visual-Rhs) "\<Esc>" . <SID>selectRightOperand('a')

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


fu! s:selectLeftOperand(target) "                                       {{{
    let iStart = s:findAssignment()
    if iStart == -1
        return ''
    end
    if a:target == 'i'
        let iStart = iStart - 1
        if getline('.')[iStart -1] == ' '
            let iStart = iStart - 1
        end
    end
    let keys = iStart.'|v^'
    return keys
endfu
fu! s:selectRightOperand(target) "                                      {{{
    let iStart = s:findAssignment()
    if iStart == -1
        return ''
    end
    if a:target == 'i'
        let nextChar = getline('.')[iStart]
        if (nextChar == '>' || nextChar == '=')
            let iStart = iStart + 2
        else
            let iStart = iStart + 1     | end

        "if there is a space, shift one more
        if getline('.')[iStart - 1] == ' '
            let iStart = iStart + 1     | end
    end
    let keys = ''
    if a:target == 'i'
        let string_length = strlen(getline('.'))
        let last_char = getline('.')[string_length - 1]
        if last_char == ',' || last_char == ';'
            let keys = iStart.'|v'. (string_length - 1) . '|'
        else
            let keys = iStart.'|v$h'
        end
    else
        let keys = iStart.'|v$h'
    end
    return keys
endfunction "                                                                }}}

fu! s:findAssignment() "                                                   {{{
    let line = getline('.')
    let i = 0
    " Look for [...]=
    while i >= 0 && i < strlen(line)
        if (line[i]=='=') || (line[i]=='-' && line[i + 1]=='>')
            return i + 1
        end
        let i = i + 1
    endwhile
    " FIXME look for ':'
    let i = 0
    while i >= 0 && i < strlen(line)
        if (line[i]==':')
            return i + 1
        end
        let i = i + 1
    endwhile
    " Fail & return
    return -1
endfu "                                                                }}}

