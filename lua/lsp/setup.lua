local uConfig = require('uConfig')
local language_support = uConfig.language_support.mason

local mason_icons
local signs

-- lite_mode settings
if uConfig.enable.lite_mode then
    mason_icons = {
        package_installed = 'v',
        package_pending = '->',
        package_uninstalled = 'x',
    }
    signs = { Error = 'E:', Warn = 'W:', Hint = '!:', Info = 'i:' }
else
    mason_icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
    }
    signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
end

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    show_header = false,
    severity_sort = true,
    float = {
        source = 'always',
        border = 'rounded',
        style = 'minimal',
        header = '',
        -- prefix = " ",
        -- max_width = 100,
        -- width = 60,
        -- height = 20,
    },
})

for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local mason = requirePlugin('mason')
local mason_config = requirePlugin('mason-lspconfig')
local lspconfig = requirePlugin('lspconfig')

if mason == nil or mason_config == nil or lspconfig == nil then
    return
end

mason.setup({
    ui = {
        icons = mason_icons,
    },
})

mason_config.setup({
    ensure_installed = language_support.ensure_installed,
})

for name, config in pairs(language_support.servers) do
    if config ~= nil and type(config) == 'table' then
        config.on_setup(lspconfig[name])
    else
        lspconfig[name].setup({})
    end
end

require('lsp.null-ls')
