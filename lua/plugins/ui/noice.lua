local Keys = require('keymaps')
local Lazyvim = require('lazyvim')
return {
  {
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
              { find = '%d fewer lines' },
              { find = '%d more lines' },
              { find = '--No lines in buffer--' },
              { find = 'File Formatted' },
            },
          },
          view = 'mini',
        },
        {
          filter = {
            event = 'notify',
            any = {
              { find = 'File Formatted.' },
            },
          },
          view = 'mini',
        },
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = 'search hit BOTTOM, continuing at TOP' },
            },
          },
          opts = { skip = true },
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
          calculator = { view = 'cmdline' },
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
        kind_icons = vim.g.lite ~= nil and {},
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
  },
  {
    'lualine.nvim',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_y, {
        require('noice').api.status.command.get,
        cond = require('noice').api.status.command.has,
        color = Lazyvim.ui.fg('Character'),
        icon = vim.g.lite == nil and '' or '',
      })
    end,
  },
}
