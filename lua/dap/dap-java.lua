local dap = require('dap')

dap.adapters.java = {
  type = 'executable',
  command = 'java',
  args = {'-jar', '/Users/wangtianyu/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'}

}

dap.configurations.java = {
  {
    type = 'java',
    request = 'launch',
    name = 'Debug (Attach) - Remote',
    hostName = 'localhost',
    port = 5005
  }
}
