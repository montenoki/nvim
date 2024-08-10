local M = {}

M.action = setmetatable({}, {
    __index = function(_, action)
        return function()
            vim.lsp.buf.code_action({
                apply = true,
                context = {
                    only = { action },
                    diagnostics = {},
                },
            })
        end
    end,
})

function M.removeDuplicates(list)
    local ret = {}
    local seen = {}
    for _, v in ipairs(list) do
        if not seen[v] then
            table.insert(ret, v)
            seen[v] = true
        end
    end
    return ret
end

function M.showRecording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == '' then
        return ''
    else
        return 'Rec @' .. recording_register
    end
end

function M.trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
    return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
            return ''
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
            return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
        end
        return str
    end
end

function M.is_win()
    return vim.uv.os_uname().sysname:find('Windows') ~= nil
end

function M.norm(path)
    if path:sub(1, 1) == '~' then
        local home = vim.uv.os_homedir()
        if home:sub(-1) == '\\' or home:sub(-1) == '/' then
            home = home:sub(1, -2)
        end
        path = home .. path:sub(2)
    end
    path = path:gsub('\\', '/'):gsub('/+', '/')
    return path:sub(-1) == '/' and path:sub(1, -2) or path
end

function M.realPath(path)
    if path == '' or path == nil then
        return nil
    end
    path = vim.uv.fs_realpath(path) or path
    return M.norm(path)
end

function M.cwd()
    return M.realPath(vim.uv.cwd()) or ''
end

-- 从 lazy.nvim获取插件信息和选项
function M.getPlugin(name)
    return require('lazy.core.config').spec.plugins[name]
end

function M.has(plugin)
    return M.getPlugin(plugin) ~= nil
end

function M.color(name, bg)
    local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name, link = false })
        or vim.api.nvim_get_hl_by_name(name, true)

    local color = nil
    if hl then
        if bg then
            color = hl.bg or hl.background
        else
            color = hl.fg or hl.foreground
        end
    end
    return color and string.format('#%06x', color) or nil
end

function M.fg(name)
    local color = M.color(name)
    return color and { fg = color } or nil
end

function M.getPluginOpts(name)
    local plugin = M.getPlugin(name)
    if not plugin then
        return {}
    end
    local Plugin = require('lazy.core.plugin')
    return Plugin.values(plugin, 'opts', false)
end
function M.getClients(options)
    -- 获取活跃的LSP客户端
    -- 它兼容不同版本的Neovim API，可以根据指定的选项筛选客户端
    local ret = {}
    if vim.lsp.get_clients then
        ret = vim.lsp.get_clients(options)
    else
        ret = vim.lsp.get_active_clients(options)
        if options and options.method then
            ret = vim.tbl_filter(function(client)
                return client.supports_method(options.method, { bufnr = options.bufnr })
            end, ret)
        end
    end
    return options and options.filter and vim.tbl_filter(options.filter, ret) or ret
end
function M.lspOnAttach(on_attach, name)
    -- 创建一个自动命令,在LSP客户端附加到缓冲区时触发
    -- 如果指定了名称,它只会为特定的LSP客户端触发。
    return vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and (not name or client.name == name) then
                return on_attach(client, buffer)
            end
        end,
    })
end

function M.info(msg, opts)
    opts = opts or {}
    opts.level = vim.log.levels.INFO
    M.notify(msg, opts)
end

function M.warn(msg, opts)
    opts = opts or {}
    opts.level = vim.log.levels.WARN
    M.notify(msg, opts)
end

function M.error(msg, opts)
    opts = opts or {}
    opts.level = vim.log.levels.ERROR
    M.notify(msg, opts)
end

function M.debug(msg, opts)
    if not require('lazy.core.config').options.debug then
        return
    end
    opts = opts or {}
    if opts.title then
        opts.title = 'lazy.nvim: ' .. opts.title
    end
    if type(msg) == 'string' then
        M.notify(msg, opts)
    else
        opts.lang = 'lua'
        M.notify(vim.inspect(msg), opts)
    end
