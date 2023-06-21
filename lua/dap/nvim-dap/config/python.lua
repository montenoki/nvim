local executable_path
if getSysName() == 'Windows' or getSysName() == 'Windows_NT' then
    executable_path = '\\.virtualenvs\\debugpy\\Scripts\\python.exe'
else
    executable_path = '/.virtualenvs/debugpy/bin/python'
end
local path = vim.env.HOME .. executable_path

local dap = requirePlugin('dap')
local dapui = requirePlugin('dapui')
local dap_python = requirePlugin('dap-python')

if dap == nil or dapui == nil or dap_python == nil then
    return
end

dap_python.setup(path)

dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end
