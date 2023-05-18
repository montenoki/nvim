-- https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/
local runtime_path = vim.split(package.path, ';', {})
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local common = require('lsp.common-config')

local opts = {
    capabilities = common.capabilities,
    on_attach = function(client, bufnr)
        common.keyAttach(bufnr)
    end,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

return {
    on_setup = function(server)
        require('neodev').setup({ library = { plugins = { 'nvim-dap-ui' }, types = true } })
        server.setup(opts)
    end,
}
