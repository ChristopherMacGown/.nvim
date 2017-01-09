" -----------------------------------------------------------------------------
" File: muvbox.vim
" Description: Retro groove color scheme for Airline
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/muvbox
" Last Modified: 22 Aug 2014
" -----------------------------------------------------------------------------

let g:airline#themes#muvbox#palette = {}

let s:M0 = airline#themes#get_highlight('Identifier')
let s:accents_group = airline#themes#get_highlight('Special')
let s:modified_group = [s:M0[0], '', s:M0[2], '', '']
let s:warning_group = airline#themes#get_highlight2(['Normal', 'bg'], ['Question', 'fg'])
let s:error_group = airline#themes#get_highlight2(['Normal', 'bg'], ['WarningMsg', 'fg'])

let s:N1 = airline#themes#get_highlight2(['Normal', 'bg'], ['StatusLineNC', 'bg'])
let s:N2 = airline#themes#get_highlight2(['StatusLineNC', 'bg'], ['StatusLineNC', 'fg'])
let s:N3 = airline#themes#get_highlight2(['StatusLineNC', 'bg'], ['CursorLine', 'bg'])
let g:airline#themes#muvbox#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#muvbox#palette.normal_modified = { 'airline_c': s:modified_group }
let g:airline#themes#muvbox#palette.normal.airline_warning = s:warning_group
let g:airline#themes#muvbox#palette.normal_modified.airline_warning = s:warning_group
let g:airline#themes#muvbox#palette.normal.airline_error = s:error_group
let g:airline#themes#muvbox#palette.normal_modified.airline_error = s:error_group

let s:I1 = airline#themes#get_highlight2(['Normal', 'bg'], ['Identifier', 'fg'])
let s:I2 = s:N2
let s:I3 = airline#themes#get_highlight2(['Normal', 'fg'], ['StatusLineNC', 'fg'])
let g:airline#themes#muvbox#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#muvbox#palette.insert_modified = g:airline#themes#muvbox#palette.normal_modified
let g:airline#themes#muvbox#palette.insert.airline_warning = g:airline#themes#muvbox#palette.normal.airline_warning
let g:airline#themes#muvbox#palette.insert_modified.airline_warning = g:airline#themes#muvbox#palette.normal_modified.airline_warning
let g:airline#themes#muvbox#palette.insert.airline_error = g:airline#themes#muvbox#palette.normal.airline_error
let g:airline#themes#muvbox#palette.insert_modified.airline_error = g:airline#themes#muvbox#palette.normal_modified.airline_error

let s:R1 = airline#themes#get_highlight2(['Normal', 'bg'], ['Structure', 'fg'])
let s:R2 = s:I2
let s:R3 = s:I3
let g:airline#themes#muvbox#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
let g:airline#themes#muvbox#palette.replace_modified = g:airline#themes#muvbox#palette.normal_modified
let g:airline#themes#muvbox#palette.replace.airline_warning = g:airline#themes#muvbox#palette.normal.airline_warning
let g:airline#themes#muvbox#palette.replace_modified.airline_warning = g:airline#themes#muvbox#palette.normal_modified.airline_warning
let g:airline#themes#muvbox#palette.replace.airline_error = g:airline#themes#muvbox#palette.normal.airline_error
let g:airline#themes#muvbox#palette.replace_modified.airline_error = g:airline#themes#muvbox#palette.normal_modified.airline_error

let s:V1 = airline#themes#get_highlight2(['Normal', 'bg'], ['ModeMsg', 'fg'])
let s:V2 = s:N2
let s:V3 = airline#themes#get_highlight2(['Normal', 'bg'], ['TabLine', 'fg'])
let g:airline#themes#muvbox#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#muvbox#palette.visual_modified = { 'airline_c': [ s:V3[0], '', s:V3[2], '', '' ] }
let g:airline#themes#muvbox#palette.visual.airline_warning = g:airline#themes#muvbox#palette.normal.airline_warning
let g:airline#themes#muvbox#palette.visual_modified.airline_warning = g:airline#themes#muvbox#palette.normal_modified.airline_warning
let g:airline#themes#muvbox#palette.visual.airline_error = g:airline#themes#muvbox#palette.normal.airline_error
let g:airline#themes#muvbox#palette.visual_modified.airline_error = g:airline#themes#muvbox#palette.normal_modified.airline_error

let s:IA = airline#themes#get_highlight2(['TabLine', 'fg'], ['CursorLine', 'bg'])
let g:airline#themes#muvbox#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#muvbox#palette.inactive_modified = { 'airline_c': s:modified_group }

let g:airline#themes#muvbox#palette.accents = { 'red': s:accents_group }

let s:TF = airline#themes#get_highlight2(['Normal', 'bg'], ['Normal', 'bg'])
let g:airline#themes#muvbox#palette.tabline = {
  \ 'airline_tab':  s:N2,
  \ 'airline_tabsel':  s:N1,
  \ 'airline_tabtype':  s:V1,
  \ 'airline_tabfill':  s:TF,
  \ 'airline_tabhid':  s:IA,
  \ 'airline_tabmod':  s:I1
  \ }
