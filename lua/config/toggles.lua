local M = {}
local state = require("config.state")
local values = {}
local options = {
    conceal = "conceallevel",
    spell = "spell",
    list = "list",
    relativenumber = "relativenumber",
}
local keys = {
    "diagnostics",
    "inlay_hints",
    "codelens",
    "conceal",
    "spell",
    "list",
    "relativenumber",
    "autoformat",
}
local started = false

local function restore_window(win)
    if not vim.api.nvim_win_is_valid(win) then
        return
    end
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype ~= "" then
        return
    end
    for key, option in pairs(options) do
        if values[key] ~= nil then
            vim.wo[win][option] = key == "conceal" and (values[key] and 2 or 0)
                or values[key]
        end
    end
end

local function lenses(buf)
    if vim.lsp.codelens.enable then
        return -- Neovim 0.12 manages refreshes itself.
    end
    -- Compatibility with Neovim < 0.12, where codelens.enable is unavailable.
    if values.codelens then
        ---@diagnostic disable-next-line: deprecated
        vim.lsp.codelens.refresh({ bufnr = buf })
    elseif values.codelens == false then
        ---@diagnostic disable-next-line: deprecated
        vim.lsp.codelens.clear(nil, buf)
    end
end

local function apply(key, enabled)
    if options[key] then
        vim.opt_global[options[key]] = key == "conceal" and (enabled and 2 or 0)
            or enabled
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            restore_window(win)
        end
    elseif key == "diagnostics" then
        vim.diagnostic.enable(enabled)
    elseif key == "inlay_hints" then
        vim.lsp.inlay_hint.enable(enabled)
    elseif key == "codelens" then
        if vim.lsp.codelens.enable then
            vim.lsp.codelens.enable(enabled)
        else
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) then
                    lenses(buf)
                end
            end
        end
    elseif key == "autoformat" then
        vim.g.autoformat = enabled
    end
end

function M.enabled(key)
    if options[key] then
        local value = vim.wo[options[key]]
        return key == "conceal" and value > 0 or (key ~= "conceal" and value)
    elseif key == "diagnostics" then
        return vim.diagnostic.is_enabled()
    elseif key == "inlay_hints" then
        return vim.lsp.inlay_hint.is_enabled()
    elseif key == "codelens" then
        if vim.lsp.codelens.is_enabled then
            return vim.lsp.codelens.is_enabled()
        end
        return values.codelens == true
    elseif key == "autoformat" then
        return vim.g.autoformat ~= false
    end
    error("Unknown toggle: " .. key)
end

function M.toggle(key)
    local enabled = not M.enabled(key)
    values[key] = enabled
    apply(key, enabled)
    state.set("toggle." .. key, enabled)
    vim.notify(
        key .. (enabled and " on" or " off"),
        vim.log.levels.INFO,
        { title = "Toggle" }
    )
end

function M.setup()
    if started then
        return
    end
    started = true
    for _, key in ipairs(keys) do
        local saved = state.get("toggle." .. key)
        if type(saved) == "boolean" then
            values[key] = saved
            apply(key, saved)
        end
    end
    local group =
        vim.api.nvim_create_augroup("TEN_toggle_preferences", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter", "FileType" }, {
        group = group,
        callback = function()
            -- Run after ftplugins and LazyVim's filetype defaults.
            vim.schedule(function()
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    restore_window(win)
                end
            end)
        end,
    })
    if not vim.lsp.codelens.enable then
        vim.api.nvim_create_autocmd(
            { "BufEnter", "CursorHold", "InsertLeave" },
            {
                group = group,
                callback = function(event)
                    lenses(event.buf)
                end,
            }
        )
    end
end

function M.configure_lsp(opts)
    local hints = vim.deepcopy(
        opts.inlay_hints or { enabled = true, exclude = { "vue" } }
    )
    local codelens = vim.deepcopy(opts.codelens or { enabled = false })
    -- Own these handlers so a later attachment cannot undo a user's selection.
    opts.inlay_hints = vim.tbl_extend("force", hints, { enabled = false })
    opts.codelens = vim.tbl_extend("force", codelens, { enabled = false })
    if values.codelens == nil then
        values.codelens = codelens.enabled == true
        apply("codelens", values.codelens)
    end
    Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buf)
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "" then
            local enabled = values.inlay_hints
            if enabled == nil then
                enabled = hints.enabled
                    and not vim.tbl_contains(
                        hints.exclude or {},
                        vim.bo[buf].filetype
                    )
            end
            vim.lsp.inlay_hint.enable(enabled, { bufnr = buf })
        end
    end)
    if not vim.lsp.codelens.enable then
        Snacks.util.lsp.on({ method = "textDocument/codeLens" }, lenses)
    end
end

return M
