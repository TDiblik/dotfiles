" Use system clipboard
set clipboard^=unnamed,unnamedplus
set splitright

" Stolen from https://github.com/vscode-neovim/vscode-neovim/blob/master/vim/vscode-tab-commands.vim
function! s:switchEditor(...) abort
    let count = a:1
    let direction = a:2
    for i in range(1, count ? count : 1)
        call VSCodeCall(direction ==# 'next' ? 'workbench.action.nextEditorInGroup' : 'workbench.action.previousEditorInGroup')
    endfor
endfunction

if exists('g:vscode')
    " Tab navigation
    nnoremap K <Cmd>call <SID>switchEditor(v:count, 'next')<CR>
    xnoremap K <Cmd>call <SID>switchEditor(v:count, 'next')<CR>
    nnoremap J <Cmd>call <SID>switchEditor(v:count, 'prev')<CR>
    xnoremap J <Cmd>call <SID>switchEditor(v:count, 'prev')<CR>

    " Windows navigation
    nnoremap H <Cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>
    xnoremap H <Cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>
    nnoremap L <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
    xnoremap L <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
endif
