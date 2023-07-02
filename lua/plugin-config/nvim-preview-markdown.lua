vim.cmd([[
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
let g:EclimCompletionMethod = 'omnifunc'


command! -nargs=* Run :call RunBuild(<f-args>)
func! RunBuild(...)
  exec "w"
      if &filetype == "c"
        exec "!g++ -g *.c -o %<"
	let params=""
	for item in a:000
		let params=params.item." "
	endfor
        exec "!time ./%< ".params
      elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
      elseif &filetype == 'java'
        "exec "!javac %"
        exec "ter java %"
      elseif &filetype == 'sh'
        exec ":!time bash %"
      elseif &filetype == 'python'
        silent! exec "!clear"
	let params=""
	for item in a:000
		let params=params.item." "
	endfor
        exec "ter python3.10 % ".params
      elseif &filetype == 'html'
        exec "!open %"
      elseif &filetype == 'markdown'
        exec "MarkdownPreview"
      elseif &filetype == 'vimwiki'
        exec "MarkdownPreview"
      endif
endfunc
]])
