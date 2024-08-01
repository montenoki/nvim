-- =============================================================================
-- Automatically install lazy.nvim.
-- =============================================================================
local lazyPath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazyPath) then
  -- Clone the latest stable release of lazy.nvim from GitHub
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazyPath,
  })
end
-- Add the path to lazy.nvim to the runtimepath
vim.opt.rtp:prepend(lazyPath)

-- =============================================================================
-- Load settings
-- =============================================================================
require('options')
require('autocmds')
require('keybindings')
local plugins = {
  { import = 'plugins' },
  { import = 'plugins.lang' },
  -- { import = 'plugins.done' },
  -- { import = 'plugins.ui' },
  -- { import = 'plugins.coding' },
  -- { import = 'plugins.util' },
  -- { import = 'plugins.treesitter' },
  -- { import = 'plugins.editor' },
}

if vim.g.vscode then
  require('vscode')
else
  -- require('global')

  -- table.insert(plugins, { import = 'lang' })
  --
  -- local osName = vim.loop.os_uname().sysname
  -- if string.find(string.lower(osName), 'windows') then
  --   table.insert(plugins, { import = 'os.windows' })
  -- elseif osName == 'Darwin' then
  --   table.insert(plugins, { import = 'os.mac' })
  -- else
  --   table.insert(plugins, { import = 'os.linux' })
  -- end

  require('lazy').setup(plugins)
end

-- vim.cmd('colorscheme kanagawa')
-- vim.cmd[[colorscheme dracula-soft]]
vim.cmd[[colorscheme dracula]]
-- vim.cmd[[colorscheme everforest]]
-- vim.cmd.colorscheme('gruvbox-material')
