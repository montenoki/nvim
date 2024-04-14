local Keys = require('keymaps').treesitter
local Lazyvim = require('lazyvim')

return {
  'nvim-treesitter/nvim-treesitter-context',
  cond = vim.g.vscode == nil,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
  enabled = true,
  opts = { mode = 'topline', max_lines = 3 },
  keys = {
    {
      Keys.toggle_tsc,
      function()
        local Lazyvim = require('lazyvim')
        local tsc = require('treesitter-context')
        tsc.toggle()
        if Lazyvim.inject.get_upvalue(tsc.toggle, 'enabled') then
          Lazyvim.info('Enabled Treesitter Context', { title = 'Option' })
        else
          Lazyvim.warn('Disabled Treesitter Context', { title = 'Option' })
        end
      end,
      desc = 'Toggle Treesitter Context',
    },
  },
}
