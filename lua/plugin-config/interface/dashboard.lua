local py_snippets_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/vim-snippets/UltiSnips/python.snippets'
local dashboard = requirePlugin('dashboard')
if dashboard == nil then
    return
end
local func_list = {
    { icon = '  ', desc = 'Projects          ',   action = 'Telescope projects' },
    { icon = '  ', desc = 'Recently files    ',   action = 'Telescope oldfiles' },
    { icon = '  ', desc = 'TODO list         ',   action = 'TodoTrouble' },
    { icon = '  ', desc = 'User Settings',        action = 'edit ~/.config/nvim/lua/uConfig.lua' },
    { icon = '  ', desc = 'Show ENV          ',   action = 'Telescope env' },
    { icon = '  ', desc = 'Edit Python Snippets', action = 'vsp ' .. py_snippets_path },
}
dashboard.setup({
    theme = 'doom',           --  theme is doom and hyper default is hyper
    disable_move = true,      --  default is false disable move keymap for hyper
    shortcut_type = 'letter', --  shorcut type 'letter' or 'number'
    -- change_to_vcs_root -- default is false,for open file in hyper mru. it will change to the root of vcs
    config = {
        week_header = { enable = true },
        center = func_list,
        footer = { '[ Machine intelligence is the last invention that humanity will ever need to make. ]' },
    },                     --  config used for theme
    hide = {
        statusline = true, -- hide statusline default is true
        tabline = true,    -- hide the tabline
        winbar = true,     -- hide winbar
    },
})
