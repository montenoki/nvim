local Util = require('util')
local Icon = require('icons')

return {
  -- Breadcrumb Bar
  {
    'SmiteshP/nvim-navic',
    lazy = true,
    init = function()
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
      vim.g.navic_silence = true
      Util.lsp.on_attach(function(client, buffer)
        if client.supports_method('textDocument/documentSymbol') then
          require('nvim-navic').attach(client, buffer)
        end
      end)
    end,
    opts = {
      icons = Icon.navic,
      lsp = {
        auto_attach = false,
        preference = nil,
      },
      highlight = true,
      depth_limit = 4,
      separator = Icon.navic.separator,
      click = true,
      lazy_update_context = true,
    },
  },

  -- Lsp configure
  {
    'neovim/nvim-lspconfig',
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
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        signs = true,
        show_header = false,
        virtual_text = {
          spacing = 2,
          source = 'if_many',
          prefix = Icon.lsp.diag_prefix,
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        float = {
          source = 'always',
          border = 'rounded',
          style = 'minimal',
          header = '',
        },
        severity_sort = true,
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
      },
      capabilities = {},
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      ---@diagnostic disable-next-line: missing-fields
      servers = {
        vimls = {},
        lua_ls = {
          ---@type LazyKeysSpec[]
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        ---@diagnostic disable-next-line: missing-fields
        bashls = {
          bashIde = {
            globPattern = '**/*@(.sh|.inc|.bash|.command|.zsh|zshrc|zsh_*)',
          },
        },
        ---@diagnostic disable-next-line: missing-fields
        jsonls = {},
      }, -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {},
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      if Util.has('neoconf.nvim') then
        local plugin = require('lazy.core.config').spec.plugins['neoconf.nvim']
        require('neoconf').setup(
          require('lazy.core.plugin').values(plugin, 'opts', false)
        )
      end

      -- setup autoformat
      Util.format.register(Util.lsp.formatter())

      -- deprectaed options
      ---@diagnostic disable-next-line: undefined-field
      if opts.autoformat ~= nil then
        ---@diagnostic disable-next-line: undefined-field
        vim.g.autoformat = opts.autoformat
        Util.deprecate('nvim-lspconfig.opts.autoformat', 'vim.g.autoformat')
      end

      -- setup keymaps
      Util.lsp.on_attach(function(client, buffer)
        require('plugins.lsp.keymaps').on_attach(client, buffer)
      end)

      local register_capability = vim.lsp.handlers['client/registerCapability']

      ---@diagnostic disable-next-line: duplicate-set-field
      vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        ---@type lsp.Client
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require('plugins.lsp.keymaps').on_attach(client, buffer)
        return ret
      end

      -- diagnostics
      for name, icon in pairs(Icon.diagnostics) do
        name = 'DiagnosticSign' .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
      end

      if opts.inlay_hints.enabled then
        Util.lsp.on_attach(function(client, buffer)
          if client.supports_method('textDocument/inlayHint') then
            Util.toggle.inlay_hints(buffer, true)
          end
        end)
      end

      if
        type(opts.diagnostics.virtual_text) == 'table'
        and opts.diagnostics.virtual_text.prefix == 'icons'
      then
        opts.diagnostics.virtual_text.prefix = vim.fn.has('nvim-0.10.0') == 0
            and Icon.lsp.virtual_text_prefix
          or function(diagnostic)
            local icons = require('lazyvim.config').icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
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
        all_mslp_servers = vim.tbl_keys(
          require('mason-lspconfig.mappings.server').lspconfig_to_package
        )
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if
            server_opts.mason == false
            or not vim.tbl_contains(all_mslp_servers, server)
          then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end

      if Util.lsp.get_config('denols') and Util.lsp.get_config('tsserver') then
        local is_deno =
          require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc')
        Util.lsp.disable('tsserver', is_deno)
        Util.lsp.disable('denols', function(root_dir)
          return not is_deno(root_dir)
        end)
      end
    end,
  },

  -- cmdline tools and lsp servers
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    opts = {
      ensure_installed = { 'taplo', 'shfmt', 'stylua', 'tree-sitter-cli' },
      ui = { icons = Icon.mason },
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

  -- none-ls
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    dependencies = { 'mason.nvim' },
    init = function()
      Util.on_very_lazy(function()
        -- register the formatter with LazyVim
        require('util').format.register({
          name = 'none-ls.nvim',
          priority = 200, -- set higher than conform, the builtin formatter
          primary = true,
          format = function(buf)
            return Util.lsp.format({
              bufnr = buf,
              filter = function(client)
                return client.name == 'null-ls'
              end,
            })
          end,
          sources = function(buf)
            local ret = require('null-ls.sources').get_available(
              vim.bo[buf].filetype,
              'NULL_LS_FORMATTING'
            ) or {}
            return vim.tbl_map(function(source)
              return source.name
            end, ret)
          end,
        })
      end)
    end,
    opts = function(_, opts)
      opts.root_dir = opts.root_dir
        or require('null-ls.utils').root_pattern(
          '.null-ls-root',
          '.neoconf.json',
          'Makefile',
          '.git'
        )
    end,
  },
}
