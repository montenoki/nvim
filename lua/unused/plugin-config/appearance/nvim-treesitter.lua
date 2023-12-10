local treesitter = requirePlugin('nvim-treesitter.configs')
if treesitter == nil then
    return
end
local uConfig = require('uConfig')
local keys = uConfig.keys.treesitter
local lang_support = uConfig.language_support.treesitter

require('nvim-treesitter.install').prefer_git = true

treesitter.setup({
    ensure_installed = lang_support.ensure_installed,
    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    -- Incremental selection
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = keys.init_selection,
            node_incremental = keys.node_incremental,
            node_decremental = keys.node_decremental,
            scope_incremental = keys.scope_incremental,
        },
    },
    -- 自動indent (=)
    indent = {
        enable = true,
    },

    -- nvim-treesitter/nvim-treesitter-refactor
    refactor = {
        highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
        },
        highlight_current_scope = { enable = false },
    },

    -- nvim-treesitter/nvim-treesitter-textobjects
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = { query = '@function.outer', desc = 'Select outer part of a function region' },
                ['if'] = { query = '@function.inner', desc = 'Select inner part of a function region' },
                ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class region' },
                ['ic'] = { query = '@class.inner', desc = 'Select outer part of a class region' },
                ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional region' },
                ['ii'] = { query = '@conditional.inner', desc = 'Select outer part of a conditional region' },
                ['al'] = { query = '@loop.outer', desc = 'Select outer part of a loop region' },
                ['il'] = { query = '@loop.inner', desc = 'Select outer part of a loop region' },
                ['ab'] = { query = '@block.outer', desc = 'Select outer part of a block region' },
                ['ib'] = { query = '@block.inner', desc = 'Select outer part of a block region' },
                ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
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

        swap = {
            enable = true,
            swap_next = { [keys.swap_next] = '@parameter.inner' },
            swap_previous = { [keys.swap_prev] = '@parameter.inner' },
        },
    },
})
