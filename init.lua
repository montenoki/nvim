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
require('local_config')

local plugins = {
    { import = 'plugins' },
    { import = 'plugins.lang' },
}
local osName = vim.loop.os_uname().sysname
if string.find(string.lower(osName), 'windows') then
    table.insert(plugins, { import = 'plugins.os.windows' })
elseif osName == 'Darwin' then
    table.insert(plugins, { import = 'plugins.os.mac' })
else
    table.insert(plugins, { import = 'plugins.os.linux' })
end
require('lazy').setup(plugins)

-- if vim.g.vscode then
--     require('vscode')
-- end

local colorSchemes = {
    'nightfox',
    'kanagawa',
    'dracula',
    'everforest',
    'gruvbox-material',
}
local colorScheme = require('utils').randomColorscheme(colorSchemes)

vim.cmd.colorscheme(colorScheme)
