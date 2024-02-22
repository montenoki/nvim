return {
  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    'nvim-treesitter/nvim-treesitter',
    version = false, -- last release is way too old and doesn't work on Windows
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
      { '<CR>', desc = 'Increment selection', mode = 'x' },
      { '<BS>', desc = 'Decrement selection', mode = 'x' },
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
        'json', 'jsonc', 'json5', 'JSON', 'jsonnet', 'julia', 'kconfig',
        'latex', 'lua', 'luadoc', 'lua', 'luau', 'make', 'markdown',
        'markdown_inline', 'matlab', 'mermaid', 'ninja', 'objc', 'pascal',
        'passwd', 'pem', 'perl', 'php', 'phpdoc', 'psv', 'purescript', 'python',
        'r', 'regex', 'ruby', 'rust', 'scala', 'scheme', 'sql', 'ssh_config',
        'swift', 'systemtap', 'todotxt', 'toml', 'tsv', 'tsx', 'typescript',
        'vim', 'vimdoc', 'vue', 'xml', 'yaml',
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          -- a least frequently used key for call it later.
          init_selection = '<C-1>',
          node_incremental = '<CR>',
          node_decremental = '<BS>',
          scope_incremental = '<TAB>',
        },
      },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = {
              query = '@function.outer',
              desc = 'Select outer part of a function region',
            },
            ['if'] = {
              query = '@function.inner',
              desc = 'Select inner part of a function region',
            },
            ['ac'] = {
              query = '@class.outer',
              desc = 'Select outer part of a class region',
            },
            ['ic'] = {
              query = '@class.inner',
              desc = 'Select outer part of a class region',
            },
            ['ai'] = {
              query = '@conditional.outer',
              desc = 'Select outer part of a conditional region',
            },
            ['ii'] = {
              query = '@conditional.inner',
              desc = 'Select outer part of a conditional region',
            },
            ['al'] = {
              query = '@loop.outer',
              desc = 'Select outer part of a loop region',
            },
            ['il'] = {
              query = '@loop.inner',
              desc = 'Select outer part of a loop region',
            },
            ['ab'] = {
              query = '@block.outer',
              desc = 'Select outer part of a block region',
            },
            ['ib'] = {
              query = '@block.inner',
              desc = 'Select outer part of a block region',
            },
            ['as'] = {
              query = '@scope',
              query_group = 'locals',
              desc = 'Select language scope',
            },
          },

          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          include_surrounding_whitespace = true,
        },
        move = {
          enable = true,
          goto_next_start = {
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']C'] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[C'] = '@class.outer',
          },
        },
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
  },

  -- Show context of the current function
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    enabled = true,
    opts = { mode = 'cursor', max_lines = 4 },
    keys = {
      {
        '<leader>ut',
        function()
          local Util = require('util')
          local tsc = require('treesitter-context')
          tsc.toggle()
          if Util.inject.get_upvalue(tsc.toggle, 'enabled') then
            Util.info('Enabled Treesitter Context', { title = 'Option' })
          else
            Util.warn('Disabled Treesitter Context', { title = 'Option' })
          end
        end,
        desc = 'Toggle Treesitter Context',
      },
    },
  },

  -- Bracket pair colorizer
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    enabled = true,
    config = function()
      require('rainbow-delimiters.setup').setup({})
    end,
  },

  -- Logfile highlighter
  {
    'fei6409/log-highlight.nvim',
    config = function()
      require('log-highlight').setup({})
    end,
  },
}
