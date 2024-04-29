local Keys = require('keymaps').session
local Lazyvim = require('lazyvim')
return {
  {
    'rmagatti/auto-session',
    cond = vim.g.vscode == nil,
    lazy = false,
    keys = {
      { Keys.save, '<CMD>SessionSave<CR>', desc = 'Session Save' },
      { Keys.restore, '<CMD>SessionRestore<CR>', desc = 'Session Restore' },
      { Keys.del, '<CMD>SessionDelete<CR>', desc = 'Session Delete' },
      { Keys.show_all, '<CMD>Telescope session-lens<CR>', desc = 'Show All Session' },
    },
    opts = {
      log_level = vim.log.levels.ERROR,
      auto_session_suppress_dirs = {
        '~/',
        '~/Projects',
        '~/Downloads',
        '/',
        '~/codes',
      },
      auto_session_enabled = true,
      auto_session_create_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_use_git_branch = true,
      auto_session_enable_last_session = false,
      {
        -- ⚠️ This will only work if Telescope.nvim is installed
        -- The following are already the default values, no need to provide them if these are already the settings you want.
        session_lens = {
          -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
          buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
      },
    },
  },
  {
    'lualine.nvim',
    opts = function(_, opts)
      local ok, _ = pcall(require('auto-session.lib').current_session_name)
      table.insert(opts.sections.lualine_c, 2, {
        function()
          return ok and ' ON' or ' OFF'
        end,
        ---@diagnostic disable-next-line: undefined-field
        color = ok and Lazyvim.ui.fg('Character') or Lazyvim.ui.fg('Comment'),
        on_click = function()
          vim.cmd.Telescope('session-lens')
        end,
      })
    end,
  },
}
