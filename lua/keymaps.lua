local M = {}

M.leader_key = ' '
M.treesitter = {
  incremental_selection = {
    -- a least frequently used key for call it later.
    init_selection = '<C-1>',
    node_incremental = '<CR>',
    node_decremental = '<BS>',
    scope_incremental = '<TAB>',
  },
  toggle_tsc = '<LEADER>ut',
}
M.whichkey = {
  toggle_wk = '<LEADER>k',
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
  eq_size = '<LEADER>=',
  init_inc_selection = '<CR>',
  move_windows = '<LEADER>wm',
}
M.tab = {
  new = '<LEADER>tn',
  close = '<LEADER>tc',
  prev = '<C-[>',
  next = '<C-]>',
}
M.float_window = {
  scroll_up = '<C-UP>',
  scroll_down = '<C-DOWN>',
  scroll_left = '<C-LEFT>',
  scroll_right = '<C-RIGHT>', 
}
M.line = {
  move_down = '<A-j>',
  move_up = '<A-k>',
}
M.nvimtree = {
  toggle = '<LEADER>e',
  toggle_preview = '<TAB>',
}
M.format = {
  format = '<LEADER>f',
  format_injected = '<LEADER>cf',
}
M.lsp = {
  definition = 'gd',
  declaration = 'gD',
  show_references = 'gr',
  implementation = 'gI',
  type_definition = 'gT',
  hover = 'gh',
  signature_help = 'gH',
  pop_diagnostic = 'gp',
  code_action = '<LEADER>ca',
  code_action_source = '<LEADER>cA',
  rename = '<LEADER>r',
}
M.telescope = {
  switch_buffer = '<LEADER>,',
  grep = '<LEADER>/',
  find = '<LEADER>?',
  commands = '<LEADER>:',
  commands_history = '<LEADER>;',
  git_commits = '<LEADER>sc',
  git_status = '<LEADER>ss',
  registers = '<LEADER>s"',
  autocmd = '<LEADER>sa',
  doc_diagnostics = '<LEADER>sd',
  workspace_diagnostics = '<LEADER>sD',
  highlights = '<LEADER>sh',
  keymaps = '<LEADER>sk',
  marks = '<LEADER>sm',
  options = '<LEADER>so',
  colorscheme = '<LEADER>uC',
  select_tab = '<C-t>',
  move_selection_next = '<C-j>',
  move_selection_previous = '<C-k>',
  cycle_history_next = '<S-TAB>',
  cycle_history_prev = '<TAB>',
  select_vertical = '<C-v>',
  select_horizontal = '<C-h>',
  close = 'q',
  scroll_left = M.float_window.scroll_left,
  scroll_right = M.float_window.scroll_right,
  scroll_down = M.float_window.scroll_down,
  scroll_up = M.float_window.scroll_up,
}
M.gitsigns = {
  next_hunk = ']h',
  prev_hunk = '[h',
  preview_hunk = '<LEADER>hp',
  blame_line = '<LEADER>hb',
  diff = '<LEADER>hD',
  diff_tilde = '<LEADER>hd',
}
return M
