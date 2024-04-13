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

require('lazy').setup({
  { import = 'plugins' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.editor' },
  { import = 'plugins.lsp' },
})

require('colorscheme')

-- TODO:(2024/4/12) delete

-- local lazy_imports = {}
-- if vim.g.vscode ~= nil then
--   table.insert(lazy_imports, { import = 'plugins.coding' })
-- elseif vim.g.lite_mode == true then
--   table.insert(lazy_imports, { import = 'plugins' })
--   table.insert(lazy_imports, { import = 'lang' })
-- else -- Normal Mode
--   table.insert(lazy_imports, { import = 'plugins' })
--   table.insert(lazy_imports, { import = 'lang' })
-- end
--
-- require('options')
-- require('autocmds')
--
-- local os_name = vim.loop.os_uname().sysname
-- if string.find(string.lower(os_name), 'windows') then
--   table.insert(lazy_imports, { import = 'os.windows' })
--   require('os.windows')
-- elseif os_name == 'Darwin' then
--   table.insert(lazy_imports, { import = 'os.mac' })
--   require('os.mac')
-- else
--   table.insert(lazy_imports, { import = 'os.linux' })
--   require('os.linux')
-- end
-- require('lazy').setup({ lazy_imports })
--
-- if vim.g.vscode ~= nil then
--   require('vscode')
-- else -- Normal or Lite Mode
--   require('colorscheme')
-- end
-- require('keymaps')
--
-- if vim.g.neovide then
--   vim.o.guifont = 'FiraCode Nerd Font Mono'
-- end
