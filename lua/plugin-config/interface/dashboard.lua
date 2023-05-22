local dashboard = requirePlugin('dashboard')
if dashboard == nil then
    return
end
local func_list = {
    { icon = '  ', desc = 'Projects         ', action = 'Telescope projects' },
    { icon = '  ', desc = 'Recently files   ', action = 'Telescope oldfiles' },
    { icon = ' ', desc = 'Command Palette', action = 'Telescope command_palette' },
    { icon = '  ', desc = 'Edit keybindings ', action = 'edit ~/.config/nvim/lua/keybindings.lua' },
    {
        icon = '  ',
        desc = 'Edit Projects    ',
        action = 'edit ~/.local/share/nvim/project_nvim/project_history',
    },
    { icon = '  ', desc = 'Show ENV         ', action = 'Telescope env' },
    { icon = '  ', desc = 'Find file        ', action = 'Telescope find_files' },
    { icon = '  ', desc = 'Find text        ', action = 'Telescope live_grep' },
}
dashboard.setup({
    theme = 'doom', --  theme is doom and hyper default is hyper
    disable_move = true, --  default is false disable move keymap for hyper
    shortcut_type = 'letter', --  shorcut type 'letter' or 'number'
    -- change_to_vcs_root -- default is false,for open file in hyper mru. it will change to the root of vcs
    config = {
        week_header = { enable = true },
        center = func_list,
        footer = { 'https://www.data4cs.co.jp' },
    }, --  config used for theme
    hide = {
        statusline = true, -- hide statusline default is true
        tabline = true, -- hide the tabline
        winbar = true, -- hide winbar
    },
})
