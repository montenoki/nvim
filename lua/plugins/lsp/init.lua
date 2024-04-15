local Lazyvim = require('lazyvim')
local Ascii_icons = require('util.ascii_icons')

return {
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
      enabled = true,
    },
    capabilities = {},
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
    -- LSP Server Settings
    servers = {
      vimls = {},
      lua_ls = {
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
      bashls = {
        bashIde = {
          globPattern = '**/*@(.sh|.inc|.bash|.command|.zsh|zshrc|zsh_*)',
        },
      },
      jsonls = {},
    },
    setup = {},
  },
  ---@param opts PluginLspOpts
  config = function(_, opts)
    if Lazyvim.has('neoconf.nvim') then
      local plugin = require('lazy.core.config').spec.plugins['neoconf.nvim']
      require('neoconf').setup(require('lazy.core.plugin').values(plugin, 'opts', false))
    end

    -- setup autoformat
    Lazyvim.format.register(Lazyvim.lsp.formatter())

    -- deprectaed options
    ---@diagnostic disable-next-line: undefined-field
    if opts.autoformat ~= nil then
      ---@diagnostic disable-next-line: undefined-field
      vim.g.autoformat = opts.autoformat
      Lazyvim.deprecate('nvim-lspconfig.opts.autoformat', 'vim.g.autoformat')
    end

    -- setup keymaps
    Lazyvim.lsp.on_attach(function(client, buffer)
      require('plugins.lsp.keymaps').on_attach(client, buffer)
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
      or Ascii_icons.diagnostics
    -- diagnostics
    for name, icon in pairs(diagnostic_icon) do
      name = 'DiagnosticSign' .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
    end

    if opts.inlay_hints.enabled then
      Lazyvim.lsp.on_attach(function(client, buffer)
        if client.supports_method('textDocument/inlayHint') then
          Lazyvim.toggle.inlay_hints(buffer, true)
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

    if Lazyvim.lsp.get_config('denols') and Lazyvim.lsp.get_config('tsserver') then
      local is_deno = require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc')
      Lazyvim.lsp.disable('tsserver', is_deno)
      Lazyvim.lsp.disable('denols', function(root_dir)
        return not is_deno(root_dir)
      end)
    end
  end,
}
