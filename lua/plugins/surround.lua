local keymaps = require('keymaps')

return {
    'echasnovski/mini.surround',
    version = '*',
    init = function()
        require('which-key').add({
            { 'gs', group = '+Surround', mode = { 'n', 'v' } },
        })
    end,
    keys = function(_, keys)
        -- Populate the keys based on the user's options
        local plugin = require('lazy.core.config').spec.plugins['mini.surround']
        local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
        local mappings = {
            { opts.mappings.add, desc = 'Add Surrounding', mode = { 'n', 'v' } },
            { opts.mappings.delete, desc = 'Delete Surrounding' },
            { opts.mappings.find, desc = 'Find Right Surrounding' },
            { opts.mappings.find_left, desc = 'Find Left Surrounding' },
            { opts.mappings.highlight, desc = 'Highlight Surrounding' },
            { opts.mappings.replace, desc = 'Replace Surrounding' },
            { opts.mappings.update_n_lines, desc = 'Update `MiniSurround.config.n_lines`' },
        }
        mappings = vim.tbl_filter(function(m)
            return m[1] and #m[1] > 0
        end, mappings)
        return vim.list_extend(mappings, keys)
    end,
    opts = {
        mappings = {
            add = keymaps.surround.add,
            delete = keymaps.surround.delete,
            replace = keymaps.surround.replace,
            find = keymaps.surround.find,
            find_left = keymaps.surround.find_left,
            highlight = keymaps.surround.highlight,
            update_n_lines = keymaps.surround.update_n_lines,
        },
    },
}
