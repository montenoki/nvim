local M = {}
local state = require("config.state")

M.default = "tokyonight-night"
M.system_themes = {
    ["tokyo-night"] = "tokyonight-night",
    kanagawa = "kanagawa-wave",
    ["retro-82"] = "retro-82",
    nord = "nord",
    gruvbox = "gruvbox-material",
    ["gruvbox-light"] = "gruvbox-material",
    ["tokyo-day"] = "tokyonight-day",
    ["kanagawa-lotus"] = "kanagawa-lotus",
    ["catppuccin-mocha"] = "catppuccin-mocha",
    ["catppuccin-latte"] = "catppuccin-latte",
}

local state_home = vim.env.XDG_STATE_HOME
if not state_home or state_home == "" then
    state_home = vim.fn.expand("~/.local/state")
end
M.system_path = state_home .. "/ten-theme/name"

local applying = false
local started = false
local last_system
local watcher
local generation = 0
local pending
local active_name

local function save_pending()
    if pending then
        state.set("theme", pending)
        pending = nil
    end
end

local function system_theme()
    local ok, lines = pcall(vim.fn.readfile, M.system_path)
    local id = ok and vim.trim(table.concat(lines, "")) or nil
    return id and M.system_themes[id] and id or nil
end

local function valid(name)
    return type(name) == "string" and name:match("^[%w_%-%.]+$") ~= nil
end

local function preference(value)
    -- Older preferences stored only the colorscheme name.
    if type(value) == "string" then
        value = { name = value }
    end
    if type(value) ~= "table" or not valid(value.name) then
        return nil
    end
    local background = value.background
    if background ~= "light" and background ~= "dark" then
        local light = value.name == "tokyonight-day"
            or value.name == "kanagawa-lotus"
            or value.name == "catppuccin-latte"
            or value.name == "flexoki-light"
            or value.name == "rose-pine-dawn"
            or value.name == "white"
        background = light and "light" or "dark"
    end
    return { name = value.name, background = background }
end

local function apply(system)
    applying = true
    local candidates = {}
    local selected = preference(M.system_themes[system])
    if selected then
        if system == "gruvbox-light" then
            selected.background = "light"
        end
        candidates[#candidates + 1] = selected
    end
    local saved = preference(state.get("theme"))
    if saved then
        candidates[#candidates + 1] = saved
    end
    candidates[#candidates + 1] = preference(M.default)
    candidates[#candidates + 1] = preference("habamax")
    for _, candidate in ipairs(candidates) do
        local ok = pcall(function()
            vim.o.background = candidate.background
            vim.cmd.colorscheme(candidate.name)
        end)
        if ok then
            active_name = candidate.name
            break
        end
    end
    applying = false
end

local function sync()
    local current = system_theme()
    if current ~= last_system then
        last_system = current
        apply(current)
    end
end

function M.setup()
    if started or vim.g.vscode then
        return
    end
    started = true
    local group = vim.api.nvim_create_augroup("TEN_theme", { clear = true })
    local function remember(name)
        generation = generation + 1
        pending = nil
        if applying then
            return
        end
        -- Browsing a picker is not a committed preference.
        if _G.Snacks and Snacks.picker then
            if #Snacks.picker.get({ source = "colorschemes" }) > 0 then
                return
            end
        end
        -- Some plugins set colors_name to their family, losing the variant.
        local ticket = generation
        pending = valid(name) and { name = name, background = vim.o.background }
            or nil
        vim.defer_fn(function()
            if ticket == generation and valid(name) then
                save_pending()
            end
        end, 150)
    end
    vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        callback = function(event)
            active_name = event.match
            remember(active_name)
        end,
    })
    vim.api.nvim_create_autocmd("OptionSet", {
        group = group,
        pattern = "background",
        callback = function()
            remember(active_name)
        end,
    })
    last_system = system_theme()
    apply(last_system)

    -- Watch the stable parent directory, including creation/replacement of name.
    -- FocusGained also handles a missing directory or a suspended editor.
    local function watch()
        if watcher then
            return
        end
        local handle = vim.uv.new_fs_event()
        if not handle then
            return
        end
        local ok = handle:start(
            vim.fn.fnamemodify(M.system_path, ":h"),
            {},
            function(err)
                if not err then
                    vim.defer_fn(sync, 75)
                end
            end
        )
        if ok then
            watcher = handle
        else
            handle:close()
        end
    end
    watch()
    vim.api.nvim_create_autocmd("FocusGained", {
        group = group,
        callback = function()
            watch()
            sync()
        end,
    })
    vim.api.nvim_create_autocmd("VimLeavePre", {
        group = group,
        callback = function()
            save_pending()
            if watcher then
                watcher:stop()
                watcher:close()
                watcher = nil
            end
        end,
    })
end

return M
