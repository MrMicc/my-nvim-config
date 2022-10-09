let g:vimspector_enable_mappings = 'HUMAN'

" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)

" for normal mode - the word under the cursor
nmap <Leader>de <Plug>VimspectorBalloonEval

" for visual mode, the visually selected text
xmap <Leader>de <Plug>VimspectorBalloonEval

nmap <Leader>bb <Plug>VimspectorToggleBreakpoint

" Debug continue
nmap <Leader>dc <Plug>VimspectorContinue

nmap <Leader>do <Plug>VimspectorStepOver

nmap <Leader>di <Plug>VimspectorStepInto

nmap <Leader>dx <Plug>VimspectorStepOut

" Open breakpoint windows
nmap <Leader>db <Plug>VimspectorBreakpoints

" Restart debug session with the same configuration
nmap <Leader>dr <Plug>VimspectorRestart

" Restart debug session with the same configuration
nmap <silent> <Leader>dr :call vimspector#Reset()<CR>

" Start debug java attach
nmap <silent> <Leader>dd :CocCommand java.debug.vimspector.start<CR>

let g:vimspector_sign_priority = {
  \    'vimspectorBP':         999,
  \    'vimspectorBPCond':     999,
  \    'vimspectorBPLog':      999,
  \    'vimspectorBPDisabled': 999,
  \    'vimspectorPC':         999,
  \ }
