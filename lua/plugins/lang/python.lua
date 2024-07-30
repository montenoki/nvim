local keymaps = require('keymaps')
local utils = require('utils')

local function color(name, bg)
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

local function fg(name)
  local color = color(name)
  return color and { fg = color } or nil
end

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

local action = setmetatable({}, {
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
          keys = { { keymaps.lsp.organize, action['source.organizeImports'], desc = 'Organize Imports' } },
        },
      },
      setup = {
        ruff_lsp = function()
          lspOnAttach(function(client, _)
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
        -- color = fg('character'),
        -- fmt = utils.trunc(80, 5, 80),
      })
    end,
  },
}
