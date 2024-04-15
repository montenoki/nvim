local Keys = require('keymaps').treesitter.incremental_selection

return {
  -- nvim-treesitter
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  -- LazyFile
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
  init = function(plugin)
    require('lazy.core.loader').add_to_rtp(plugin)
    require('nvim-treesitter.query_predicates')
  end,
  dependencies = {
 {
  'nvim-treesitter/nvim-treesitter-textobjects',
  cond = vim.g.vscode == nil,
  config = function()
    -- When in diff mode, we want to use the default
    -- vim text objects c & C instead of the treesitter ones.
    local move = require('nvim-treesitter.textobjects.move')
    local configs = require('nvim-treesitter.configs')
    for name, fn in pairs(move) do
      if name:find('goto') == 1 then
        move[name] = function(q, ...)
          if vim.wo.diff then
            local config = configs.get_module('textobjects.move')[name]
            for key, query in pairs(config or {}) do
              if q == query and key:find('[%]%[][cC]') then
                vim.cmd('normal! ' .. key)
                return
              end
            end
          end
          return fn(q, ...)
        end
      end
    end
  end,
},
  },
  cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
  keys = {
    { Keys.node_incremental, desc = 'Increment selection', mode = 'x' },
    { Keys.node_decremental, desc = 'Decrement selection', mode = 'x' },
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
      -- stylua: ignore
      ensure_installed = {
        'arduino', 'bash', 'c', 'c_sharp', 'cmake', 'comment', 'cpp',
        'css', 'csv', 'cuda', 'diff', 'dockerfile', 'dot', 'fish', 'git_config',
        'git_rebase', 'gitattributes', 'gitcommit', 'gitignore', 'go', 'html',
        'htmldjango', 'http', 'hurl', 'ini', 'java', 'javascript', 'jsdoc',
        'json', 'jsonc', 'json5',  'jsonnet', 'julia', 'kconfig',
        'latex', 'lua', 'luadoc', 'lua', 'luau', 'make', 'markdown',
        'markdown_inline', 'matlab', 'mermaid', 'ninja', 'objc', 'pascal',
        'passwd', 'pem', 'perl', 'php', 'phpdoc', 'psv', 'purescript', 'python',
        'r', 'regex', 'ruby', 'rust', 'scala', 'scheme', 'sql', 'ssh_config',
        'swift', 'systemtap', 'todotxt', 'toml', 'tsv', 'tsx', 'typescript',
        'vim', 'vimdoc', 'vue', 'xml', 'yaml',
      },
    incremental_selection = {
      enable = true,
      keymaps = Keys,
    },
  },
  config = function(_, opts)
    if type(opts.ensure_installed) == 'table' then
      ---@type table<string, boolean>
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(lang)
        if added[lang] then
          return false
        end
        added[lang] = true
        return true
      end, opts.ensure_installed)
    end
    require('nvim-treesitter.configs').setup(opts)
  end,
}
