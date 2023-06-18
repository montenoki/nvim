local uConfig = require('uConfig')
local language_support = uConfig.language_support.lsp

local mason_icons
local diagnostic_signs

-- lite_mode settings
if uConfig.enable.lite_mode then
    mason_icons = {
        package_installed = 'v',
        package_pending = '->',
        package_uninstalled = 'x',
    }
    diagnostic_signs = { Error = 'E:', Warn = 'W:', Hint = '!:', Info = 'i:' }
else
    mason_icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
    }
    diagnostic_signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
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

for type, icon in pairs(diagnostic_signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local mason = requirePlugin('mason')
local mason_config = requirePlugin('mason-lspconfig')
local null_config = requirePlugin('mason-null-ls')
local lspconfig = requirePlugin('lspconfig')
local null_ls = requirePlugin('null-ls')

if mason == nil or mason_config == nil or null_config == nil or lspconfig == nil or null_ls == nil then
    return
end

mason.setup({
    pip = {
        upgrade_pip = true,
    },
    ui = {
        icons = mason_icons,
    },
})

mason_config.setup({
    ensure_installed = language_support.lsp_servers,
})

local lsp_server_configs = {}
for _, name in pairs(language_support.lsp_servers) do
    lsp_server_configs[name] = require('lsp.config.' .. name)
end

for name, config in pairs(lsp_server_configs) do
    if config ~= nil and type(config) == 'table' then
        config.on_setup(lspconfig[name])
    else
        lspconfig[name].setup({})
    end
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {}
local null_ensure_installed = {}

for _, v in pairs(language_support.formatting) do
    table.insert(null_ensure_installed, v)
    if language_support.extra_args[v] == nil then
        table.insert(sources, formatting[v])
    else
        table.insert(sources, formatting[v].with(language_support.extra_args[v]))
    end
end
for _, v in pairs(language_support.diagnostics) do
    table.insert(null_ensure_installed, v)
    if language_support.extra_args[v] == nil then
        table.insert(sources, diagnostics[v])
    else
        table.insert(sources, diagnostics[v].with(language_support.extra_args[v]))
    end
end
for _, v in pairs(language_support.code_actions) do
    table.insert(null_ensure_installed, v)
    if language_support.extra_args[v] == nil then
        table.insert(sources, code_actions[v])
    else
        table.insert(sources, code_actions[v].with(language_support.extra_args[v]))
    end
end

null_config.setup({
    ensure_installed = null_ensure_installed,
})
null_ls.setup({
    sources = sources,
})
