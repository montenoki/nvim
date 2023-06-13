local uConfig = require('uConfig')
local lite_mode = uConfig.enable.lite_mode
local icons

if lite_mode then
    icons = {
        package_installed = 'v',
        package_pending = '->',
        package_uninstalled = 'x',
    }
else
    icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
    }
end

-- 自定义图标
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

local signs
if lite_mode then
    signs = { Error = 'E:', Warn = 'W:', Hint = '!:', Info = 'i:' }
else
    signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
end
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local mason = requirePlugin('mason')
if mason == nil then
    return
end
mason.setup({
    ui = {
        icons = icons,
    },
})

local mason_config = requirePlugin('mason-lspconfig')
if mason_config == nil then
    return
end

mason_config.setup({
    ensure_installed = {
        'bashls',
        'lua_ls',
        'marksman',
        'rust_analyzer',
        'pyright',
    },
})

local servers = {
    lua_ls = require('lsp.config.lua'),
    marksman = require('lsp.config.markdown'),
    bashls = require('lsp.config.bash'),
    -- TODO:
    pyright = require('lsp.config.pyright'),
    rust_analyzer = require('lsp.config.rust'),
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

require('lsp.null-ls')
