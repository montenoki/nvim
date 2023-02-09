local dap = require('dap')
local venv = os.getenv('VIRTUAL_ENV')

dap.adapters.python = {
    type = 'executable',
    command = function()
        if getSysName() == 'Darwin' then
            print('we are in Darwin!')
            return venv .. '/bin/python' -- python with debugpy installed
        end
    end,
    args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch',
        name = 'Launch file',

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = '${file}', -- This configuration will launch the current file if used.
        pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            print('cwd=' .. cwd)
            local local_py_path
            if vim.fn.executable(cwd .. venv .. '/bin/python') == 1 then
                local_py_path = cwd .. venv .. '/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                local_py_path = cwd .. '/.venv/bin/python'
            else
                local_py_path = '/usr/bin/python'
            end
            print('local_py_path=' .. local_py_path)
            return local_py_path
        end,
    },
}
-- local command = nil
-- print(venv)
-- if getSysName() == 'Windows' and not venv == nil then
--     command = string.format('%s', venv)
-- else
--     command = string.format('%s/bin/python', venv)
-- end
--
require('dap-python').setup()
