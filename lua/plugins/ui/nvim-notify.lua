local Lazyvim = require('lazyvim')
local Keys = require('keymaps').notify

return {
  'rcarriga/nvim-notify',
  cond = vim.g.vscode == nil,
  keys = {
    {
      Keys.dismiss_all,
      function()
        require('notify').dismiss({ silent = true, pending = true })
      end,
      desc = 'Dismiss all Notifications',
    },
    { Keys.show_all, '<CMD>Telescope notify<CR>', desc = 'Notifications' },
  },
  opts = {
    timeout = 2000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
  },
  init = function()
    -- when noice is not enabled, install notify on VeryLazy
    if not Lazyvim.has('noice.nvim') then
      Lazyvim.on_very_lazy(function()
        vim.notify = require('notify')
      end)
    end
  end,
}
