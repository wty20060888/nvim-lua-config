local status_ok, dapui = pcall(require, 'dapui')
if not status_ok then
  vim.notify("dapui not found")
  return
end

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "o", "<2-LeftMouse>", "<CR>" },
    open = "O",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        'scopes',
      },
      size = 20,
      position = 'left',
    },
    {
      elements = {
        'stacks',
        'breakpoints',
        'watches',
      },
      size = 20,
      position = 'right',
    },
    --{
    --  elements = {
    --    'console',
    --  },
    --  size = 5,
    --  position = 'top',
    --},
    {
      elements = {
        'repl',
      },
      size = 8,
      position = 'bottom',
  },

    controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
    },
  },
  -- sidebar = {
  --   -- You can change the order of elements in the sidebar
  --   elements = {
  --     -- Provide as ID strings or tables with "id" and "size" keys
  --     {
  --       id = "scopes",
  --       size = 0.35, -- Can be float or integer > 1
  --     },
  --     { id = "stacks", size = 0.35 },
  --     { id = "watches", size = 0.15 },
  --     { id = "breakpoints", size = 0.15 },
  --   },
  --   size = 40,
  --   position = "left", -- Can be "left", "right", "top", "bottom"
  -- },
  -- tray = {
  --   elements = { "repl" },
  --   size = 5,
  --   position = "bottom", -- Can be "left", "right", "top", "bottom"
  -- },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
}
})
