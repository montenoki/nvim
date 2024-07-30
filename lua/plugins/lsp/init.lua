local config = require('config')
local lspKeymaps = require('plugins.lsp.keymaps')

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    dependencies = {
      'mason.nvim',
      { 'williamboman/mason-lspconfig.nvim', config = function() end },
    },
    opts = {
      document_highlight = {
        enabled = true,
      },
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = 'icons',
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = config.icons.diagnostics.Info,
          },
        },
      },
      inlay_hints = {
        enabled = true,
        exclude = {},
      },
      codelens = {
        enabled = true,
      },
      -- add any global capabilities here
      capabilities = {},
      format = {
        -- options for vim.lsp.buf.format
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {},
      setup = {},
    },
    config = function(_, opts)
      -- 从 lazy.nvim获取插件信息和选项
      local function getPlugin(name)
        return require('lazy.core.config').spec.plugins[name]
      end
      local function getPluginOpts(name)
        local plugin = getPlugin(name)
        if not plugin then
          return {}
        end
        local Plugin = require('lazy.core.plugin')
        return Plugin.values(plugin, 'opts', false)
      end

      -- =======================================================================
      -- 配置autoformat
      -- =======================================================================
      local function lspFormat(options)
        -- 这个函数处理LSP格式化
        -- 它首先尝试使用 'conform' 插件进行格式化，因为它有更好的格式差异比较功能
        -- 如果 'conform' 不可用，则回退到使用Vim内置的 vim.lsp.buf.format 函数。
        options = vim.tbl_deep_extend(
          'force',
          {},
          options or {},
          getPluginOpts('nvim-lspconfig').format or {},
          opts('conform.nvim').format or {}
        )
        local ok, conform = pcall(require, 'conform')
        -- use conform for formatting with LSP when available,
        -- since it has better format diffing
        if ok then
          options.formatters = {}
          conform.format(options)
        else
          vim.lsp.buf.format(options)
        end
      end

      local function getClients(options)
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

      local formatters = {}
      local function formatRegister(formatter)
        -- 注册格式化器
        -- 它将新的格式化器添加到 formatters 表中，并按照优先级排序。
        formatters[#formatters + 1] = formatter
        table.sort(formatters, function(a, b)
          return a.priority > b.priority
        end)
      end

      local function lspFormatter(options)
        -- 创建一个LSP格式化器对象
        -- 它定义了格式化器的名称、优先级、格式化函数和源获取函数
        -- 格式化函数使用 lspFormat，而源获取函数则返回支持格式化的LSP客户端名称列表
        options = options or {}
        local filter = options.filter or {}
        filter = type(filter) == 'string' and { name = filter } or filter
        ---@cast filter lsp.Client.filter
        ---@type LazyFormatter
        local ret = {
          name = 'LSP',
          primary = true,
          priority = 1,
          format = function(buf)
            lspFormat(vim.tbl_deep_extend('force', {}, filter, { bufnr = buf }))
          end,
          sources = function(buf)
            local clients = getClients(vim.tbl_deep_extend('force', {}, filter, { bufnr = buf }))

            local ret = vim.tbl_filter(function(client)
              return client.supports_method('textDocument/formatting')
                or client.supports_method('textDocument/rangeFormatting')
            end, clients)
            return vim.tbl_map(function(client)
              return client.name
            end, ret)
          end,
        }
        return vim.tbl_deep_extend('force', ret, options)
      end

      -- 创建一个默认的LSP格式化器并注册它
      formatRegister(lspFormatter())

      -- =======================================================================
      -- 配置keymaps
      -- =======================================================================
      local supportsMethod = {}

      local function lspOnAttach(on_attach, name)
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

      local function checkMethods(client, buffer)
        -- 检查LSP客户端是否支持特定的方法。
        -- 如果支持,触发 'LspSupportsMethod' 用户自动命令。

        -- don't trigger on invalid buffers
        if not vim.api.nvim_buf_is_valid(buffer) then
          return
        end
        -- don't trigger on non-listed buffers
        if not vim.bo[buffer].buflisted then
          return
        end
        -- don't trigger on nofile buffers
        if vim.bo[buffer].buftype == 'nofile' then
          return
        end
        for method, clients in pairs(supportsMethod) do
          clients[client] = clients[client] or {}
          if not clients[client][buffer] then
            if client.supports_method and client.supports_method(method, { bufnr = buffer }) then
              clients[client][buffer] = true
              vim.api.nvim_exec_autocmds('User', {
                pattern = 'LspSupportsMethod',
                data = { client_id = client.id, buffer = buffer, method = method },
              })
            end
          end
        end
      end
      local function onDynamicCapability(fn, options)
        -- 创建一个自动命令,在LSP客户端动态能力变化时触发
        return vim.api.nvim_create_autocmd('User', {
          pattern = 'LspDynamicCapability',
          group = options and options.group or nil,
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            local buffer = args.data.buffer
            if client then
              return fn(client, buffer)
            end
          end,
        })
      end

      local function lspSetup()
        -- 重写 'client/registerCapability' 处理程序
        -- 当LSP客户端注册新能力时,触发 'LspDynamicCapability' 用户自动命令。
        -- 设置 lspOnAttach 和 onDynamicCapability 来调用 checkMethods。
        local register_capability = vim.lsp.handlers['client/registerCapability']
        vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
          ---@diagnostic disable-next-line: no-unknown
          local ret = register_capability(err, res, ctx)
          local client = vim.lsp.get_client_by_id(ctx.client_id)
          if client then
            for buffer in pairs(client.attached_buffers) do
              vim.api.nvim_exec_autocmds('User', {
                pattern = 'LspDynamicCapability',
                data = { client_id = client.id, buffer = buffer },
              })
            end
          end
          return ret
        end
        lspOnAttach(checkMethods)
        onDynamicCapability(checkMethods)
      end

      -- 在LSP客户端附加时,调用 keymaps 模块的 on_attach 函数。
      lspOnAttach(function(client, buffer)
        lspKeymaps.on_attach(client, buffer)
      end)

      lspSetup()
  
      -- 在LSP客户端动态能力变化时,调用 keymaps 模块的 on_attach 函数。
      onDynamicCapability(lspKeymaps.on_attach)

      -- =======================================================================
      -- 配置文档高亮(高亮显示当前单词)
      -- =======================================================================
      local words = {}
      local wordsNs = vim.api.nvim_create_namespace('vim_lsp_references')
      local wordsEnabled = false
      local function onSupportsMethod(method, fn)
        supportsMethod[method] = supportsMethod[method] or setmetatable({}, { __mode = 'k' })
        return vim.api.nvim_create_autocmd('User', {
          pattern = 'LspSupportsMethod',
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            local buffer = args.data.buffer ---@type number
            if client and method == args.data.method then
              return fn(client, buffer)
            end
          end,
        })
      end

      local function cmpVisible()
        local cmp = package.loaded['cmp']
        return cmp and cmp.core.view:visible()
      end

      local function wordsGet()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local current, ret = nil, {}
        for _, extmark in ipairs(vim.api.nvim_buf_get_extmarks(0, wordsNs, 0, -1, { details = true })) do
          local w = {
            from = { extmark[2] + 1, extmark[3] },
            to = { extmark[4].end_row + 1, extmark[4].end_col },
          }
          ret[#ret + 1] = w
          if cursor[1] >= w.from[1] and cursor[1] <= w.to[1] and cursor[2] >= w.from[2] and cursor[2] <= w.to[2] then
            current = #ret
          end
        end
        return ret, current
      end

      local function lspWordsSetup(options)
        options = options or {}
        if not options.enabled then
          return
        end
        wordsEnabled = true
        local handler = vim.lsp.handlers['textDocument/documentHighlight']
        vim.lsp.handlers['textDocument/documentHighlight'] = function(err, result, ctx, config)
          if not vim.api.nvim_buf_is_loaded(ctx.bufnr) then
            return
          end
          vim.lsp.buf.clear_references()
          return handler(err, result, ctx, config)
        end

        onSupportsMethod('textDocument/documentHighlight', function(_, buf)
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI', 'CursorMoved', 'CursorMovedI' }, {
            group = vim.api.nvim_create_augroup('lsp_word_' .. buf, { clear = true }),
            buffer = buf,
            callback = function(ev)
              if not lspKeymaps.has(buf, 'documentHighlight') then
                return false
              end

              if not ({ wordsGet() })[2] then
                if ev.event:find('CursorMoved') then
                  vim.lsp.buf.clear_references()
                elseif not cmpVisible() then
                  vim.lsp.buf.document_highlight()
                end
              end
            end,
          })
        end)
      end
      lspWordsSetup(opts.document_highlight)

      -- =======================================================================
      -- 配置diagnostics
      -- =======================================================================
      if vim.fn.has('nvim-0.10.0') == 0 then
        -- Neovim版本低于0.10.0：
        -- 如果诊断标志不是布尔值，则为每个严重级别定义一个诊断标志
        -- 使用 vim.fn.sign_define 定义标志，设置图标和高亮
        if type(opts.diagnostics.signs) ~= 'boolean' then
          for severity, icon in pairs(opts.diagnostics.signs.text) do
            local name = vim.diagnostic.severity[severity]:lower():gsub('^%l', string.upper)
            name = 'DiagnosticSign' .. name
            vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
          end
        end
      end

      -- 检查虚拟文本设置是否为表格且前缀设置为'icons'
      if type(opts.diagnostics.virtual_text) == 'table' and opts.diagnostics.virtual_text.prefix == 'icons' then
        -- 如果Neovim版本低于0.10.0，使用 '●' 作为前缀
        opts.diagnostics.virtual_text.prefix = vim.fn.has('nvim-0.10.0') == 0 and '●'
          or function(diagnostic)
            -- 根据诊断严重级别返回相应的图标
            local icons = config.icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      -- 应用诊断配置
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- =======================================================================
      -- 配置镶嵌提示(inlay hints)
      -- =======================================================================
      if vim.fn.has('nvim-0.10') == 1 then
        -- inlay hints
        if opts.inlay_hints.enabled then
          onSupportsMethod('textDocument/inlayHint', function(client, buffer)
            if
              vim.api.nvim_buf_is_valid(buffer)
              and vim.bo[buffer].buftype == ''
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
            then
              vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
            end
          end)
        end
      end

      -- =======================================================================
      -- 配置codelens
      -- =======================================================================
      if vim.fn.has('nvim-0.10') == 1 then
        if opts.codelens.enabled and vim.lsp.codelens then
          onSupportsMethod('textDocument/codeLens', function(client, buffer)
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
              buffer = buffer,
              callback = vim.lsp.codelens.refresh,
            })
          end)
        end
      end

      -- =======================================================================
      -- 配置Lsp Servers和Capabilities
      -- =======================================================================
      -- 初始化和能力设置
      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      -- 设置单个 LSP 服务器。
      -- 处理服务器特定的选项，并允许自定义设置。
      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup['*'] then
          if opts.setup['*'](server, server_opts) then
            return
          end
        end
        require('lspconfig')[server].setup(server_opts)
      end

      -- 检查是否安装了 mason-lspconfig，并获取所有可用的 Mason 管理的 LSP 服务器
      local have_mason, mlsp = pcall(require, 'mason-lspconfig')
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)
      end

      -- 遍历所有配置的服务器，决定是手动设置还是通过 Mason 安装
      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      -- 如果安装了 Mason，设置要确保安装的服务器列表，并使用之前定义的 setup 函数作为处理器
      if have_mason then
        mlsp.setup({
          ensure_installed = vim.tbl_deep_extend(
            'force',
            ensure_installed,
            getPluginOpts('mason-lspconfig.nvim').ensure_installed or {}
          ),
          handlers = { setup },
        })
      end
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    opts = { ensure_installed = {} },
    config = function(_, opts)
      require('mason').setup(opts)
      local registry = require('mason-registry')
      -- 当一个包安装成功时，为了让新安装的语言服务器有机会加载
      -- 延迟 100 毫秒后触发 'FileType' 事件
      registry:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      -- 刷新包注册表并安装指定的工具
      registry.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = registry.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
