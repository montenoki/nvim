local Util = require('util')
local Icon = require('icons')
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Auto select virtualenv Nvim open',
  pattern = '*',
  callback = function()
    local venv = vim.fn.findfile('pyproject.toml', vim.fn.getcwd() .. ';')
    if venv ~= '' then
      require('venv-selector').retrieve_from_cache()
    end
  end,
  once = true,
})

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(
          opts.ensure_installed,
          { 'ninja', 'python', 'rst', 'toml' }
        )
      end
    end,
  },
  {
    'lualine.nvim',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_y, {
        function()
          local selector = require('venv-selector')
          local venv = selector
            .get_active_venv()
            :gsub(Util.root.cwd():gsub('%-', '%%-') .. '/', '') or 'NO ENV'
          local version = vim.fn
            .system(selector.get_active_path() .. ' --version')
            :gsub('Python ', '')
            :gsub('[%c%s]', '')
          return Icon.lualine.python .. venv .. '@' .. version
        end,
        cond = function()
          return vim.bo.filetype == 'python'
        end,
        fmt = Util.lualine.trunc(80, 5, 80),
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        pyright = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = 'openFilesOnly',
            },
          },
        },
        ruff_lsp = {
          keys = {
            {
              '<LEADER>co',
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { 'source.organizeImports' },
                    diagnostics = {},
                  },
                })
              end,
              desc = 'Organize Imports',
            },
          },
        },
      },
      setup = {
        ruff_lsp = function()
          require('util').lsp.on_attach(function(client, _)
            if client.name == 'ruff_lsp' then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    'nvim-neotest/neotest',
    optional = true,
    dependencies = {
      'nvim-neotest/neotest-python',
    },
    opts = {
      adapters = {
        ['neotest-python'] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    optional = true,
    dependencies = {
      'mfussenegger/nvim-dap-python',
      -- stylua: ignore
      keys = {
        { "<LEADER>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
        { "<LEADER>dPc", function() require('dap-python').test_class() end,  desc = "Debug Class",  ft = "python" },
      },
      config = function()
        -- local path = require("mason-registry").get_package("debugpy"):get_install_path()
        -- require("dap-python").setup(path .. "/venv/bin/python")
        local os = vim.loop.os_uname().sysname
        local executable_path = string.find(os, 'Windows')
            and '\\.virtualenvs\\debugpy\\Scripts\\python.exe'
          or '/.virtualenvs/debugpy/bin/python'
        local path = vim.env.HOME .. executable_path
        require('dap-python').setup(path)
        require('dap').configurations.python = {
          {
            type = 'python',
            request = 'launch',
            name = 'launch file in project root',
            program = '${file}',
            pythonPath = 'python',
            cwd = './',
          },
        }
      end,
    },
  },
  {
    'linux-cultist/venv-selector.nvim',
    cmd = 'VenvSelect',
    event = 'VeryLazy',
    opts = function(_, opts)
      if require('util').has('nvim-dap-python') then
        opts.dap_enabled = true
      end
      return vim.tbl_deep_extend('force', opts, {
        auto_refresh = true,
        name = {
          'venv',
          '.venv',
          'env',
          '.env',
        },
      })
    end,
    keys = {
      { '<LEADER>cv', '<CMD>:VenvSelect<CR>', desc = 'Select VirtualEnv' },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      local python_formater = { python = { 'ruff_format' } }
      if type(opts.formatters_by_ft) == 'table' then
        opts.formatters_by_ft =
          vim.tbl_deep_extend('force', opts.formatters_by_ft, python_formater)
      end
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'ruff' })
      end
    end,
  },
}
