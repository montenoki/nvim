-- Check if the lazy.nvim plugin is installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- Clone the latest stable release of lazy.nvim from GitHub
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
-- Add the path to lazy.nvim to the runtimepath
vim.opt.rtp:prepend(lazypath)

require('global')
require('options')
require('keybindings')
require('autocmds')

if vim.g.vscode ~= nil then
  require('vscode')
end
if vim.g.neovide then
  vim.o.guifont = 'FiraCode Nerd Font Mono'
end

local plugins = {
  { import = 'plugins' },
  { import = 'plugins.coding' },
  { import = 'plugins.util' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.ui' },
  { import = 'plugins.editor' },
}
if vim.g.vscode == nil then
  table.insert(plugins, { import = 'lang' })
  local os_name = vim.loop.os_uname().sysname
  if string.find(string.lower(os_name), 'windows') then
    table.insert(plugins, { import = 'os.windows' })
    require('os.windows')
  elseif os_name == 'Darwin' then
    table.insert(plugins, { import = 'os.mac' })
    require('os.mac')
  else
    table.insert(plugins, { import = 'os.linux' })
    require('os.linux')
  end
end
require('lazy').setup(plugins)

require('colorscheme')
