-- Speed up loading Lua modules in Neovim to improve startup time.
require('global')
require('options')
require('autocmds')

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

if vim.g.vscode == nil then
  require('lazy').setup({ { import = 'plugins' }, { import = 'lang' } })
  require('colorscheme')
else
  require('vscode')
  require('lazy').setup({ { import = 'plugins.coding' } })
end
require('keymaps')

local os_name = vim.loop.os_uname().sysname
if string.find(string.lower(os_name), 'windows') then
  require('os.windows')
elseif os_name == 'Darwin' then
  require('os.mac')
else
  require('os.linux')
end
