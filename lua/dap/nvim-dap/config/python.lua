local venv = os.getenv('VIRTUAL_ENV')
local command = nil
if getSysName() == 'Windows' then
    command = string.format('%s', venv)
else
    command = string.format('%s/bin/python', venv)
end

require('dap-python').setup(command)
