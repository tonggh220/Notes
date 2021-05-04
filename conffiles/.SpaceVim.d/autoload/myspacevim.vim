function! myspacevim#before() abort
    inoremap <C-a> <Home>
    inoremap <C-e> <End>
    inoremap <C-f> <Right>
    inoremap <C-b> <Left>
    set mouse=a
    set selection=exclusive
    set selectmode=mouse,key
    let g:ibus#layout = 'xkb:us::eng'
    let g:ibus#engine = 'rime'
endfunction

function! myspacevim#after() abort
endfunction
