local keymaps = require('keymaps')

return {
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
        init = function()
            require('which-key').add({
                { '<leader>h', group = '+gitsigns', mode = { 'n', 'v' } },
            })
        end,
        opts = {
            signs = {
                add = { text = '+▎' },
                change = { text = '▎' },
                delete = { text = '' },
                topdelete = { text = '' },
                changedelete = { text = '▎' },
                untracked = { text = 'U▎' },
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns
                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end
                -- stylua: ignore start
                map("n", keymaps.gitsigns.next_hunk, gs.next_hunk, "Next Hunk")
                map("n", keymaps.gitsigns.prev_hunk, gs.prev_hunk, "Prev Hunk")
                map("n", keymaps.gitsigns.preview_hunk, gs.preview_hunk, "Preview Hunk")
                map("n", keymaps.gitsigns.blame_line, function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", keymaps.gitsigns.diff, gs.diffthis, "Diff This")
                map("n", keymaps.gitsigns.diff_tilde, function() gs.diffthis("~") end, "Diff This ~")
            end,
        },
    },
    {
        'lualine.nvim',
        opts = function(_, opts)
            local function diff_source()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                    return {
                        added = gitsigns.added,
                        modified = gitsigns.changed,
                        removed = gitsigns.removed,
                    }
                end
            end
            table.insert(opts.winbar.lualine_x, {
                'diff',
                source = diff_source,
                symbols = { added = ' ', modified = ' ', removed = ' ' },
            })
        end,
    },
}
