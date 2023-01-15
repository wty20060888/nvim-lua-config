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

vim.api.nvim_create_user_command('Terminatedap',
  function()
    vim.cmd([[lua require'dap'.terminate()]])
  end,
  { nargs = "*"})

return M
