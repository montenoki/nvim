local Icon = require('extra.icons')

return {
    'simrat39/symbols-outline.nvim',
    cond = false,
    keys = {
        { '<LEADER>cs', '<CMD>SymbolsOutline<CR>', desc = 'Symbols Outline' },
    },
    cmd = 'SymbolsOutline',
    opts = function()
        local defaults = require('symbols-outline.config').defaults
        local opts = {
            show_guides = false,
            relative_width = false,
            width = 40,
            autofold_depth = 1,
            auto_unfold_hover = true,
            fold_markers = { Icon.fillchars.foldclose, Icon.fillchars.foldopen },
            keymaps = {
                close = { '<ESC>', 'q' },
                goto_location = '<CR>',
                focus_location = '<TAB>',
                hover_symbol = 'h',
                rename_symbol = '<LEADER>r',
                code_actions = '<LEADER>ca',
                fold = 'c',
                unfold = 'o',
                fold_all = 'zM',
                unfold_all = 'zR',
                fold_reset = 'R',
            },
            symbols = {},
            symbol_blacklist = {},
        }
        local filter = {
            default = {
                'Class',
                'Constructor',
                'Enum',
                'Field',
                'Function',
                'Interface',
                'Method',
                'Module',
                'Namespace',
                'Package',
                'Property',
                'Struct',
                'Trait',
            },
        }

        if type(filter) == 'table' then
            filter = filter.default
            if type(filter) == 'table' then
                for kind, symbol in pairs(defaults.symbols) do
                    opts.symbols[kind] = {
                        icon = Icon.navic[kind] or symbol.icon,
                        hl = symbol.hl,
                    }
                    if not vim.tbl_contains(filter, kind) then
                        table.insert(opts.symbol_blacklist, kind)
                    end
                end
            end
        end
        return opts
    end,
}
