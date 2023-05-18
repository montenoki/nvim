local uConfig = require('uConfig')
local uTree = uConfig.nvimTree

if uTree == nil or not uTree.enable then
    return
end

local nvim_tree = requirePlugin('nvim-tree')
local uConfig = require('uConfig')
local lite_mode = uConfig.lite_mode

local icons

if lite_mode then
    icons = nil
else
    icons = { webdev_colors = true, git_placement = 'after' }
end

-- Keybindings
local list_keys = {
    { key = uTree.edit,               action = 'edit' },
    { key = uTree.system_open,        action = 'system_open' },
    { key = uTree.preview,            action = 'preview' },
    { key = uTree.tabnew,             action = 'tabnew' },
    { key = uTree.vsplit,             action = 'vsplit' },
    { key = uTree.split,              action = 'split' },
    { key = uTree.toggle_git_ignored, action = 'toggle_git_ignored' },
    { key = uTree.toggle_dotfiles,    action = 'toggle_dotfiles' }, -- Hide (dotfiles)
    { key = uTree.toggle_custom,      action = 'toggle_custom' },
    { key = uTree.toggle_file_info,   action = 'toggle_file_info' },
    { key = uTree.toggle_help,        action = 'toggle_help' },

    { key = uTree.refresh,            action = 'refresh' },

    { key = uTree.file_filter,        action = 'live_filter' },
    { key = uTree.clear_filter,       action = 'clear_live_filter' },

    { key = uTree.cd,                 action = 'cd' },
    { key = uTree.dir_up,             action = 'dir_up' },

    { key = uTree.create,             action = 'create' },
    { key = uTree.remove,             action = 'remove' },
    { key = uTree.rename,             action = 'rename' },
    { key = uTree.cut,                action = 'cut' },
    { key = uTree.copy,               action = 'copy' },
    { key = uTree.paste,              action = 'paste' },
    { key = uTree.copy_name,          action = 'copy_name' },
    { key = uTree.copy_path,          action = 'copy_path' },
    { key = uTree.copy_absolute_path, action = 'copy_absolute_path' },
}

if nvim_tree == nil then
    return
end
-- On/Off
keymap('n', uTree.toggle, ':NvimTreeToggle<CR>')

nvim_tree.setup({
    open_on_setup = true,
    disable_netrw = true,
    -- git 状態表示 off
    git = {
        -- TODO
        enable = true,
        ignore = true,
    },
    -- project plugin
    update_cwd = false,
    update_focused_file = {
        enable = true,
        update_cwd = false,
    },

    filters = {
        dotfiles = false,
        custom = {},
    },
    view = {
        width = 40,
        side = 'left',
        hide_root_folder = false,
        mappings = {
            custom_only = true,
            list = list_keys,
        },
        number = false,
        relativenumber = false,
        signcolumn = 'yes',
    },
    actions = {
        open_file = {
            resize_window = true,
            quit_on_open = true,
        },
    },
    system_open = {
        --TODO mac
        cmd = 'open',
        -- TODO windows
        --cmd="wsl-open",
    },
    renderer = {
        indent_markers = {
            enable = true,
            icons = { corner = '└ ', edge = '│ ', none = '  ' },
        },
        icons = icons,
    },
})
