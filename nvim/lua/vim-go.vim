" go
" vim-go
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_debug=['shell-commands', 'debugger-commands']   
"let g:go_code_completion_enabled = 1
let g:go_auto_type_info = 1 
let g:go_list_type = "quickfix"
let g:go_gopls_enabled = 1
let g:go_gopls_options = ['-remote=auto']
let g:go_referrers_mode = 'gopls'
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'

let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1

let g:go_debug_log_output = 'debugger' 
"Otherwise you will get a lot of 'err' from delve that will lag vim/nvim"
"let g:go_debug_mappings = {
            "\ '(go-debug-continue)':   {'key': 'c'},
            "\ '(go-debug-print)':      {'key': 'p'},
            "\ '(go-debug-breakpoint)': {'key': 'b'},
            "\ '(go-debug-next)':       {'key': 'n'},
            "\ '(go-debug-step)':       {'key': 's'},
            "\ '(go-debug-stop)':       {'key': 'e'},
            "\}



