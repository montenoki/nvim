local treesitter = requirePlugin('nvim-treesitter.configs')
if treesitter == nil then
    return
end
local uConfig = require('uConfig')
local treesitter_langs = uConfig.treesitter_langs
local lite_mode = uConfig.lite_mode

require('nvim-treesitter.install').prefer_git = true

treesitter.setup({
    ensure_installed = treesitter_langs,
    -- 構文の強調表示ON
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    -- 漸進式選択
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            node_decremental = '<BS>',
            scope_incremental = '<TAB>',
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
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['ai'] = '@conditional.outer',
                ['ii'] = '@conditional.inner',
                ['al'] = '@loop.outer',
                ['il'] = '@loop.inner',
                ['ab'] = '@block.outer',
                ['ib'] = '@block.inner',
            },
        },
        swap = {
            enable = false,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
    },
})

-- --  Folding 機能ON
-- local vim = vim
-- local opt = vim.opt
--
-- opt.foldmethod = 'expr'
-- opt.foldexpr = 'nvim_treesitter#foldexpr()'
