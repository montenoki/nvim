local Lazyvim = require('lazyvim')
local Keys = require('keymaps')
return {
  'folke/noice.nvim',
  cond = vim.g.vscode == nil,
  event = 'VeryLazy',
  dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
  opts = {
    lsp = {
      progress = {
        enabled = true,
        -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
        -- See the section on formatting for more details on how to customize.
        format = 'lsp_progress',
        format_done = 'lsp_progress_done',
        throttle = 1000 / 30, -- frequency to update lsp progress message
        view = 'mini',
      },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
          },
        },
        view = 'mini',
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
    cmdline = {
      view = 'cmdline_popup',
      format = {
        cmdline = { icon = '󰞷' },
        search_down = { icon = '🔍⌄' },
        search_up = { icon = '🔍⌃' },
        filter = { icon = '󰈲' },
        lua = { icon = '☾' },
        help = { icon = '󰋖' },
      },
    },
    format = {
      level = {
        icons = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = '󰌵 ',
        },
      },
    },
    popupmenu = {
      kind_icons = vim.g.lite_mode and false or {},
    },
    inc_rename = {
      cmdline = {
        format = {
          IncRename = { icon = '⟳' },
        },
      },
    },
  },
    -- stylua: ignore
    keys = {
      { Keys.noice.redirect_cmdline, function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { Keys.noice.last_msg, function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { Keys.noice.history, function() require("noice").cmd("history") end, desc = "Noice History" },
      { Keys.noice.all, function() require("noice").cmd("all") end, desc = "Noice All" },
      { Keys.noice.dismiss_all, function() require("noice").cmd("dismiss") end, desc = "Dismiss All Noice" },
      {
        Keys.float_window.scroll_down,
        function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" },
      },
      {
        Keys.float_window.scroll_up,
        function() if not require("noice.lsp").scroll(-4) then return "<C-b>" end end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" },
      },
    },
}
