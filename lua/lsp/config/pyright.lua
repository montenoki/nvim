local common = require('lsp.common-config')
local function check_debugpy_exsit()
    local executable_path
    local os_name = getSysName()
    if os_name == 'Windows' or os_name == 'Windows_NT' then
        executable_path = '\\.virtualenvs\\Scripts\\python.exe'
    else
        executable_path = '/.virtualenvs/debugpy/bin/python'
    end
    local path = vim.env.HOME .. executable_path
    if vim.fn.empty(vim.fn.glob(path)) > 0 then
        vim.notify("No Python adapter for Dap found.\n", vim.log.levels.WARN)
    end
end
local opts = {
    capabilities = common.capabilities,
    on_attach = function(client, bufnr)
        check_debugpy_exsit()
        common.keyAttach(bufnr)
        common.BreadcrumbsAttach(client, bufnr)
    end,
}
return {
    on_setup = function(server)
        server.setup(opts)
    end,
}
