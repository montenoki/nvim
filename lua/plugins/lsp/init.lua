local lazyvim = require('lazyvim')
local ascii = require('util.ascii')

return {
  {
    'neovim/nvim-lspconfig',
    cond = vim.g.vscode == nil,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    dependencies = {
      {
        'folke/neoconf.nvim',
        cmd = 'Neoconf',
        config = false,
        dependencies = { 'nvim-lspconfig' },
      },
      { 'folke/neodev.nvim', opts = {} },
      'mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    ---@class PluginLspOpts
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        signs = true,
        show_header = false,
        virtual_text = {
          spacing = 2,
          source = 'if_many',
          prefix = vim.g.lite == nil and '󰆈' or '>',
        },
        float = {
          source = 'always',
          border = 'rounded',
          style = 'minimal',
          header = '',
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = false,
      },
      capabilities = {},
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      servers = {
        vimls = {},
      },
      setup = {},
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      if lazyvim.has('neoconf.nvim') then
        local plugin = require('lazy.core.config').spec.plugins['neoconf.nvim']
        require('neoconf').setup(require('lazy.core.plugin').values(plugin, 'opts', false))
      end

      -- setup autoformat
      lazyvim.format.register(lazyvim.lsp.formatter())

      -- deprectaed options
      ---@diagnostic disable-next-line: undefined-field
      if opts.autoformat ~= nil then
        ---@diagnostic disable-next-line: undefined-field
        vim.g.autoformat = opts.autoformat
        lazyvim.deprecate('nvim-lspconfig.opts.autoformat', 'vim.g.autoformat')
      end

      -- setup keymaps
      lazyvim.lsp.on_attach(function(client, buffer)
        require('plugins.lsp.keymaps').on_attach(client, buffer)
      end)

      -- setup highlight current word
      lazyvim.lsp.on_attach(function(client, buffer)
        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd('CursorHold', {
            callback = function()
              vim.lsp.buf.document_highlight()
            end,
          })
          vim.api.nvim_create_autocmd('CursorMoved', {
            callback = function()
              vim.lsp.buf.clear_references()
            end,
          })
        end
      end)

      local register_capability = vim.lsp.handlers['client/registerCapability']

      vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require('plugins.lsp.keymaps').on_attach(client, buffer)
        return ret
      end
      local diagnostic_icon = vim.g.lite == nil and { Error = ' ', Warn = ' ', Hint = '󱩎 ', Info = ' ' }
        or ascii.diagnostics
      -- diagnostics
      for name, icon in pairs(diagnostic_icon) do
        name = 'DiagnosticSign' .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
      end

      if opts.inlay_hints.enabled then
        ---@diagnostic disable-next-line: undefined-field
        lazyvim.lsp.on_attach(function(client, buffer)
          if client.supports_method('textDocument/inlayHint') then
            ---@diagnostic disable-next-line: undefined-field
            lazyvim.toggle.inlay_hints(buffer, true)
          end
        end)
      end

      if type(opts.diagnostics.virtual_text) == 'table' and opts.diagnostics.virtual_text.prefix == 'icons' then
        opts.diagnostics.virtual_text.prefix = vim.g.lite == nil and '󰆈' or '>'
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

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

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, 'mason-lspconfig')
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end

      if lazyvim.lsp.get_config('denols') and lazyvim.lsp.get_config('tsserver') then
        local is_deno = require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc')
        lazyvim.lsp.disable('tsserver', is_deno)
        lazyvim.lsp.disable('denols', function(root_dir)
          return not is_deno(root_dir)
        end)
      end
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    cond = vim.g.vscode == nil,
    build = ':MasonUpdate',
    opts = {
      ensure_installed = { 'taplo', 'shfmt', 'shellcheck', 'tree-sitter-cli' },
      -- ui = { icons = Icon.mason },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
