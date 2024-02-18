local M = {}

M.SaveAndExit = function()
    -- wirte all buffer first
    vim.api.nvim_command(":wa")
    -- quit all buffer
    vim.api.nvim_command(":qa")
end


-- gtags
M.GtagsRefernce = function()
  local word = vim.api.nvim_call_function("expand", { "<cword>" })
  vim.api.nvim_command(":cs find c " .. word)
  vim.api.nvim_command(":copen")
end

M.GtagsText = function() 
  local word = vim.api.nvim_call_function("expand", { "<cword>" })
  vim.api.nvim_command(":cs find t " .. word)
  vim.api.nvim_command(":copen")
end

vim.api.nvim_create_user_command('ArduinoCompile',
  function(opts)
    if (opts.fargs[1] == "uno")
      then
    vim.cmd([[!arduino-cli compile --fqbn arduino:avr:uno ../%<]])
  elseif (opts.fargs[1] == "nodemcu")
    then
    vim.cmd([[!arduino-cli compile --fqbn esp8266:esp8266:nodemcuv2 ../%<]])
  end
  end,
  { nargs = "?" })

vim.api.nvim_create_user_command('ArduinoUpload',
  function(opts)
    if (opts.fargs[1] == "uno")
      then
    vim.cmd([[!arduino-cli upload -p $(find /dev//cu.usbmodem*) --fqbn arduino:avr:uno ../%<]])
    elseif (opts.fargs[1] == "nodemcu")
      then
    vim.cmd([[!arduino-cli upload -p $(find /dev//cu.wchusbserial*) --fqbn esp8266:esp8266:nodemcuv2 ../%<]])
  end
  end,
  { nargs = "?" })

vim.api.nvim_create_user_command('Picocom',
  function(opts)
    if (opts.fargs[1] == "uno")
      then
    vim.cmd(string.format("TermExec cmd='picocom -b %d $(find /dev//cu.usbmodem*)'", opts.fargs[2]))
  elseif (opts.fargs[1] == "nodemcu")
    then
    vim.cmd(string.format("TermExec cmd='picocom -b %d $(find /dev//cu.wchusbserial*)'", opts.fargs[2]))
  end
  end,
  { nargs = "*"})

vim.api.nvim_create_user_command('Tes',
--使用f-args的方法(与下面的方法一样效果)
  --"call v:lua.print([<f-args>][3])",
  function(opts)
    print(opts.fargs[1])
    for i,k in ipairs(opts.fargs) do
      print(i, k)
    end
  end,
  { nargs = "*"})

vim.api.nvim_create_user_command('DapStop',
  function()
    vim.cmd([[lua require'dap'.terminate()]])
    vim.cmd([[Copilot enable]])
  end,
  { nargs = "*"})

vim.api.nvim_create_user_command('DapRunLast',
  function()
    vim.cmd([[wall]])
    vim.cmd([[lua require'dap'.run_last()]])
  end,
  { nargs = "*"})

--QtDesigner
vim.api.nvim_create_user_command('QtDesigner',
  function()
    vim.cmd([[!PySide6-Designer &]])
  end,
  { nargs = "*"})


vim.api.nvim_create_user_command('DapStart',
  function()
    vim.cmd([[w]])
    vim.cmd([[Copilot disable]])
    vim.cmd([[lua require'dap'.continue()]])
  end,
  { nargs = "*"})
--vim.cmd([[autocmd BufEnter * :NvimTreeOpen<CR>]])
vim.cmd([[
function! DeleteHiddenBuffers()
    let i=1
    let lastbuf=bufnr("$")
    while i <= lastbuf
        if buflisted(i) && bufwinnr(i) == -1
        sil exe "bdelete" i
        endif
        let i=i+1
    endwhile
endfunction
]])
vim.cmd([[
augroup custom_term
    autocmd!
    autocmd TermOpen * setlocal bufhidden=hide
augroup END
]])
-- 代码折叠设置,按照缩进折叠
vim.cmd([[
" 检测文件类型
autocmd FileType html setlocal foldmethod=indent
autocmd FileType python setlocal foldmethod=indent
set nofoldenable


" 自动展开所有折叠
""autocmd FileType html autocmd BufReadPost * normal! zR
""autocmd FileType html autocmd BufWritePost * normal! zR
""autocmd FileType html autocmd BufNewFile * normal! zR
""autocmd FileType html autocmd BufEnter * normal! zR
""autocmd FileType python autocmd BufReadPost * normal! zR
""autocmd FileType python autocmd BufWritePre * normal! zR
""autocmd FileType python autocmd BufWritePost * normal! zR
""autocmd FileType python autocmd BufNewFile * normal! zR
""autocmd FileType python autocmd BufEnter * normal! zR

]])
vim.cmd([[
au BufNewFile,BufRead *.djangohtml,*.html set filetype=html
]])

return M


