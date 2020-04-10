setlocal ts=4 sts=4 sw=4 noexpandtab listchars=tab:\ \ ,trail:·,nbsp:·

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0

let g:go_def_mode="gopls"
let g:go_info_mode="gopls"

map <Leader>t :GoTest<CR>
let g:ale_fixers['go'] = []
let g:ale_linters['go'] = ['go vet', 'gofmt']

compiler go

" Prevent vim-go from overwriting vim-godebug's commands
command! -nargs=* -bang GoDebugStart call godebug#debug(<bang>0, 0, <f-args>)
