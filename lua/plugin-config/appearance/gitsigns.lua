-- https://github.com/lewis6991/gitsigns.nvim
local gitsigns = requirePlugin('gitsigns')
local uConfig = require('uConfig')

if gitsigns == nil or not uConfig.enable.gitsigns then
    return
end

local icon

if uConfig.enable.lite_mode then
    icon = {
        add = 'A|',
        change = 'C|',
        delete = 'D_',
        top_delete = 'D/',
        change_delete = 'D~',
        untracked = 'U|',
    }
else
    icon = {
        add = '|',
        change = '|',
        delete = '󰆴|',
        top_delete = '󰆴',
        change_delete = '󰆴',
        untracked = '|',
    }
end

gitsigns.setup({
    signs = {
        add = {
            hl = 'GitSignsAdd',
            text = icon.add,
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn',
        },
        change = {
            hl = 'GitSignsChange',
            text = icon.change,
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn',
        },
        delete = {
            hl = 'GitSignsDelete',
            text = icon.delete,
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn',
        },
        topdelete = {
            hl = 'GitSignsDelete',
            text = icon.top_delete,
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn',
        },
        changedelete = {
            hl = 'GitSignsChange',
            text = icon.change_delete,
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn',
        },
        untracked = {
            hl = 'GitSignsChange',
            text = icon.untracked,
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn',
        },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    keymaps = require('keybindings').gitsigns,
    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
        relative_time = true,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
    },
    yadm = {
        enable = false,
    },
    on_attach = require('keybindings').gitsigns_on_attach,
})
