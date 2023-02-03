require('lsp.ui')

local mason = requirePlugin('mason')
if mason == nil then
    return
end
mason.setup({
    ui = {
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
        },
    },
})

local mason_config = requirePlugin('mason-lspconfig')
if mason_config == nil then
    return
end
mason_config.setup({
    ensure_installed = {
        'sumneko_lua',
        'pyright',
    },
})

local servers = {
    sumneko_lua = require('lsp.config.lua'),
    pyright = require('lsp.config.pyright'),
}

local lspconfig = requirePlugin('lspconfig')
if lspconfig == nil then
    return
end

for name, config in pairs(servers) do
    if config ~= nil and type(config) == 'table' then
        config.on_setup(lspconfig[name])
    else
        lspconfig[name].setup({})
    end
end
