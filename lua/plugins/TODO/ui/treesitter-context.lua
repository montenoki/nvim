local Keys = require('keymaps').treesitter

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
        ---@diagnostic disable-next-line: undefined-field
        if Lazyvim.inject.get_upvalue(tsc.toggle, 'enabled') then
          ---@diagnostic disable-next-line: undefined-field
          Lazyvim.info('Enabled Treesitter Context', { title = 'Option' })
        else
          ---@diagnostic disable-next-line: undefined-field
          Lazyvim.warn('Disabled Treesitter Context', { title = 'Option' })
        end
      end,
      desc = 'Toggle Treesitter Context',
    },
  },
}
