setlocal ts=2 sts=2 sw=2 expandtab

let g:ruby_path = system('rbenv prefix')
let g:ale_fixers.ruby = ['rubocop']
let g:rubycomplete_rails = 0
