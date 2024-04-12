local Keys = require('keymaps').treesitter

return {
  'nvim-treesitter/nvim-treesitter',
  cond = vim.g.vscode == nil,
  build = ':TSUpdate',
  -- LazyFile
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
  init = function(plugin)
    require('lazy.core.loader').add_to_rtp(plugin)
    require('nvim-treesitter.query_predicates')
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
  keys = Keys.treesitter,
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
      keymaps = Keys.incremental_selection,
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
