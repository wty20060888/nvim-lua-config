require "lsp_signature".setup({
  debug = false, -- set to true to enable debug logging
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
  -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
  -- set to 0 if you DO NOT want any API comments be shown
  -- This setting only take effect in insert mode, it does not affect signature help in normal
  -- mode, 10 by default

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  floating_window_off_x = 1, -- adjust float windows x position.
  floating_window_off_y = 0, -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
--    floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
--    local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
--    local pumheight = vim.o.pumheight
--    local winline = vim.fn.winline() -- line number in the window
--    local winheight = vim.fn.winheight(0)
--
--    -- window top
--    if winline - 1 < pumheight then
--      return 1
--
--    -- window bottom
--    elseif winheight - winline < pumheight then
--      return -1
--    else
--      return 1
--    end
--  end,
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  max_height = 8, -- max height of signature floating_window, if content is more than max_height, you can scroll down
  -- to view the hiding contents
  max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "rounded"   -- double, rounded, single, shadow, none
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Blue', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = "<M-x>", -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
  move_cursor_key = "<C-w>"-- imap, use nvim_set_current_win to move cursor between current win and floating
})

--local function escape_term_codes(str)
--  return vim.api.nvim_replace_termcodes(str, true, false, true)
--end
--
--local function is_float_open(window_id)
--  return window_id and window_id ~= 0 and vim.api.nvim_win_is_valid(window_id)
--end
--
--local function scroll_float(mapping)
--  -- Using the global config of the lsp_signature plugin
--  local window_id = _G._LSP_SIG_CFG.winnr
--
--  if is_float_open(window_id) then
--    vim.fn.win_execute(window_id, 'normal! ' .. mapping)
--  end
--end
--
--local map = vim.keymap.set
--local opts = { noremap = true, silent = true }
--local scroll_up_mapping = escape_term_codes('<C-K>')
--local scroll_down_mapping = escape_term_codes('<C-J>')
--map('i', '<C-K>', function() scroll_float(scroll_up_mapping) end, opts)
--map('i', '<C-J>', function() scroll_float(scroll_down_mapping) end, opts)