end

function M.is_list(t)
    local i = 0
    for _ in pairs(t) do
        i = i + 1
        if t[i] == nil then
            return false
        end
    end
    return true
end

local function can_merge(v)
    return type(v) == 'table' and (vim.tbl_isempty(v) or not M.is_list(v))
end

function M.merge(...)
    local ret = select(1, ...)
    if ret == vim.NIL then
        ret = nil
    end
    for i = 2, select('#', ...) do
        local value = select(i, ...)
        if can_merge(ret) and can_merge(value) then
            for k, v in pairs(value) do
                ret[k] = M.merge(ret[k], v)
            end
        elseif value == vim.NIL then
            ret = nil
        elseif value ~= nil then
            ret = value
        end
    end
    return ret
end

function M.formatexpr()
    if M.has('conform.nvim') then
        return require('conform').formatexpr()
    end
    return vim.lsp.formatexpr({ timeout_ms = 3000 })
end

function M.register(formatter)
    -- 注册格式化器
    -- 它将新的格式化器添加到 formatters 表中，并按照优先级排序。
    M.formatters[#M.formatters + 1] = formatter
    table.sort(M.formatters, function(a, b)
        return a.priority > b.priority
    end)
end

function M.on_very_lazy(fn)
    vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
            fn()
        end,
    })
end

function M.format(opts)
    opts = opts or {}
    local buf = opts.buf or vim.api.nvim_get_current_buf()
    if not ((opts and opts.force) or M.enabled(buf)) then
        return
    end

    local done = false
    for _, formatter in ipairs(M.resolve(buf)) do
        if formatter.active then
            done = true
            M.try(function()
                M.debug('Formatting with `' .. formatter.resolved[1] .. '`', { title = 'Formatter' })
                return formatter.format(buf)
            end, { msg = 'Formatter `' .. formatter.name .. '` failed' })
        end
    end

    if not done and opts and opts.force then
        M.warn('No formatter available, Use lsp format function', { title = 'Formatter' })
        vim.lsp.buf.format()
    end
end

function M.try(fn, opts)
    opts = type(opts) == 'string' and { msg = opts } or opts or {}
    local msg = opts.msg
    -- error handler
    local error_handler = function(err)
        msg = (msg and (msg .. '\n\n') or '') .. err .. M.pretty_trace()
        if opts.on_error then
            opts.on_error(msg)
        else
            vim.schedule(function()
                M.error(msg)
            end)
        end
        return err
    end

    local ok, result = xpcall(fn, error_handler)
    return ok and result or nil
end

function M.enabled(buf)
    buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
    local gaf = vim.g.autoformat
    local baf = vim.b[buf].autoformat

    -- If the buffer has a local value, use that
    if baf ~= nil then
        return baf
    end

    -- Otherwise use the global value if set, or true by default
    return gaf == nil or gaf
end

M.formatters = {}
function M.resolve(buf)
    buf = buf or vim.api.nvim_get_current_buf()
    local have_primary = false
    return vim.tbl_map(function(formatter)
        local sources = formatter.sources(buf)
        local active = #sources > 0 and (not formatter.primary or not have_primary)
        have_primary = have_primary or (active and formatter.primary) or false
        return setmetatable({
            active = active,
            resolved = sources,
        }, { __index = formatter })
    end, M.formatters)
end

