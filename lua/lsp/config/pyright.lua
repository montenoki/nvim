local function auto_setup_debugpy()

    print("1")
    local fn = vim.fn
    local sep
    local exe
    if getSysName() == 'Windows_NT' or getSysName() == 'Windows' then
        sep = '\\'
        exe = 'python.exe'
    else
        sep = '/'
        exe = 'bin/python'
    end
    local dot_env_path = vim.env.HOME .. sep .. '.virtualenvs'
    local debugpy_path = dot_env_path .. sep .. 'debugpy'

    print('2')

    print('auto setup func!')

    if fn.empty(fn.glob(debugpy_path)) > 0 then
        vim.notify('Installing debugpy... Please wait...')
        fn.system({ 'mkdir', dot_env_path })
        fn.system({ 'python', '-m', 'venv', debugpy_path })
        fn.system({ debugpy_path .. sep .. exe, '-m', 'pip', 'install', 'debugpy' })
    else
        print("alge")
    end
end

local common = require('lsp.common-config')
local opts = {
    capabilities = common.capabilities,
    on_attach = function(client, bufnr)
        common.keyAttach(bufnr)
        common.BreadcrumbsAttach(client, bufnr)
        auto_setup_debugpy()
    end,
}
return {
    on_setup = function(server)
        server.setup(opts)
    end,
}
