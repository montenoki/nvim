local uConfig = require('uConfig')
local lite_mode = uConfig.lite_mode
local keys = uConfig.keys.nvimTree

if keys == nil then
    return
end

local nvim_tree = requirePlugin('nvim-tree')

local icons

if lite_mode then
    icons = {
        default = '- ',
        symlink = '- ',
        bookmark = 'B:',
        modified = 'M:',
        folder = {
            arrow_closed = '> ',
            arrow_open = 'v ',
            default = '= ',
            open = '=:',
            empty = '= ',
            empty_open = '=:',
            symlink = '= ',
            symlink_open = '=:',
        },
        git = {
            unstaged = '[x]',
            staged = '[v]',
            unmerged = '[?]',
            renamed = '[>]',
            untracked = '[*]',
            deleted = '[-]',
            ignored = '[o]',
        },
    }
else
    icons = {
        default = '',
        symlink = '',
        bookmark = '',
        modified = '●',
        folder = {
            arrow_closed = '',
            arrow_open = '',
            default = '',
            open = '',
            empty = '',
            empty_open = '',
            symlink = '',
            symlink_open = '',
        },
        git = {
            unstaged = '✗',
            staged = '✓',
            unmerged = '',
            renamed = '➜',
            untracked = '★',
            deleted = '',
            ignored = '◌',
        },
    }
end

-- Keybindings
local list_keys = {
    { key = keys.edit, action = 'edit' },
    { key = keys.system_open, action = 'system_open' },
    { key = keys.preview, action = 'preview' },
    { key = keys.tabnew, action = 'tabnew' },
    { key = keys.vsplit, action = 'vsplit' },
    { key = keys.split, action = 'split' },
    { key = keys.toggle_git_ignored, action = 'toggle_git_ignored' },
    { key = keys.toggle_dotfiles, action = 'toggle_dotfiles' }, -- Hide (dotfiles)
    { key = keys.toggle_custom, action = 'toggle_custom' },
    { key = keys.toggle_file_info, action = 'toggle_file_info' },
    { key = keys.toggle_help, action = 'toggle_help' },

    { key = keys.refresh, action = 'refresh' },

    { key = keys.file_filter, action = 'live_filter' },
    { key = keys.clear_filter, action = 'clear_live_filter' },

    { key = keys.cd, action = 'cd' },
    { key = keys.dir_up, action = 'dir_up' },

    { key = keys.create, action = 'create' },
    { key = keys.remove, action = 'remove' },
    { key = keys.rename, action = 'rename' },
    { key = keys.cut, action = 'cut' },
    { key = keys.copy, action = 'copy' },
    { key = keys.paste, action = 'paste' },
    { key = keys.copy_name, action = 'copy_name' },
    { key = keys.copy_path, action = 'copy_path' },
    { key = keys.copy_absolute_path, action = 'copy_absolute_path' },
}

if nvim_tree == nil then
    return
end
-- On/Off
keymap('n', keys.toggle, ':NvimTreeToggle<CR>')

nvim_tree.setup({
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
            quit_on_open = false,
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
        icons = {
            webdev_colors = not lite_mode,
            git_placement = 'after',
            glyphs = icons,
        },
    },
})
