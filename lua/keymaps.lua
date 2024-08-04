local M = {}
-- =============================================================================
--   Basic
-- =============================================================================
M.leader = ' '

M.window = {
    gotoLeft = '<LEADER>wh',
    gotoLower = '<LEADER>wj',
    gotoUpper = '<LEADER>wk',
    gotoRight = '<LEADER>wl',

    gotoLeftCtrl = '<C-h>',
    gotoLowerCtrl = '<C-j>',
    gotoUpperCtrl = '<C-k>',
    gotoRightCtrl = '<C-l>',

    close = '<LEADER>wc',
    closeOther = '<LEADER>wo',
    splitBelow = '<LEADER>-',
    splitRight = '<LEADER>|',
    resize = '<LEADER>=',
}

M.moveLineDown = '<A-j>'
M.moveLineUp = '<A-k>'

M.tab = {
    new = '<LEADER>tn',
    close = '<LEADER>tc',
    prev = '<LEADER>t,',
    next = '<LEADER>t.',
}
-- =============================================================================
--   Plugins
-- =============================================================================
M.open = {
    miniMap = '<LEADER>cm',
    leap = '\\',
    moveWindow = '<LEADER>wm',
    nvimTree = '<LEADER>e',
    preview = '<TAB>',
    navbuddy = '<LEADER>n',
}

M.whichkey = {
    show = '<LEADER>k',
    showLocal = '<LEADER>K',
}

M.toggle = {
    -- spelling = '<LEADER>us',
    -- line_numbers = '<LEADER>ul',
    -- relative_numbers = '<LEADER>uL',
    -- diagnostic = '<LEADER>ud',
    -- wrap = '<LEADER>uw',
    -- conceal = '<LEADER>uS',
    -- inlay_hints = '<LEADER>uh',
    -- treesitter = '<LEADER>uT',
    -- show_hl_info = '<LEADER>ui',
    -- toggle_tsc = '<LEADER>ut',
}

M.floatWindow = {
    scrollUp = '<C-UP>',
    scrollDown = '<C-DOWN>',
    scrollLeft = '<C-LEFT>',
    scrollRight = '<C-RIGHT>',
}

M.incrementalSelection = {
    init = '<CR>',
    -- a least frequently used key for call it later.
    initSelection = '<C-7>',
    nodeIncremental = '<CR>',
    scopeIncremental = '<TAB>',
    nodeDecremental = '<BS>',
}
M.comment = {
    line = 'gcc',
    block = 'gbc',
    v_line = 'gc',
    v_block = 'gb',
    above = 'gcO',
    below = 'gco',
    eol = 'gca',
}
M.surround = {
    add = 'gsa',
    delete = 'gsd',
    find = 'gsf',
    find_left = 'gsF',
    highlight = 'gsh',
    replace = 'gsr',
    update_n_lines = 'gsn',
}
M.lsp = {
    definition = 'gd',
    references = 'gr',
    implementation = 'gI',
    type_definition = 'gy',
    declaration = 'gD',
    hover = 'K',
    signature_help = 'gK',
    signature_help_insert = '<c-k>',
    pop_diagnostic = 'gp',
    code_action = '<LEADER>ca',
    rename = '<LEADER>r',
    runCodelensAction = '<LEADER>cc',
    refreshCodelens = '<LEADER>cC',
    organize = '<LEADER>co',
}
M.format = {
    format = '<LEADER>f',
    format_injected = '<LEADER>cf',
}
M.indentscope = {
  obj_scope = 'ii',
  obj_scope_with_border = 'ai',
  goto_top = '[i',
  goto_btm = ']i',
}
M.session = {
  save = '<LEADER>qs',
  restore = '<LEADER>qr',
  del = '<LEADER>qd',
  show_all = '<LEADER>qa',
}
M.cmp = {
  jump_in = '<C-n>',
}
M.notify = {
  dismiss_all = '<LEADER>un',
  show_all = '<LEADER>sna',
}

M.noice = {
  redirect_cmdline = '<C-2>',
  last_msg = '<LEADER>snl',
  history = '<LEADER>snh',
  dismiss_all = '<LEADER>snd',
}
M.todo = {
  show_todo = '<LEADER>st',
  show_all = '<LEADER>sT',
}
-- =============================================================================
--   TODO
-- =============================================================================

