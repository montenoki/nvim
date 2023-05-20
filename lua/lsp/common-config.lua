local M = {}

local navic = requirePlugin('nvim-navic')
if navic == nil then
    return
end

M.keyAttach = function(bufnr)
    local function buf_set_keymap(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr })
    end
    require('keybindings').mapLSP(buf_set_keymap)
end
M.BreadcrumbsAttach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()
M.capabilities.textDocument.foldingRange = {
    dynamcRegistration = false,
    lineFoldingOnly = true,
}

return M
