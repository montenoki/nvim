---@diagnostic disable: undefined-field

local M = {}

local function notify_toggle(state, title, option)
    local level = state and vim.log.levels.WARN or vim.log.levels.INFO
    local status = state and "on" or "off"
    vim.notify(option .. " " .. status, level, { title = title })
end

function M.toggle_option(option)
    local state = not vim.opt[option]:get()
    vim.opt[option] = state
    notify_toggle(state, "Toggle", option)
end

function M.toggle_global(key)
    local state = not vim.g[key]
    vim.g[key] = state
    notify_toggle(state, "Toggle Global", key)
end

function M.toggle_diagnostic()
    local enabled = vim.diagnostic.is_enabled()
    vim.diagnostic.enable(not enabled)
    notify_toggle(not enabled, "Toggle", "Diagnostics")
end

function M.toggle_inlay_hints()
    local state = not vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(state)
    notify_toggle(state, "Toggle", "Inlay Hint")
end

function M.toggle_conceal()
    local level = tonumber(vim.opt.conceallevel:get()) == 0 and 2 or 0
    vim.opt.conceallevel = level
    notify_toggle(level == 2, "Toggle", "Conceal")
end

function M.toggle_codelens()
    local bufnr = 0
    local lenses = vim.lsp.codelens.get(bufnr)
    local enabled = lenses and #lenses > 0

    if enabled then
        vim.lsp.codelens.clear(nil, bufnr)
    else
        vim.lsp.codelens.refresh({ bufnr = bufnr })
    end

    notify_toggle(not enabled, "Toggle", "Codelens")
end

function M.toggle_autoformat()
    -- Get current state from vim global variable
    local state = not (vim.g.autoformat_enabled or false)
    -- Update the state
    vim.g.autoformat_enabled = state
    -- Notify the user about the state change
    notify_toggle(state, "Toggle", "Autoformat")
end

local PYTHON_VERSION_PATTERN = "Python (%d+%.%d+%.%d+)"

local function execute_command(cmd)
    local output = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
        return nil, "Command execution failed: " .. cmd
    end
    return output
end

local function parse_python_version(output)
    local version = output:match(PYTHON_VERSION_PATTERN)
    if not version then
        return nil, "Failed to parse Python version from output: " .. output
    end
    return version
end

function M.get_python_version(python_exec)
    -- Check if Python executable exists
    if vim.fn.executable(python_exec) ~= 1 then
        return nil, "Python executable not found: " .. python_exec
    end

    -- Get Python version
    local output, err = execute_command(python_exec .. " -V")
    if not output then
        return nil, err
    end

    -- Parse version
    local version, parse_err = parse_python_version(output)
    if not version then
        return nil, parse_err
    end

    return version
end

return M
