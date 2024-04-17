local Lazyvim = require('lazyvim')
local Keys = require('keymaps')

return {
  'ahmedkhalf/project.nvim',
  cond = false,
  dependencies = {
    'nvim-telescope/telescope-project.nvim',
  },
  opts = {
    manual_mode = true,
    detection_methods = { 'lsp', 'pattern' },
    patterns = {
      '.git',
      '_darcs',
      '.hg',
      '.bzr',
      '.svn',
      'Makefile',
      'package.json',
      '.sln',
      '.vim',
    },
    silent_chdir = true,
  },
  event = 'VeryLazy',
  config = function(_, opts)
    require('project_nvim').setup(opts)
    Lazyvim.on_load('telescope.nvim', function()
      require('telescope').load_extension('projects')
    end)
  end,
  keys = {
    { Keys.project.show, '<CMD>Telescope projects<CR>', desc = 'Projects' },
  },
}
