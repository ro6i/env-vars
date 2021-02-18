let g:env_variables = {}

function! SetNvimPipe(env_variable_name)
  call inputsave()
  echoh Comment
  let token = input("$" . a:env_variable_name . " = ")
  echoh None
  call inputrestore()
  if !empty(token)
    execute "let $" . a:env_variable_name . "='" . token . "'"
    redraw
    echoh PreCondit
    echom "\$" . a:env_variable_name . " environment variable is set to: " . token
    echoh None
    let g:env_variables[a:env_variable_name] = token
  else
    execute "let $" . a:env_variable_name . "=''"
    unlet g:env_variables[a:env_variable_name]
  endif
  if exists('*lightline#update')
    call lightline#update()
  endif
endfunction

function! LightlineEnv()
  if empty(g:env_variables)
    return ''
  endif
  let l:result = ''
  for [key, val] in items(g:env_variables)
    let l:result = l:result . ' $' . key . "='" . val . "' |"
  endfor
  return l:result
endfunction
