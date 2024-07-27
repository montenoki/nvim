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
local plugins = {
  { import = 'plugins' },
--   { import = 'plugins.coding' },
--   { import = 'plugins.util' },
--   { import = 'plugins.treesitter' },
--   { import = 'plugins.ui' },
--   { import = 'plugins.editor' },
}

-- if vim.g.vscode then
  -- require('vscode')
-- else
  -- require('global')
  require('options')
  -- require('keybindings')
  -- require('autocmds')

  -- table.insert(plugins, { import = 'lang' })
  --
  -- local osName = vim.loop.os_uname().sysname
  -- if string.find(string.lower(osName), 'windows') then
  --   table.insert(plugins, { import = 'os.windows' })
  --   require('os.windows')
  -- elseif osName == 'Darwin' then
  --   table.insert(plugins, { import = 'os.mac' })
  --   require('os.mac')
  -- else
  --   table.insert(plugins, { import = 'os.linux' })
  --   require('os.linux')
  -- end

  require('lazy').setup(plugins)
  require('colorscheme')
-- end
