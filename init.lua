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

local lazy_imports = {}
if vim.g.vscode ~= nil then
  table.insert(lazy_imports, { import = 'plugins.coding' })
elseif vim.g.lite_mode == true then
  table.insert(lazy_imports, { import = 'plugins.coding' })
else -- Normal Mode
  table.insert(lazy_imports, { import = 'plugins' })
  table.insert(lazy_imports, { import = 'lang' })
end

local os_name = vim.loop.os_uname().sysname
if string.find(string.lower(os_name), 'windows') then
  table.insert(lazy_imports, { import = 'os.windows' })
elseif os_name == 'Darwin' then
  table.insert(lazy_imports, { import = 'os.mac' })
else
  table.insert(lazy_imports, { import = 'os.linux' })
end
require('lazy').setup({ lazy_imports })

if vim.g.vscode ~= nil then
  require('vscode')
elseif vim.g.lite_mode ~= nil then
  vim.print('Lite Mode')
else -- Normal Mode
  require('colorscheme')
end
require('keymaps')

if vim.g.neovide then
  vim.o.guifont = 'FiraCode Nerd Font Mono'
end
