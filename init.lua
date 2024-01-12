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

if vim.g.vscode ~= nil then
  require('vscode')
  require('lazy').setup({ { import = 'plugins.coding' } })
elseif vim.g.lite_mode == true then
  require('lazy').setup({ { import = 'plugins.coding' } })
  -- require('colorscheme')
else
  require('lazy').setup({ { import = 'plugins' }, { import = 'lang' } })
  require('colorscheme')
end

local os_name = vim.loop.os_uname().sysname
if string.find(string.lower(os_name), 'windows') then
  require('lazy').setup({ { import = 'os.windows' } })
elseif os_name == 'Darwin' then
  require('lazy').setup({ { import = 'os.mac' } })
else
  require('lazy').setup({ { import = 'os.linux' } })
end
require('keymaps')
