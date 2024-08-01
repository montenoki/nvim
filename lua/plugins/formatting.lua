local keymaps = require('keymaps')
local utils = require('utils')

local M = {}
function M.setup(_, opts)
  for _, key in ipairs({ 'format_on_save', 'format_after_save' }) do
    if opts[key] then
      local msg = "Don't set `opts.%s` for `conform.nvim`"
      utils.warn(msg:format(key))
      opts[key] = nil
    end
  end
  if opts.format then
    utils.warn('**conform.nvim** `opts.format` is deprecated. Please use `opts.default_format_opts` instead.')
  end
  require('conform').setup(opts)
end

return {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  lazy = true,
  cmd = 'ConformInfo',
  keys = {
    {
      keymaps.format.format_injected,
      function()
        require('conform').format({ formatters = { 'injected' }, timeout_ms = 3000 })
        utils.info('Injected Codes Formatted.')
      end,
      mode = { 'n', 'v' },
      desc = 'Format Injected Codes',
    },
  },
  init = function()
    -- Install the conform formatter on VeryLazy
    utils.on_very_lazy(function()
      utils.register({
        name = 'conform.nvim',
        priority = 100,
        primary = true,
        format = function(buf)
          require('conform').format({ bufnr = buf })
        end,
        sources = function(buf)
          local ret = require('conform').list_formatters(buf)
          return vim.tbl_map(function(v)
            return v.name
          end, ret)
        end,
      })
    end)
  end,
  opts = function()
    local plugin = require('lazy.core.config').plugins['conform.nvim']
    if plugin.config ~= M.setup then
      utils.error({
        "Don't set `plugin.config` for `conform.nvim`.\n",
      }, { title = 'Formatter' })
    end
    local opts = {
      -- LazyVim will use these options when formatting with the conform.nvim formatter
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = 'fallback', -- not recommended to change
      },
      formatters_by_ft = {},
      -- The options you set here will be merged with the builtin formatters.
      -- You can also define any custom formatters here.
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- # Example of using dprint only when a dprint.json file is present
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
        --
        -- # Example of using shfmt with extra args
        -- shfmt = {
        --   prepend_args = { "-i", "2", "-ci" },
        -- },
      },
    }
    return opts
  end,
  config = M.setup,
}
