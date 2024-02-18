-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- leader key 为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = {
  noremap = true,
  silent = true,
}

local term_opts = { silent = true }

-- 本地变量
local map = vim.api.nvim_set_keymap

-- 基本按键设置
vim.cmd("map H 0")
vim.cmd("map L $")
vim.cmd("map J 5j")
vim.cmd("map K 5k")
vim.cmd("map <leader><cr> :nohlsearch<cr>")
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opts)
map("n", "<A-j>", "<C-w>j", opts)
map("n", "<A-k>", "<C-w>k", opts)
map("n", "<A-l>", "<C-w>l", opts)
-- Better terminal navigation
map("t", "<ESC>", "<C-\\><C-N>", term_opts)

-- 插件快捷键
local pluginKeys = {}

-- nvim-tree
-- alt + m 键打开关闭tree
map("n", "<A-t>", ":NvimTreeToggle<CR>", opts)


-- 列表快捷键
pluginKeys.nvimTreeList = {
  -- 打开文件或文件夹
  { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
  -- 分屏打开文件
  --{ key = "v", action = "vsplit" },
  --{ key = "h", action = "split" },
  -- 显示隐藏文件
  { key = "i",                              action = "toggle_custom" },   -- 对应 filters 中的 custom (node_modules)
  { key = ".",                              action = "toggle_dotfiles" }, -- Hide (dotfiles)
  -- 文件操作
  { key = "<F5>",                           action = "refresh" },
  { key = { "<CR>", "l", "<2-LeftMouse>" }, action = "edit" },
  { key = "a",                              action = "create" },
  { key = "d",                              action = "remove" },
  { key = "r",                              action = "rename" },
  { key = "x",                              action = "cut" },
  { key = "c",                              action = "copy" },
  { key = "p",                              action = "paste" },
  { key = "o",                              action = "system_open" },
  { key = "<BS>",                           action = "toggle_dotfiles" },
  { key = "H",                              action = "" },
  { key = "yrp",                            action = "copy_path" },
  { key = "yap",                            action = "copy_absolute_path" },
}
-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opts)
-- 关闭
--"moll/vim-bbye"
map("n", "<leader>q", ":Bdelete!<CR>", opts)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opts)
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opts)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opts)

-- Telescope
-- 查找文件
map("n", "<leader>f", ":Telescope find_files<CR>", opts)
-- 全局搜索
map("n", "<leader>g", ":Telescope live_grep<CR>", opts)

-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    ["<Down>"] = "move_selection_next",
    ["<Up>"] = "move_selection_previous",
    -- 历史记录
    ["<C-n>"] = "cycle_history_next",
    ["<C-p>"] = "cycle_history_prev",
    -- 关闭窗口
    ["<C-c>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
}

-- lsp 回调函数快捷键设置

-- lsp 回调函数快捷键设置
-- rename
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
-- code action
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
-- go xx
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- diagnostic
map("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
map("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
map("n", "gf", "<cmd>lua vim.lsp.buf.format {async = true}<CR>", opts)

-- copilot map按右键自动补全
vim.cmd [[imap <silent><script><expr> <Right> copilot#Accept("\<Right>")
let g:copilot_no_tab_map = v:true
]]
-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  return {
    -- 出现补全
    ["<C-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- 取消
    ["<C-o>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close()
    }),
    -- 上一个
    ["<Up>"] = cmp.mapping.select_prev_item(),
    -- 下一个
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    -- 确认
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace
    }),
    -- 如果窗口内容太多，可以滚动
    ["<C-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }
end

-- iron
map("n", "<leader>ju", ":IronRepl<cr>", opts)
map("v", "<leader>s", "y<C-w>jpi<cr><C-\\><C-N><C-w>k", term_opts)
-- dap
map("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
map("n", "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", opts)
-- keymap("n", "<leader>dr", "lua require'dap'.repl.open()<cr>", opts)
map("n", "<F9>", "<cmd>lua require'dap'.run_last()<cr>", opts)
map('n', '<F10>', '<cmd>lua require"user.dap.dap-util".reload_continue()<CR>', opts)
map("n", "<F4>", "<cmd>lua require'dap'.terminate()<cr>", opts)
map("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>;", opts)
map("n", "<leader>d", ":DapStart<cr>", opts)
map("n", "<F7>", "<cmd>lua require'dap'.step_over()<cr>", opts)
map("n", "<F6>", "<cmd>lua require'dap'.step_into()<cr>", opts)
map("n", "<F8>", "<cmd>lua require'dap'.step_out()<cr>", opts)
map("n", "ge", "<cmd>lua require'dapui'.eval()<cr>", opts)

return pluginKeys
