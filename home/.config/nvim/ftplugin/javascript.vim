let g:test#javascript#mocha#executable = "yarn test"
let g:test#javascript#jest#file_pattern = '\v__tests__/.*[\._-](test|spec)\.(js|jsx|coffee)$'
let g:test#javascript#jest#executable = "yarn test"
let g:javascript_plugin_jsdoc = 1

let g:ale_fixers['javascript'] = ['prettier']
