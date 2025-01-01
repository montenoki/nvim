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

return M
