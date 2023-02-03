local uConfig = require('uConfig')
local uufo = uConfig.ufo

if uufo == nil or not uufo.enable then
    return
end
local ufo = requirePlugin('ufo')
if ufo == nil then
    return
end

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d ......'):format(endLnum - lnum)
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
    close_fold_kinds = { 'imports', 'comment' },
    preview = {
        win_config = {
            border = { '', '─', '', '', '', '─', '', '' },
            winhighlight = 'Normal:Folded',
            winblend = 0,
        },
        mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>',
        },
    },
    provider_selector = function(bufnr, filetype, buftype)
        return ftMap[filetype]
    end,
})

local opt = { noremap = true, silent = true }

keymap('n', uufo.openAllFolds, ufo.openAllFolds)
keymap('n', uufo.closeAllFolds, ufo.closeAllFolds)
keymap('n', uufo.openFoldsExceptKinds, ufo.openFoldsExceptKinds)
keymap('n', uufo.closeFoldWith, ufo.closeFoldWith)
keymap('n', uufo.peekFoldedLinesUnderCursor, function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    print('winid= ' .. winid)
    if not winid then
        vim.lsp.buf.hover()
    end
end, { noremap = false })
