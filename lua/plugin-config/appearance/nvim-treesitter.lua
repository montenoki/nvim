local treesitter = requirePlugin('nvim-treesitter.configs')
if treesitter == nil then
    return
end
local uConfig = require('uConfig')
local lite_mode = uConfig.lite_mode
local langs = uConfig.nvimtreesitter.languages
local keys = uConfig.nvimtreesitter.keys

require('nvim-treesitter.install').prefer_git = true

treesitter.setup({
    ensure_installed = langs,
    sync_install =false,

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
                ['af'] = { query = '@function.outer', desc = "Select outer part of a function region" },
                ['if'] = { query = '@function.inner', desc = "Select inner part of a function region" },
                ['ac'] = { query = '@class.outer', desc = "Select outer part of a class region" },
                ['ic'] = { query = '@class.inner', desc = "Select outer part of a class region" },
                ['ai'] = { query = '@conditional.outer', desc = "Select outer part of a conditional region" },
                ['ii'] = { query = '@conditional.inner', desc = "Select outer part of a conditional region" },
                ['al'] = { query = '@loop.outer', desc = "Select outer part of a loop region" },
                ['il'] = { query = '@loop.inner', desc = "Select outer part of a loop region" },
                ['ab'] = { query = '@block.outer', desc = "Select outer part of a block region" },
                ['ib'] = { query = '@block.inner', desc = "Select outer part of a block region" },
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
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
            enable = false,
            swap_next = {
                [keys.swap_next] = '@parameter.inner',
            },
            swap_previous = {
                [keys.swap_prev] = '@parameter.inner',
            },
        },

        move = {
            -- TODO: ?
            enable = false,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = { query = "@class.outer", desc = "Next class start" },
                --
                -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                ["]o"] = "@loop.*",
                -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                --
                -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            goto_next = {
                ["]d"] = "@conditional.outer",
            },
            goto_previous = {
                ["[d"] = "@conditional.outer",
            }
        },
        lsp_interop = {
            -- TODO: ?
            enable = false,
            border = 'none',
            floating_preview_opts = {},
            peek_definition_code = {
                ["<leader>df"] = "@function.outer",
                ["<leader>dF"] = "@class.outer",
            },
        },
    },
})

----- Repeat Move -----
-----------------------

-- TODO: ?
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)


-- --  Folding 機能ON
-- local vim = vim
-- local opt = vim.opt
--
-- opt.foldmethod = 'expr'
-- opt.foldexpr = 'nvim_treesitter#foldexpr()'
