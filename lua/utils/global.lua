local vim = vim

function _G.requirePlugin(name)
    local status_ok, plugin = pcall(require, name)
    if not status_ok then
        vim.notify(name .. ' Not Found!')
        return nil
    end
    return plugin
end

function _G.keymap(mode, lhs, rhs, opts)
    if not (type(lhs) == 'string') then
        return
    end
    if not (type(rhs) == 'string') then
        return
    end
    opts = opts or {}
    local default_opts = {
        remap = false,
        silent = true,
    }
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', default_opts, opts))
end

function _G.getSysName()
    return vim.loop.os_uname().sysname
end
