local keymaps = require('keymaps')

return {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    opts = { use_diagnostic_signs = true },
    keys = {
        {
            keymaps.trouble.document_trouble,
            '<CMD>Trouble diagnostics toggle filter.buf=0<CR>',
            desc = 'Document Diagnostics (Trouble)',
        },
        {
            keymaps.trouble.workspace_trouble,
            '<CMD>Trouble diagnostics toggle<CR>',
            desc = 'Workspace Diagnostics (Trouble)',
        },
        {
            keymaps.trouble.symbols,
            '<cmd>Trouble symbols toggle focus=false<cr>',
            desc = 'Symbols (Trouble)',
        },
        {
            keymaps.trouble.lsp_symbols,
            '<cmd>Trouble lsp toggle<CR>',
            desc = 'Symbols (Trouble)',
        },
        {
            keymaps.trouble.loclist,
            '<CMD>Trouble loclist toggle<CR>',
            desc = 'Location List (Trouble)',
        },
        {
            keymaps.trouble.quickfix,
            '<CMD>Trouble quickfix toggle<CR>',
            desc = 'Quickfix List (Trouble)',
        },
        {
            keymaps.trouble.prev_trouble,
            function()
                if require('trouble').is_open() then
                    require('trouble').previous({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cprev)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = 'Previous trouble',
        },
        {
            keymaps.trouble.next_trouble,
            function()
                if require('trouble').is_open() then
                    require('trouble').next({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cnext)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = 'Next trouble',
        },
    },
}
