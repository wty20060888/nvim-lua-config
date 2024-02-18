--local status, nvim_tree = pcall(require, "nvim-tree")
--if not status then
--    vim.notify("没有找到 nvim-tree")
--  return
--end
--
--
---- 列表操作快捷键
--local list_keys = require('keybindings').nvimTreeList
----nvim_tree.setup({
----    -- 不显示 git 状态图标
----    git = {
----        enable = true,
----    },
----    -- project plugin 需要这样设置
----    update_cwd = true,
----    update_focused_file = {
----        enable = true,
----        update_cwd = true,
----    },
----    -- 隐藏 .文件 和 node_modules 文件夹
----    filters = {
----        dotfiles = true,
----        custom = { 'node_modules' },
----    },
----    view = {
----        -- 宽度
----        width = 30,
----        -- 也可以 'right'
----        side = 'left',
----        -- 隐藏根目录
----        hide_root_folder = false,
----        -- 自定义列表中快捷键
----        mappings = {
----            custom_only = false,
----            list = list_keys,
----        },
----        -- 不显示行数
----        number = false,
----        relativenumber = false,
----        -- 显示图标
----        signcolumn = 'yes',
----    },
----    actions = {
----        open_file = {
----            -- 首次打开大小适配
----            resize_window = true,
----            -- 打开文件时关闭
----            quit_on_open = false,
----        },
----    },
----    -- wsl install -g wsl-open
----    -- https://github.com/4U6U57/wsl-open/
----    system_open = {
----        cmd = 'open', -- mac 直接设置为 open
----    },
----})
---- 自动关闭
--vim.cmd([[
--  autocmd BufEnter * if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
--]])
--
--
--
--
--nvim_tree.setup({
--  auto_reload_on_write = true,
--  disable_netrw = false,
--  hijack_cursor = false,
--  hijack_netrw = true,
--  hijack_unnamed_buffer_when_opening = false,
--  ignore_buffer_on_setup = false,
--  open_on_setup = false,
--  open_on_setup_file = true,
--  open_on_tab = true,
--  sort_by = "name",
--  view = {
--    width = 30,
--    --height = 30,
--    hide_root_folder = false,
--    side = "left",
--    preserve_window_proportions = false,
--    number = false,
--    relativenumber = false,
--    signcolumn = "yes",
--    mappings = {
--      custom_only = false,
--      list = list_keys,
--    },
--  },
--  renderer = {
--    indent_markers = {
--      enable = false,
--      icons = {
--        corner = "└ ",
--        edge = "│ ",
--        none = "  ",
--      },
--    },
--    icons = {
--      webdev_colors = true,
--    },
--  },
--  hijack_directories = {
--    enable = true,
--    auto_open = true,
--  },
--  update_focused_file = {
--    enable = true,
--    update_cwd = true,
--    ignore_list = {},
--  },
--  ignore_ft_on_setup = {},
--  system_open = {
--    cmd = "open",
--    args = {"-R"},
--  },
--  diagnostics = {
--    enable = true,
--    show_on_dirs = true,
--    icons = {
--      hint = "",
--      info = "",
--      warning = "",
--      error = "",
--    },
--  },
--  filters = {
--    dotfiles = false,
--    custom = {},
--    exclude = {},
--  },
--  git = {
--    enable = true,
--    ignore = true,
--    timeout = 400,
--  },
--  actions = {
--    use_system_clipboard = true,
--    change_dir = {
--      enable = true,
--      global = false,
--      restrict_above_cwd = false,
--    },
--    open_file = {
--      quit_on_open = false,
--      resize_window = true,
--      window_picker = {
--        enable = true,
--        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
--        exclude = {
--          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
--          buftype = { "nofile", "terminal", "help" },
--        },
--      },
--    },
--  },
--  trash = {
--    cmd = "trash",
--    require_confirm = true,
--  },
--  log = {
--    enable = false,
--    truncate = false,
--    types = {
--      all = false,
--      config = false,
--      copy_paste = false,
--      diagnostics = false,
--      git = false,
--      profile = false,
--    },
--  },
--})
--
--
--
--
--
--
--
-- disable netrw at the very start of your init.lua

--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
--
---- set termguicolors to enable highlight groups
--vim.opt.termguicolors = true
--
---- empty setup using defaults

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 60,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})


local api = require('nvim-tree.api')

local function opts(desc)
  return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

-- BEGIN_DEFAULT_ON_ATTACH
vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
vim.keymap.set('n', 'a', api.fs.create, opts('Create File Or Directory'))
vim.keymap.set('n', 'bd', api.marks.bulk.delete, opts('Delete Bookmarked'))
vim.keymap.set('n', 'bt', api.marks.bulk.trash, opts('Trash Bookmarked'))
vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle Filter: No Buffer'))
vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Filter: Git Clean'))
vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
vim.keymap.set('n', 'F', api.live_filter.clear, opts('Live Filter: Clear'))
vim.keymap.set('n', 'f', api.live_filter.start, opts('Live Filter: Start'))
vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Filter: Dotfiles'))
vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Filter: Git Ignore'))
vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
vim.keymap.set('n', 'M', api.tree.toggle_no_bookmark_filter, opts('Toggle Filter: No Bookmark'))
vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
vim.keymap.set('n', 'u', api.fs.rename_full, opts('Rename: Full Path'))
vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Filter: Hidden'))
vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
-- END_DEFAULT_ON_ATTACH
