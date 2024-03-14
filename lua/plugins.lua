local packer = require("packer")
local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  vim.notify("gitsigns not found!")
  return
end

gitsigns.setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000, follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 100,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  -- keymapping
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Navigation
    map('n', '<leader>j', ':Gitsigns next_hunk<CR>')
    map('n', '<leader>k',':Gitsigns prev_hunk<CR>')

    -- Actions 
    map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
    map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
    map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
    map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
    map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')
    --
    -- Text object
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'
    -- tokyonight
    use("folke/tokyonight.nvim")
    -- nvim-tree
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional
      },
    }
    -- bufferline
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })
    -- lualine
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
    use("arkav/lualine-lsp-progress")
    -- telescope
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }
    -- treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    -- icons
    use "kyazdani42/nvim-web-devicons"
    use 'mortepau/codicons.nvim'
    -- vim surround
    use "tpope/vim-surround"
    use "tpope/vim-repeat" --  . command enhance
    -- LSP
    --use("williamboman/nvim-lsp-installer")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    -- Lspconfig
    use({ "neovim/nvim-lspconfig" })
    -- 补全引擎
    use("hrsh7th/nvim-cmp")
    -- snippet 引擎
    use("hrsh7th/vim-vsnip")
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp")    -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer")      -- { name = 'buffer' },
    use("hrsh7th/cmp-path")        -- { name = 'path' }
    use("hrsh7th/cmp-cmdline")     -- { name = 'cmdline' }
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lua"
    use "ray-x/cmp-treesitter"
    use "f3fora/cmp-spell" -- spell check
    -- 常见编程语言代码段
    use("rafamadriz/friendly-snippets")
    -- toggle terminal
    use "akinsho/toggleterm.nvim"
    -- Jupyter.nvim
    use 'hkupty/iron.nvim'
    -- show function signature when typing
    use "ray-x/lsp_signature.nvim"
    -- code action
    use "kosayoda/nvim-lightbulb"
    -- ui
    use("onsails/lspkind-nvim")
    -- matchup search
    use "andymass/vim-matchup"
    use { 'kevinhwang91/nvim-hlslens' }
    use {
      "phaazon/hop.nvim", -- like easymotion, but more powerful
      branch = "v1",      -- optional but strongly recommended
    }
    -- PreviewMarkdown
    use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
})
    -- install without yarn or npm

--    use({
--      "iamcco/markdown-preview.nvim",
--      run = "cd app && npm install",
--      setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
--      ft = { "markdown" },
--    })
    --markdown paste
    use { "md-img-paste-devs/md-img-paste.vim" }
    --markdown table mode
    use { "dhruvasagar/vim-table-mode" }
    -- Git
    use {
      "lewis6991/gitsigns.nvim"
    }
    use 'sindrets/diffview.nvim'
    -- use "tanvirtin/vgit.nvim"
    -- use "tpope/vim-fugitive"
    -- Debugger
    use "ravenxrz/DAPInstall.nvim" -- help us install several debuggers
    use {
      "mfussenegger/nvim-dap",
      -- commit = "f9480362549e2b50a8616fe4530deaabbc4f889b",
    }
    use "theHamsta/nvim-dap-virtual-text"
    use "rcarriga/nvim-dap-ui"
    use "mfussenegger/nvim-dap-python"                          -- debug python
    -- use { "leoluz/nvim-dap-go", module = "dap-go" } -- debug golang
    use { "jbyuki/one-small-step-for-vimkind", module = "osv" } -- debug any Lua code running in a Neovim instance
    use {
      "ravenxrz/nvim-gdb",
      run = "./install.sh"
    }
    use "jiangmiao/auto-pairs"
    -- indent-blankline
    use "lukas-reineke/indent-blankline.nvim"
    -- 代码折叠
    use 'sheerun/vim-polyglot'
    -- markdown脑图
    use "Zeioth/markmap.nvim"
  end,
  config = {
    -- 并发数限制
    max_jobs = 16,
    -- 自定义源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
  },
})
