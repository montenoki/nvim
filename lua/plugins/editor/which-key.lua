local Keys = require('keymaps').whichkey

return {
  'folke/which-key.nvim',
  cond = vim.g.vscode == nil,
  event = 'VeryLazy',
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { 'n', 'v' },
      ['g'] = { name = '+goto' },
      ['s'] = { name = '+surround' },
      ['z'] = { name = '+fold' },
      [']'] = { name = '+next' },
      ['['] = { name = '+prev' },
      ['<leader>c'] = { name = '+code' },
      ['<leader>t'] = { name = '+tab' },
      ['<leader>u'] = { name = '+toggle' },
      ['<leader>w'] = { name = '+windows' },
      ['<leader>x'] = { name = '+diagnostics/quickfix' },
    },
  },
  keys = {
    { Keys.toggle_wk, '<CMD>WhichKey<CR>' },
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
