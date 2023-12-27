local Icon = require('icons')
---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == 'function' and (config.args() or {})
    or config.args
    or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    ---@diagnostic disable-next-line: redundant-parameter
    local new_args = vim.fn.input('Run with args: ', table.concat(args, ' ')) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], ' ')
  end
  return config
end

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- fancy UI for the debugger
    {
      'rcarriga/nvim-dap-ui',
      -- stylua: ignore
      keys = {
        { "<LEADER>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<LEADER>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
      opts = {
        controls = {
          element = 'repl',
          enabled = vim.g.lite_mode and false or true,
          icons = {
            disconnect = '',
            pause = '',
            play = '',
            run_last = '',
            step_back = '',
            step_into = '',
            step_out = '',
            step_over = '',
            terminate = '',
          },
        },
        icons = Icon.dap.icons,
      },
      config = function(_, opts)
        -- setup dap config by VsCode launch.json file
        -- require("dap.ext.vscode").load_launchjs()
        local dap = require('dap')
        local dapui = require('dapui')
        dapui.setup(opts)
        dap.listeners.after.event_initialized['dapui_config'] = function()
          dapui.open({})
        end
      end,
    },

    -- virtual text for the debugger
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },

    -- which key integration
    {
      'folke/which-key.nvim',
      optional = true,
      opts = {
        defaults = {
          ['<LEADER>d'] = { name = '+debug' },
        },
      },
    },

    -- mason.nvim integration
    {
      'jay-babu/mason-nvim-dap.nvim',
      dependencies = 'mason.nvim',
      cmd = { 'DapInstall', 'DapUninstall' },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
    },
    {
      'jbyuki/one-small-step-for-vimkind',
      -- stylua: ignore
      config = function()
        local dap = require("dap")
        dap.adapters.nlua = function(callback, conf)
          local adapter = {
            type = "server",
            ---@diagnostic disable-next-line: undefined-field
            host = conf.host or "127.0.0.1",
            ---@diagnostic disable-next-line: undefined-field
            port = conf.port or 8086,
          }
            ---@diagnostic disable-next-line: undefined-field
          if conf.start_neovim then
            local dap_run = dap.run
            ---@diagnostic disable-next-line: duplicate-set-field
            dap.run = function(c)
              adapter.port = c.port
              adapter.host = c.host
            end
            require("osv").run_this()
            dap.run = dap_run
          end
          callback(adapter)
        end
        dap.configurations.lua = {
          {
            type = "nlua",
            request = "attach",
            name = "Run this file",
            start_neovim = {},
          },
          {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance (port = 8086)",
            port = 8086,
          },
        }
      end,
    },
  },

  -- stylua: ignore
  keys = {
    { "<LEADER>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<LEADER>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<LEADER>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<LEADER>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<LEADER>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<LEADER>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<LEADER>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<LEADER>dj", function() require("dap").down() end, desc = "Down" },
    { "<LEADER>dk", function() require("dap").up() end, desc = "Up" },
    { "<LEADER>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<LEADER>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<LEADER>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<LEADER>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<LEADER>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<LEADER>ds", function() require("dap").session() end, desc = "Session" },
    { "<LEADER>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<LEADER>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

  config = function()
    vim.api.nvim_set_hl(
      0,
      'DapStoppedLine',
      { default = true, link = 'Visual' }
    )

    for name, sign in pairs(Icon.dap) do
      sign = type(sign) == 'table' and sign or { sign }
      vim.fn.sign_define('Dap' .. name, {
        text = sign[1],
        texthl = sign[2] or 'DiagnosticInfo',
        linehl = sign[3],
        numhl = sign[3],
      })
    end
  end,
}
