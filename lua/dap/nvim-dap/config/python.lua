local function get_python_interperter()
    local cwd = vim.fn.getcwd()
    local venv = os.getenv('VIRTUAL_ENV')
    local python_exec_dir
    local python_interperter_path
    local step_char
    local venv_names = { '.venv', 'venv' }
    local in_cwd_flg = false
    local os_name = getSysName()
    if os_name == 'Windows' or os_name == 'Windows_NT' then
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
    -- TODO:
    if venv == nil then
        -- vim.notify('Not in a Virtualenv.')
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

local dap = requirePlugin('dap')
if dap == nil then
    return
end
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
        name = 'Launch Current file',

        program = '${file}',
        pythonPath = python_interperter_path,
    },
}

local dapui = requirePlugin('dapui')
if dapui == nil then
    return
end

dapui.setup({
    icons = { expanded = '', collapsed = '' },
    element_mappings = {
        scopes = {
            open = '<CR>',
            edit = 'e',
            expand = 'o',
            repl = 'r',
        },
    },
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = 'scopes', size = 0.4 },
                'stacks',
                'watches',
                'breakpoints',
            },
            size = 0.35, -- 40 columns
            position = 'left',
        },
        {
            elements = {
                'repl',
            },
            size = 0.25, -- 25% of total lines
            position = 'bottom',
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = 'rounded', -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { 'q', '<Esc>' },
        },
    },
}) -- use default
dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end
