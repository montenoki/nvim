return {
  -- Pangu 中文自动间隔格式化
  {
    'hotoo/pangu.vim',
    keys = { { '<LEADER>cm', '<CMD>PanguAll<CR>', { desc = 'Format CJK' } } },
  },
  {
    enabled = false,
    'montenoki/leap-zh.nvim',
    dependencies = {
      'theHamsta/nvim_rocks',
      build = 'pip install --user hererocks && python -mhererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua',
      config = function()
        local rocks = require('nvim_rocks')
        rocks.ensure_installed('luautf8')
        rocks.ensure_installed('lpeg')
      end,
    },
  },
}
