local function get_python_interperter()
    local cwd = vim.fn.getcwd()
    local venv = os.getenv('VIRTUAL_ENV')
    local python_exec_dir
    local python_interperter_path
    local step_char
    local venv_names = { '.venv', 'venv' }
    local in_cwd_flg = false
    if getSysName() == 'Windows' or getSysName() == 'Windows_NT' then
        python_exec_dir = '\\Scripts\\python.exe'
        step_char = '\\'
    else
        python_exec_dir = '/bin/python'
        step_char = '/'
    end

    if venv == nil then
        for _, venv_name in pairs(venv_names) do
            python_interperter_path = cwd .. step_char .. venv_name
            if vim.fn.isdirectory(python_interperter_path) == 1 then
                in_cwd_flg = true
                venv = venv_name
                break
            end
        end
    end
    if venv == nil then
        print('venv not found!')
    elseif in_cwd_flg == true then
        python_interperter_path = cwd .. step_char .. venv .. python_exec_dir
    else
        python_interperter_path = venv .. python_exec_dir
    end

    if vim.fn.executable(python_interperter_path) == 1 then
        print('python_interperter_path:' .. python_interperter_path)
        return python_interperter_path
    else
        return nil
    end
end

local dap = require('dap')
local python_interperter_path = get_python_interperter()
dap.adapters.python = {
    type = 'executable',
    command = python_interperter_path,
    args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = 'Launch file',

        program = '${file}',
        pythonPath = python_interperter_path,
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
--require('dap-python').setup()
