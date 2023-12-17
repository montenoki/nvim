-- Speed up loading Lua modules in Neovim to improve startup time.
vim.loader.enable()
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
-- Setup the lazy.nvim plugin with the 'plugins' configuration
require('lazy').setup({ { import = 'plugins' } })

require('colorscheme')
require('keymaps')