autocmd CursorHold *.ts,*.tsx TSType
setlocal updatetime=700
nnoremap <buffer> <silent> K :TSDoc<CR>
nnoremap <buffer> <silent> gd :TSDef<CR>
nnoremap <buffer> <silent> <C-]> :TSDef<CR>
nnoremap <buffer> <silent> <C-w><C-]> :TSDefPreview<CR>
nnoremap <buffer> <silent> <C-w>] :TSDefPreview<CR>
nnoremap <buffer> <silent> <C-t> <C-o>
