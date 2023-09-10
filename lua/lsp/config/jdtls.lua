vim.cmd [[
let g:jdtls_start_server_async = 0
]]

return {
  settings = {

    java = {
      analysis = {
        typeCheckingMode = "off"
      }
    }
  },
}
