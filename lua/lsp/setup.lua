--local lsp_installer = require("nvim-lsp-installer")
local lspconfig_window = require("lspconfig.ui.windows")
local old_defaults = lspconfig_window.default_opts


require("mason").setup({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    },
    border = "rounded"
  }

})
require("mason-lspconfig").setup({
  ensure_installed = {
    "pyright",
    "jdtls",
  },

})



--vim.api.nvim_win_set_config(0, { border = 'rounded' })
-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
  pyright = require("lsp.config.pyright"), -- lua/lsp/config/pyright.lua
  jdtls = require("lsp.config.jdtls"),     -- lua/lsp/config/jdtls.lua
}
-- 自动安装 Language Servers
settings = {

  python = {
    analysis = {
      typeCheckingMode = "off"
    }
  }
}
--for name, _ in pairs(servers) do
--  local server_is_found, server = lsp_installer.get_server(name)
--  if server_is_found then
--    if not server:is_installed() then
--      print("Installing " .. name)
--      server:install()
--    end
--  end
--end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>o', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'gj', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'gk', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>e', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gp', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-o>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gf', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup {
  --on_attach = on_attach,
  --flags = lsp_flags,
  cmd = {'pyright-langserver', '--stdio' },
  root_dir = require('lspconfig').util.root_pattern('.git', 'manage.py', 'setup.py', 'pyproject.toml', 'poetry.lock','requirements.txt'),
  filetypes = { 'python' },
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      }
    }
  },
}

require("lspconfig")["sumneko_lua"].setup {
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require('lspconfig')['clangd'].setup {
  on_attach = on_attach,
  flags = lsp_flags,
}
require('lspconfig')['jdtls'].setup {
  on_attach = on_attach,
  single_file_support = true,
}
require('lspconfig')['html'].setup {
  on_attach = on_attach,
  filetypes = { "html", "djangohtml" }, -- 包括"django-html"文件类型
}

--TODO: arduino lsp server启动问题
--require("lspconfig")["arduino_language_server"].setup{
--  on_attach = on_attach,
--  flags = lsp_flags,
--
--      cmd = {
--        "arduino-language-server",
--        "-cli-config", "/Users/wangtianyu/Library/Arduino15/arduino-cli.yaml",
--        "-fqbn",
--        "arduino:avr:uno"
--    }
--
--}
