local keymaps = require('keymaps')
local utils = require('utils')


return {
  {
    'linux-cultist/venv-selector.nvim',
    branch = 'regexp', -- Use this branch for the new version
    cmd = 'VenvSelect',
    -- enabled = function()
    --   return utils.has('telescope.nvim')
    -- end,
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
    --  Call config for python files and load the cached venv automatically
    ft = 'python',
    keys = { { '<leader>cv', '<cmd>:VenvSelect<cr>', desc = 'Select VirtualEnv', ft = 'python' } },
  },
  -- ===========================================================================
  -- treesitter
  -- ===========================================================================
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'python', 'toml' })
      end
    end,
  },
  -- ===========================================================================
  -- lsp
  -- ===========================================================================
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'workspace',
                exclude = { 'tests', 'test', 'dist', 'build', '.venv', '.git' },
                typeCheckingMode = 'standard',
              },
            },
          },
        },
        ruff_lsp = {
          keys = { { keymaps.lsp.organize, utils.action['source.organizeImports'], desc = 'Organize Imports' } },
        },
      },
      setup = {
        ruff_lsp = function()
          utils.lspOnAttach(function(client, _)
            if client.name == 'ruff_lsp' then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },
  -- ===========================================================================
  -- lualine
  -- ===========================================================================
  {
    'lualine.nvim',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        'venv-selector',
        -- cond = function()
        --   return vim.bo.filetype == 'python'
        -- end,
        -- on_click = function()
        --   vim.cmd.VenvSelect()
        -- end,
        -- color = utils.fg('character'),
        -- fmt = utils.trunc(80, 5, 80),
      })
    end,
  },
}
