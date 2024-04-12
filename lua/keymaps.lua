local M = {}

M.treesitter = {
  incremental_selection = {
    -- a least frequently used key for call it later.
    init_selection = '<C-1>',
    node_incremental = '<CR>',
    node_decremental = '<BS>',
    scope_incremental = '<TAB>',
  },
  toggle_tsc = '<leader>ut', 
}
M.whichkey = {
  toggle_wk = '<LEADER>k'
}
M.window = {
  goto_left = '<C-h>',
  goto_lower = '<C-j>',
  goto_upper = '<C-k>',
  goto_right = '<C-l>',
  inc_height = '<C-UP>',
  dec_height = '<C-DOWN>',
  inc_width = '<C-LEFT>',
  dec_width = '<C-RIGHT>',
  close = '<LEADER>wc',
  close_other = '<LEADER>wo',
  split_below = '<LEADER>-',
  split_right = '<LEADER>|',
  eq_size = '<LEADER>w=',
  init_inc_selection = '<CR>',
}
M.float_window = {
  scroll_up = '<>',
  scroll_down = '<>',
}
M.line = {
  move_down = '<A-j>',
  move_up = '<A-k>',
}
M.tab = {
  new = '<LEADER>tn',
  close = '<LEADER>tc',
}
M.nvimtree = {
  toggle = '<LEADER>e'
}
return M
