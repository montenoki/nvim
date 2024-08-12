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

local plugins = {}
if vim.g.vscode then
    require('vscode_setup')
    plugins = {
        { import = 'plugins.init' },
        { import = 'plugins.leap' },
        { import = 'plugins.surround' },
        { import = 'plugins.yanky' },
        { import = 'plugins.treesitter' },
        { import = 'plugins.which-key' },
        { import = 'plugins.im-select' },
    }
else
    plugins = {
        { import = 'plugins' },
        { import = 'plugins.lang' },
    }
end

local osName = vim.loop.os_uname().sysname
if string.find(string.lower(osName), 'windows') then
    table.insert(plugins, { import = 'plugins.os.windows' })
elseif osName == 'Darwin' then
    table.insert(plugins, { import = 'plugins.os.mac' })
else
    table.insert(plugins, { import = 'plugins.os.linux' })
end

require('lazy').setup(plugins)

if vim.g.vscode == nil then
    local colorSchemes = {
        'nightfox',
        'kanagawa',
        'dracula',
        'everforest',
        'gruvbox-material',
    }
    local colorScheme = require('utils').randomColorscheme(colorSchemes)
    vim.cmd.colorscheme(colorScheme)
end
