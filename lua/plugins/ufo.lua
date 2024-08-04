local keymaps = require('keymaps')

return {
    {
        'luukvbaal/statuscol.nvim',
        config = function()
            local builtin = require('statuscol.builtin')
            require('statuscol').setup({
                relculright = true,
                segments = {
                    { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
                    { text = { '%s' }, click = 'v:lua.ScSa' },
                    { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
                },
            })
        end,
    },
    {
        'kevinhwang91/nvim-ufo',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
        dependencies = { 'kevinhwang91/promise-async', 'luukvbaal/statuscol.nvim' },
        init = function()
            vim.opt.foldcolumn = '0'
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
            vim.opt.foldenable = true
        end,
        config = function()
            local ufo = require('ufo')
            local icon = '  %d ...'
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (icon):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'MoreMsg' })
                return newVirtText
            end

            local ftMap = {
                lua = 'treesitter',
                python = { 'treesitter', 'indent' },
                git = '',
            }

            ufo.setup({
                fold_virt_text_handler = handler,
                open_fold_hl_timeout = 150,
                close_fold_kinds_for_ft = { default = { 'imports', 'comment' } },
                preview = {
                    win_config = {
                        border = { '', '─', '', '', '', '─', '', '' },
                        winhighlight = 'Normal:Folded',
                        winblend = 0,
                    },
                    mappings = {
                        scrollU = keymaps.floatWindow.scrollUp,
                        scrollD = keymaps.floatWindow.scrollDown,
                    },
                },
                ---@diagnostic disable-next-line: unused-local
                provider_selector = function(_bufnr_, filetype, _buftype_)
                    return ftMap[filetype]
                end,
            })

            vim.keymap.set('n', keymaps.ufo.open_all, ufo.openAllFolds, { desc = 'Open All Folds' })
            vim.keymap.set('n', keymaps.ufo.close_all, ufo.closeAllFolds, { desc = 'Close All Folds' })
            vim.keymap.set('n', keymaps.ufo.peek, function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end, { desc = 'Peek Folded Lines' })
        end,
    },
}
