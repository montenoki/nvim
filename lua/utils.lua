---@diagnostic disable: undefined-field

local M = {}

local function notify_toggle(state, title, option)
    local level = state and vim.log.levels.WARN or vim.log.levels.INFO
    local status = state and "on" or "off"
    vim.notify(option .. " " .. status, level, { title = title })
end

function M.toggle_option(option)
    if option == "spell" or option == "list" or option == "relativenumber" then
        return require("config.toggles").toggle(option)
    end
    local state = not vim.opt[option]:get()
    vim.opt[option] = state
    notify_toggle(state, "Toggle", option)
end

function M.toggle_global(key)
    if key == "autoformat" then
        return require("config.toggles").toggle(key)
    end
    local state = not vim.g[key]
    vim.g[key] = state
    notify_toggle(state, "Toggle Global", key)
end

function M.toggle_diagnostic()
    require("config.toggles").toggle("diagnostics")
end

function M.toggle_inlay_hints()
    require("config.toggles").toggle("inlay_hints")
end

function M.toggle_conceal()
    require("config.toggles").toggle("conceal")
end

function M.toggle_codelens()
    require("config.toggles").toggle("codelens")
end

function M.toggle_autoformat()
    require("config.toggles").toggle("autoformat")
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
