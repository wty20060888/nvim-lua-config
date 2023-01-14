local dap_install = require("dap-install")
    local dap = require('dap')
    dap.configurations.python = {
      {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
          return '/usr/bin/python'
        end;
      },
    }

  dap.adapters.python = {
    type = 'executable';
    --command = '/usr/local/bin/python3';
    command = "python3";

    args = { '-m', 'debugpy.adapter' };
  }

dap_install.config(
	"python",
  {}
  -- { -- use default config
  --     adapters = {
  --         type = "executable",
  --         command = "/home/raven/.local/share/nvim/dapinstall/python/bin/python",
  --         args = {"-m", "debugpy.adapter"}
  --     },
  --     configurations = {
  --         {
  --             type = "python",
  --             request = "launch",
  --             name = "Launch file",
  --             program = "${file}",
  --             pythonPath = function()
  --               return "/usr/bin/python"
  --             end,
  --         },
  --     }
-- }
)
