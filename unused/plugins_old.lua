local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap

-- Packer: Auto install
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify('Installing Packer.nvim... Please wait...')
  packer_bootstrap =
      fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  local rtp_addition = vim.fn.stdpath('data') .. '/site/pack/*/start/*'
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. ',' .. vim.o.runtimepath
  end
  vim.notify('Installation Done')
end

vim.api.nvim_create_user_command(
  'PackerInstall',
  [[packadd packer.nvim | lua require("lua.plugins").install()]],
  { bang = true }
)
vim.api.nvim_create_user_command(
  'PackerUpdate',
  [[packadd packer.nvim | lua require("lua.plugins").update()]],
  { bang = true }
)
vim.api.nvim_create_user_command(
  'PackerSync',
  [[packadd packer.nvim | lua require("lua.plugins").sync()]],
  { bang = true }
)
vim.api.nvim_create_user_command(
  'PackerClean',
  [[packadd packer.nvim | lua require("lua.plugins").clean()]],
  { bang = true }
)
vim.api.nvim_create_user_command(
  'PackerCompile',
  [[packadd packer.nvim | lua require("lua.plugins").compile()]],
  { bang = true }
)

local packer

local function init()
  if not packer then
    packer = require('packer')
    packer.init({
      display = {
        open_fn = require('packer.util').float,
      },
    })
  end
  packer.reset()
  packer.use({

    { 'wbthomason/packer.nvim' },

    ----- Interface ----
    ---------------------




    -- Outliner
    {
      'simrat39/symbols-outline.nvim',
      config = function()
        require('plugin-config.interface.symbols-outline')
      end,
    },


    -- Marks
    {
      'chentoast/marks.nvim',
      config = function()
        require('plugin-config.interface.marks')
      end,
    },


    ----- Code Appearance  -----
    ----------------------------

    -- Highlighting
    {
      'nvim-treesitter/nvim-treesitter',
      run = function()
        require('nvim-treesitter.install').update({
          with_sync = true,
        })
      end,
      config = function()
        require('plugin-config.appearance.nvim-treesitter')
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      after = 'nvim-treesitter',
      requires = 'nvim-treesitter/nvim-treesitter',
    },
    {
      'nvim-treesitter/nvim-treesitter-refactor',
      after = 'nvim-treesitter',
      requires = 'nvim-treesitter/nvim-treesitter',
    },

    -- To-do Comments.nvim
    {
      'folke/todo-comments.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('plugin-config.appearance.todo-comments')
      end,
    },

 

    -- Fold
    {
      'kevinhwang91/nvim-ufo',
      requires = {
        'kevinhwang91/promise-async',
        {
          'luukvbaal/statuscol.nvim',
          config = function()
            require('plugin-config.appearance.statuscol')
          end,
        },
      },
      config = function()
        require('plugin-config.appearance.ufo')
      end,
    },

    -- gitsigns
    {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('plugin-config.appearance.gitsigns')
        require('scrollbar.handlers.gitsigns').setup()
      end,
    },

    -- lspsaga
    {
      'glepnir/lspsaga.nvim',
      opt = true,
      branch = 'main',
      event = 'BufReadPost',
      config = function()
        require('lspsaga').setup({})
      end,
      requires = {
        { 'nvim-tree/nvim-web-devicons' },
        --Please make sure you install markdown and markdown_inline parser
        { 'nvim-treesitter/nvim-treesitter' },
      },
      after = 'nvim-lspconfig',
    },

    ----- Editor -----
    ------------------

    -- Refactoring
    {
      'ThePrimeagen/refactoring.nvim',
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-treesitter/nvim-treesitter' },
      },
      config = function()
        require('plugin-config.editor.refactoring')
      end,
    },


    ----- Search Tools -----
    ------------------------

    -- Telescope
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.1',
      requires = {
        'nvim-lua/plenary.nvim',
      },
      config = function()
        require('plugin-config.search.telescope')
      end,
    },
    { 'LinArcX/telescope-env.nvim' },
    { 'LinArcX/telescope-command-palette.nvim' },
    { 'smartpde/telescope-recent-files' },
    { 'rmagatti/session-lens' },

    -- Project
    {
      'ahmedkhalf/project.nvim',
      config = function()
        require('plugin-config.search.project')
      end,
    },



    ----- LSP -----
    ---------------

    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    {
      'jay-babu/mason-null-ls.nvim',
      requires = {
        'jose-elias-alvarez/null-ls.nvim',
        requires = 'nvim-lua/plenary.nvim',
      },
    },
    { 'neovim/nvim-lspconfig' },

    ----- Snippets -----
    --------------------

    { 'hrsh7th/cmp-nvim-lsp' },
    { 'onsails/lspkind-nvim' },
    { 'quangnguyen30192/cmp-nvim-ultisnips' },
    -- Engine
    {
      'hrsh7th/nvim-cmp',
      module = { 'cmp' },
      requires = {
        { 'hrsh7th/cmp-nvim-lsp-signature-help', event = { 'InsertEnter' } },
        { 'hrsh7th/cmp-buffer',                  event = { 'InsertEnter', 'CmdLineEnter *' } },
        { 'hrsh7th/cmp-path',                    event = { 'InsertEnter' } },
        { 'hrsh7th/cmp-cmdline',                 event = { 'CmdLineEnter *' } },
        { 'dmitmel/cmp-cmdline-history',         event = { 'CmdLineEnter *' } },
        { 'hrsh7th/cmp-emoji',                   event = { 'InsertEnter' } },
        { 'SirVer/ultisnips',                    event = { 'InsertEnter' } },
      },
      config = function()
        require('cmp.setup')
      end,
      wants = { 'cmp-nvim-lsp', 'lspkind-nvim', 'cmp-nvim-ultisnips' },
    },

    -- My snippet
    { 'montenoki/vim-snippets' },

    ----- DAP -----
    ---------------
    { 'mfussenegger/nvim-dap' },
    {
      'rcarriga/nvim-dap-ui',
      config = function()
        require('dap.dapui')
      end,
    },
    { 'theHamsta/nvim-dap-virtual-text' },
    { 'jbyuki/one-small-step-for-vimkind' },

    ---------  Language Support -----------
    ---------------------------------------

    -- Python
    { 'mfussenegger/nvim-dap-python' },

    -- Lua
    {
      'folke/neodev.nvim',
      config = function()
        require('neodev').setup({
          library = { plugins = { 'nvim-dap-ui' }, types = true },
        })
      end,
    },

    -- Rust
    { 'simrat39/rust-tools.nvim' },

    -- R
    { 'jalvesaq/Nvim-R' },
  })
end

if packer_bootstrap then
  require('lua.plugins').sync()
end

return setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})
