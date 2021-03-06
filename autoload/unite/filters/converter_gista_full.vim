"******************************************************************************
"
" Author:   Alisue <lambdalisue@hashnote.net>
" URL:      http://hashnote.net/
" License:  MIT license
" (C) 2014, Alisue, hashnote.net
"******************************************************************************
let s:save_cpo = &cpo
set cpo&vim


function! s:format_gist(gist) " {{{
  let nfiles = printf("%2d)", len(a:gist.files))
  let gistid = printf("[%-20s]", a:gist.id)
  let updated_at = gista#utils#datetime(a:gist.updated_at).format('%Y/%m/%d %H:%M:%S')
  let description = empty(a:gist.description) ?
        \ '<<No description>>' :
        \ a:gist.description
  let private = a:gist.public ? "" : g:gista#private_mark
  return printf("%s %s %s %s %s",
        \ nfiles,
        \ gistid,
        \ updated_at,
        \ description,
        \ private,
        \)
endfunction " }}}
let s:converter = {
      \ 'name': 'converter_gista_full',
      \ 'description': 'vim-gista gist converter which show full informations',
      \}
function! s:converter.filter(candidates, context) " {{{
  for candidate in a:candidates
    let candidate.abbr = s:format_gist(candidate.source__gist)
  endfor
  return a:candidates
endfunction " }}}


function! unite#filters#converter_gista_full#define() " {{{
  return s:converter
endfunction " }}}

let &cpo = s:save_cpo
unlet s:save_cpo
"vim: sts=2 sw=2 smarttab et ai textwidth=0 fdm=marker
