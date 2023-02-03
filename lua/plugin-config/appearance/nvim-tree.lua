local uConfig = require('uConfig')
local uTree = uConfig.nvimTree

if uTree == nil or not uTree.enable then
    return
end

local nvim_tree = requirePlugin('nvim-tree')

-- キーバインド導入
local list_keys = {
    { key = uTree.edit, action = 'edit' },
    { key = uTree.system_open, action = 'system_open' },
    { key = uTree.preview, action = 'preview' },
    { key = uTree.tabnew, action = 'tabnew' },
    { key = uTree.vsplit, action = 'vsplit' },
    { key = uTree.split, action = 'split' },

    { key = uTree.toggle_git_ignored, action = 'toggle_git_ignored' },
    { key = uTree.toggle_dotfiles, action = 'toggle_dotfiles' }, -- Hide (dotfiles)
    { key = uTree.toggle_custom, action = 'toggle_custom' },
    { key = uTree.toggle_file_info, action = 'toggle_file_info' },
    { key = uTree.toggle_help, action = 'toggle_help' },

    { key = uTree.refresh, action = 'refresh' },

    { key = uTree.file_filter, action = 'live_filter' },
    { key = uTree.clear_filter, action = 'clear_live_filter' },

    { key = uTree.cd, action = 'cd' },
    { key = uTree.dir_up, action = 'dir_up' },

    { key = uTree.create, action = 'create' },
    { key = uTree.remove, action = 'remove' },
    { key = uTree.rename, action = 'rename' },
    { key = uTree.cut, action = 'cut' },
    { key = uTree.copy, action = 'copy' },
    { key = uTree.paste, action = 'paste' },
    { key = uTree.copy_name, action = 'copy_name' },
    { key = uTree.copy_path, action = 'copy_path' },
    { key = uTree.copy_absolute_path, action = 'copy_absolute_path' },
}

if nvim_tree == nil then
    return
end
-- On/Off
keymap('n', uTree.toggle, ':NvimTreeToggle<CR>')
nvim_tree.setup({
    open_on_setup = true,
    -- デフォルトのnetrwを無効化
    disable_netrw = true,
    -- git 状態表示 off
    git = {
        -- TODO
        enable = true,
        ignore = true,
    },
    -- project plugin と連携
    update_cwd = false,
    update_focused_file = {
        enable = true,
        update_cwd = false,
    },
    -- dot ファイルと node_modules フォルダー非表示
    filters = {
        dotfiles = false,
        custom = {},
    },
    view = {
        -- 幅
        width = 40,
        -- 左右
        side = 'left',
        -- ルートフォルダー非表示
        hide_root_folder = false,
        -- キーバインド導入
        mappings = {
            custom_only = true,
            list = list_keys,
        },
        -- 行番号非表示
        number = false,
        relativenumber = false,
        -- アイコン表示
        signcolumn = 'yes',
    },
    actions = {
        -- ファイルを開く時の action
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
        icons = { webdev_colors = true, git_placement = 'after' },
    },
})
