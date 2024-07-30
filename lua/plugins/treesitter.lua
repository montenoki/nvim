local keymaps = require('keymaps')
local utils = require('utils')

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  init = function(plugin)
    -- 确保依赖 nvim-treesitter 查询的其他插件能正常工作
    -- 即使它们不直接加载 nvim-treesitter 的主模块。
    require('lazy.core.loader').add_to_rtp(plugin)
    require('nvim-treesitter.query_predicates')
  end,
  opts_extend = { 'ensure_installed' },
  dependencies = {},
  cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
  keys = {
    { keymaps.incrementalSelection.init, 'viw<C-7>', desc = 'Init Increment selection', remap = true },
  },

  opts = {
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = keymaps.incrementalSelection.initSelection,
        node_incremental = keymaps.incrementalSelection.nodeIncremental,
        scope_incremental = keymaps.incrementalSelection.scopeIncremental,
        node_decremental = keymaps.incrementalSelection.nodeDecremental,
      },
    },
  },
  config = function(_, opts)
    if type(opts.ensure_installed) == 'table' then
      opts.ensure_installed = utils.removeDuplicates(opts.ensure_installed)
    end
    require('nvim-treesitter.configs').setup(opts)
    -- 隐藏临时映射，并修改映射的描述
    require('which-key').add({
      { keymaps.incrementalSelection.initSelection, hidden = true },
      { keymaps.incrementalSelection.nodeIncremental, desc = 'Increment Selection', mode = 'x' },
      { keymaps.incrementalSelection.scopeIncremental, desc = 'Scope Incremental', mode = 'x' },
      { keymaps.incrementalSelection.nodeDecremental, desc = 'Decrement Selection', mode = 'x' },
    })
  end,
}