function M.notify(msg, opts)
    if vim.in_fast_event() then
        return vim.schedule(function()
            M.notify(msg, opts)
        end)
    end

    opts = opts or {}
    if type(msg) == 'table' then
        msg = table.concat(
            vim.tbl_filter(function(line)
                return line or false
            end, msg),
            '\n'
        )
    end
    if opts.stacktrace then
        msg = msg .. M.pretty_trace({ level = opts.stacklevel or 2 })
    end
    local lang = opts.lang or 'markdown'
    local n = opts.once and vim.notify_once or vim.notify
    n(msg, opts.level or vim.log.levels.INFO, {
        on_open = function(win)
            local ok = pcall(function()
                vim.treesitter.language.add('markdown')
            end)
            if not ok then
                pcall(require, 'nvim-treesitter')
            end
            vim.wo[win].conceallevel = 3
            vim.wo[win].concealcursor = ''
            vim.wo[win].spell = false
            local buf = vim.api.nvim_win_get_buf(win)
            if not pcall(vim.treesitter.start, buf, lang) then
                vim.bo[buf].filetype = lang
                vim.bo[buf].syntax = lang
            end
        end,
        title = opts.title or 'lazy.nvim',
    })
end
function M.pretty_trace(opts)
    opts = opts or {}
    local Config = require('lazy.core.config')
    local trace = {}
    local level = opts.level or 2
    while true do
        local info = debug.getinfo(level, 'Sln')
        if not info then
            break
        end
        if info.what ~= 'C' and (Config.options.debug or not info.source:find('lazy.nvim')) then
            local source = info.source:sub(2)
            if source:find(Config.options.root, 1, true) == 1 then
                source = source:sub(#Config.options.root + 1)
            end
            source = vim.fn.fnamemodify(source, ':p:~:.') --[[@as string]]
            local line = '  - ' .. source .. ':' .. info.currentline
            if info.name then
                line = line .. ' _in_ **' .. info.name .. '**'
            end
            table.insert(trace, line)
        end
        level = level + 1
    end
    return #trace > 0 and ('\n\n# stacktrace:\n' .. table.concat(trace, '\n')) or ''
end

function M.bufremove(buf)
    buf = buf or 0
    buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

    if vim.bo.modified then
        local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
        if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
            return
        end
        if choice == 1 then -- Yes
            vim.cmd.write()
        end
    end

    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        vim.api.nvim_win_call(win, function()
            if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
                return
            end
            -- Try using alternate buffer
            local alt = vim.fn.bufnr('#')
            if alt ~= buf and vim.fn.buflisted(alt) == 1 then
                vim.api.nvim_win_set_buf(win, alt)
                return
            end

            -- Try using previous buffer
            local has_previous = pcall(vim.cmd, 'bprevious')
            if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
                return
            end

            -- Create new listed buffer
            local new_buf = vim.api.nvim_create_buf(true, false)
            vim.api.nvim_win_set_buf(win, new_buf)
        end)
    end
    if vim.api.nvim_buf_is_valid(buf) then
        pcall(vim.cmd, 'bdelete! ' .. buf)
    end
end

function M.randomColorscheme(colorschemes)
    local count = #colorschemes
    math.randomseed(os.time())
    local randomIndex = math.random(1, count)
    local colorscheme = colorschemes[randomIndex]
    return colorscheme
end
function M.is_loaded(name)
    local Config = require('lazy.core.config')
    return Config.plugins[name] and Config.plugins[name]._.loaded
end
function M.on_load(name, fn)
    if M.is_loaded(name) then
        fn(name)
    else
        vim.api.nvim_create_autocmd('User', {
            pattern = 'LazyLoad',
            callback = function(event)
                if event.data == name then
                    fn(name)
                    return true
                end
            end,
        })
    end
end
function M.find_command()
    if 1 == vim.fn.executable('rg') then
        return { 'rg', '--files', '--color', 'never', '-g', '!.git' }
    elseif 1 == vim.fn.executable('fd') then
        return { 'fd', '--type', 'f', '--color', 'never', '-E', '.git' }
    elseif 1 == vim.fn.executable('fdfind') then
        return { 'fdfind', '--type', 'f', '--color', 'never', '-E', '.git' }
    elseif 1 == vim.fn.executable('find') and vim.fn.has('win32') == 0 then
        return { 'find', '.', '-type', 'f' }
    elseif 1 == vim.fn.executable('where') then
        return { 'where', '/r', '.', '*' }
    end
end
return M