-- inc_height = '<C-UP>',
-- dec_height = '<C-DOWN>',
-- inc_width = '<C-LEFT>',
-- dec_width = '<C-RIGHT>',
--

-- -- =============================================================================
-- --   Plugins
-- -- =============================================================================
-- M.treesitter = {

-- }

-- M.format = {
--   format = '<LEADER>f',
--   format_injected = '<LEADER>cf',
-- }

-- M.telescope = {
--   switch_buffer = '<LEADER>,',
--   grep = '<LEADER>/',
--   find = '<LEADER>?',
--   commands = '<LEADER>:',
--   commands_history = '<LEADER>;',
--   git_commits = '<LEADER>sc',
--   git_status = '<LEADER>ss',
--   registers = '<LEADER>s"',
--   autocmd = '<LEADER>sa',
--   doc_diagnostics = '<LEADER>sd',
--   workspace_diagnostics = '<LEADER>sD',
--   highlights = '<LEADER>sh',
--   keymaps = '<LEADER>sk',
--   marks = '<LEADER>sm',
--   options = '<LEADER>so',
--   colorscheme = '<LEADER>uC',
--   select_tab = '<C-t>',
--   move_selection_next = '<C-j>',
--   move_selection_previous = '<C-k>',
--   cycle_history_next = '<S-TAB>',
--   cycle_history_prev = '<TAB>',
--   select_vertical = '<C-v>',
--   select_horizontal = '<C-h>',
--   close = 'q',
--   scroll_left = M.float_window.scroll_left,
--   scroll_right = M.float_window.scroll_right,
--   scroll_down = M.float_window.scroll_down,
--   scroll_up = M.float_window.scroll_up,
-- }
-- M.gitsigns = {
--   next_hunk = ']h',
--   prev_hunk = '[h',
--   preview_hunk = '<LEADER>hp',
--   blame_line = '<LEADER>hb',
--   diff = '<LEADER>hD',
--   diff_tilde = '<LEADER>hd',
-- }

-- M.indentscope = {
--   obj_scope = 'ii',
--   obj_scope_with_border = 'ai',
--   goto_top = '[i',
--   goto_btm = ']i',
-- }

-- M.noice = {
--   redirect_cmdline = '<C-2>',
--   last_msg = '<LEADER>snl',
--   history = '<LEADER>snh',
--   dismiss_all = '<LEADER>snd',
-- }
-- M.ufo = {
--   open_all = 'zR',
--   close_all = 'zM',
--   peek = 'K',
-- }
-- M.cmp = {
--   next_jump = '<TAB>',
--   prev_jump = '<S-TAB>',
--   confirm = '<CR>',
--   toggle = '<C-.>',
--   esc = '<ESC>',
-- }
-- M.neogit = { toggle = '<LEADER>g' }


-- M.project = {
--   show = '<LEADER>sp',
-- }
-- M.colorizer = {
--   toggle = '<LEADER>uc',
-- }

-- M.dap = {
--   ui = '<LEADER>du',
--   eval = '<LEADER>de',
--   breakpoint_cond = '<LEADER>dB',
--   breakpoint = '<LEADER>db',
--   continue = '<LEADER>dc',
--   run_with_args = '<LEADER>da',
--   run_to_cursor = '<LEADER>dC',
--   goto_line = '<LEADER>dg',
--   step_into = '<LEADER>di',
--   down = '<LEADER>dj',
--   up = '<LEADER>dk',
--   run_last = '<LEADER>dl',
--   step_out = '<LEADER>do',
--   step_over = '<LEADER>dO',
--   pause = '<LEADER>dp',
--   repl = '<LEADER>dr',
--   session = '<LEADER>ds',
--   terminate = '<LEADER>dt',
--   widgets = '<LEADER>dw',
-- }
-- M.diagnostic = {
--   show_line_diag = '<LEADER>xd',
--   next_diag = ']d',
--   prev_diag = '[d',
--   next_error = ']e',
--   prev_error = '[e',
--   next_warn = ']w',
--   prev_warn = '[w',
-- }

return M
