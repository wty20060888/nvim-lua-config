local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
    vim.notify("没有找到 nvim-tree")
  return
end


-- 列表操作快捷键
local list_keys = require('keybindings').nvimTreeList
--nvim_tree.setup({
--    -- 不显示 git 状态图标
--    git = {
--        enable = true,
--    },
--    -- project plugin 需要这样设置
--    update_cwd = true,
--    update_focused_file = {
--        enable = true,
--        update_cwd = true,
--    },
--    -- 隐藏 .文件 和 node_modules 文件夹
--    filters = {
--        dotfiles = true,
--        custom = { 'node_modules' },
--    },
--    view = {
--        -- 宽度
--        width = 30,
--        -- 也可以 'right'
--        side = 'left',
--        -- 隐藏根目录
--        hide_root_folder = false,
--        -- 自定义列表中快捷键
--        mappings = {
--            custom_only = false,
--            list = list_keys,
--        },
--        -- 不显示行数
--        number = false,
--        relativenumber = false,
--        -- 显示图标
--        signcolumn = 'yes',
--    },
--    actions = {
--        open_file = {
--            -- 首次打开大小适配
--            resize_window = true,
--            -- 打开文件时关闭
--            quit_on_open = false,
--        },
--    },
--    -- wsl install -g wsl-open
--    -- https://github.com/4U6U57/wsl-open/
--    system_open = {
--        cmd = 'open', -- mac 直接设置为 open
--    },
--})
-- 自动关闭
vim.cmd([[
  autocmd BufEnter * if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])




nvim_tree.setup({
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = true,
  open_on_tab = true,
  sort_by = "name",
  view = {
    width = 30,
    --height = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = list_keys,
    },
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "open",
    args = {"-R"},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
}
)
