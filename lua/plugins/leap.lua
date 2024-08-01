local keymaps = require('keymaps')

return {
    {
        'ggandor/leap.nvim',
        dependencies = { 'tpope/vim-repeat' },
        keys = {
            {
                keymaps.open.leap,
                mode = { 'n', 'x', 'o' },
                function()
                    local leap = require('leap')
                    leap.leap({
                        target_windows = vim.tbl_filter(function(win)
                            return vim.api.nvim_win_get_config(win).focusable
                        end, vim.api.nvim_tabpage_list_wins(0)),
                    })
                end,
                desc = 'Leap',
            },
        },
        config = function(_, opts)
            local leap = require('leap')
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
        end,
    },
    {
        'ggandor/flit.nvim',
        enabled = true,
        keys = function()
            local ret = {}
            for _, key in ipairs({ 'f', 'F', 't', 'T' }) do
                ret[#ret + 1] = { key, mode = { 'n', 'x', 'o' } }
            end
            return ret
        end,
        opts = { labeled_modes = 'nx' },
    },
}
