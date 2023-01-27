local packer = require("packer")
packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'
    -- tokyonight
    use("folke/tokyonight.nvim")
    -- nvim-tree
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
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
    use("williamboman/nvim-lsp-installer")
    -- Lspconfig
    use({ "neovim/nvim-lspconfig" })
    -- 补全引擎
    use("hrsh7th/nvim-cmp")
    -- snippet 引擎
    use("hrsh7th/vim-vsnip")
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
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
      branch = "v1", -- optional but strongly recommended
    }
    -- PreviewMarkdown
    use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })
    use {
      "skanehira/preview-markdown.vim",
      opt = true,
      cmd = "PreviewMarkdown",
    }
    --markdown paste
    use { "md-img-paste-devs/md-img-paste.vim" }
    --markdown table mode
    use { "dhruvasagar/vim-table-mode" }
    -- Git
    use {
      "lewis6991/gitsigns.nvim",
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
    use "mfussenegger/nvim-dap-python" -- debug python
    -- use { "leoluz/nvim-dap-go", module = "dap-go" } -- debug golang
    use { "jbyuki/one-small-step-for-vimkind", module = "osv" } -- debug any Lua code running in a Neovim instance
    use {
      "ravenxrz/nvim-gdb",
      run = "./install.sh"
    }
    use "jiangmiao/auto-pairs"

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
