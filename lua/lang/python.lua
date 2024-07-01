local lazyvim = require('lazyvim')

return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'ruff' })
      end
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'ninja', 'python', 'rst', 'toml' })
      end
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
              useLibraryCodeForTypes = true,
            },
          },
        },
        -- basedpyright = {
        --   analysis = {
        --     autoSearchPaths = true,
        --     diagnosticMode = 'openFilesOnly',
        --   },
        -- },
        ruff = {
          keys = {
            {
              '<leader>co',
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
        ruff = function()
          ---@diagnostic disable-next-line: undefined-field
          lazyvim.lsp.on_attach(function(client, _)
            if client.name == 'ruff' then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      local python_formatter = { python = { 'ruff_format' } }
      if type(opts.formatters_by_ft) == 'table' then
        opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft, python_formatter)
      end
    end,
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
        local executable_path = string.find(os, 'Windows') and '\\.virtualenvs\\debugpy\\Scripts\\python.exe'
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
    'linux-cultist/venv-selector.nvim',
    lazy = false,
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python',
      'nvim-telescope/telescope.nvim',
    },
    branch = 'regexp',
    config = function()
      require('venv-selector').setup()
    end,
    keys = {
      { '<LEADER>cv', '<CMD>VenvSelect<CR>', desc = 'Select VirtualEnv' },
    },
  },
  {
    'lualine.nvim',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        require('util.lualine').show_venv,
        cond = function()
          return vim.bo.filetype == 'python'
        end,
        on_click = function()
          vim.cmd.VenvSelect()
        end,
        ---@diagnostic disable-next-line: undefined-field
        color = lazyvim.ui.fg('character'),
        fmt = require('util.lualine').trunc(80, 5, 80),
      })
    end,
  },
}
