local M = {}

M.keyAttach = function(bufnr)
    local function buf_set_keymap(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr })
    end
    require('keybindings').mapLSP(buf_set_keymap)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.foldingRange = {
    dynamcRegistration = false,
    lineFoldingOnly = true,
}

return M
