local M = {
    config_path = vim.fn.stdpath('config'),
    enable = {
        lite_mode = false,
        magic_search = true,
        code_ruler = true,
        listchars = true,
        relativenumber = false,
        mouse = true,

        auto_session = true,
        nvim_tree = true,
        lualine = true,
        bufferline = true,
        symbols_outline = true,
        fidget = true,
        notify = true,
        -- NOTE Need lazygit
        toggleterm = true,
        which_key = true,
        todo_comments = true,
        indent_blankline = true,
        ufo = true,
        nvim_navic = true,
        treesitter_context = true,
        colorizer = true,
        gitsigns = true,

    },
    setting = {
        tab_width = 4,
        timeoutlen = 300,
        updatetime = 50,
    },
    language_support = {
        treesitter_ensure = { 'vim', 'lua', 'python', 'query' },
    },
    keys = {
        leader_key = ' ',

        n_v_scroll_up_with_cursor = '<C-k>',
        n_v_scroll_down_with_cursor = '<C-j>',
        n_v_scroll_up_without_cursor = 'K',
        n_v_scroll_down_without_cursor = 'J',

        s_windows = {
            enable = true,

            -- 窗口开关
            split_vertically = 'sv',
            split_horizontally = 'sh',
            close = 'sc',
            close_others = 'so',

            -- 窗口跳转
            jump_left = '<A-h>',
            jump_right = '<A-l>',
            jump_up = '<A-k>',
            jump_down = '<A-j>',

            -- 窗口比例控制
            width_decrease = 's-',
            width_increase = 's=',
            height_decrease = 's_',
            height_increase = 's+',
            size_equal = 'ss',
        },

        new_tab = '<A-b>',

        symbols_outline = {
            toggle = '<A-o>',
            close = { '<ESC>', 'q' },
            goto_location = '<CR>',
            focus_location = '<TAB>',
            hover_symbol = 'h',
            rename_symbol = '<leader>rn',
            code_actions = '<leader>ca',
            fold = 'zc',
            unfold = 'zo',
            fold_all = 'zM',
            unfold_all = 'zR',
            fold_reset = 'R',
        },

        toggleterm = {
            term_quit = '<Esc>',
            lazygit_toggle = '<A-g>',
            float_toggle = '<A-t>',
            botton_toggle = '<A-\\>',
        },

        cmp = {
            complete = '<A-.>',
            abort = '<A-,>',
            confirm = '<CR>',
            scroll_doc_up = '<C-k>',
            scroll_doc_down = '<C-j>',
            select_prev_item = '<S-tab>',
            select_next_item = '<Tab>',
        },

        treesitter = {
            init_selection = '<C-1>',
            node_incremental = '<CR>',
            scope_incremental = '<TAB>',
            node_decremental = '<BS>',
            swap_next = '<leader>l',
            swap_prev = '<leader>h',
        },

        ufo = {
            openAllFolds = 'zR',
            closeAllFolds = 'zM',
            openFoldsExceptKinds = 'zr',
            closeFoldWith = 'zm',
            -- TODO: wait coc
            -- peekFoldedLinesUnderCursor = 'zh',
        },

        lsp = {
            declaration = 'gD',
            references = 'gr',
            definition = 'gd',
            hover = 'gh',

            code_action = '<leader>ca',
            format = '<leader>f',
            rename = '<leader>rn',
            type_definition = '<leader>d',

            add_workspace_folder = '<leader>wa',
            remove_workspace_folder = '<leader>wr',
            list_workspace_folders = '<leader>wl',
        },

        dap = {
            toggle = '<A-d>',

            run = '<S-F5>',
            breakpoint_toggle = '<F8>',
            breakpoint_clear = '<S-F8>',

            step_into = '<F11>',
            step_out = '<S-F11>',
            restart = '<F6>',
            stop = '<F12>',

            open_info = '<F2>',
        },
        nvimTree = {
            toggle = '<A-m>',

            -- Open file
            edit = { '<CR>', '<2-LeftMouse>' },
            system_open = 'o',
            preview = '<Tab>',
            tabnew = 't',
            -- Open file at split window
            vsplit = 'v',
            split = 'h',

            -- ignore ファイル表示・非表示
            toggle_git_ignored = 'i',
            -- dot ファイル表示・非表示
            toggle_dotfiles = '.',
            toggle_custom = 'u',
            toggle_file_info = 'I',
            toggle_help = '?',

            refresh = 'R',

            file_filter = 'f',
            clear_filter = 'F',

            -- 进入下一级
            cd = ']',
            -- 进入上一级
            dir_up = '[',

            -- 文件操作
            create = 'a',
            remove = 'd',
            rename = 'r',
            cut = 'x',
            copy = 'c',
            paste = 'p',
            copy_name = 'y',
            copy_path = 'Y',
            copy_absolute_path = 'gy',
        },
        bufferLine = {
            enable = true,

            prev = '<C-H>',
            next = '<C-L>',
            pick = '<A-i>',
            pick_close = '<A-I>',
        },

        telescope = {
            find_files = '<C-p>',
            live_grep = '<C-f>',
            command_palette = '<A-p>',

            -- 上下移动
            move_selection_next = '<tab>',
            move_selection_previous = '<S-tab>',
            -- 历史记录
            cycle_history_next = '<C-n>',
            cycle_history_prev = '<C-p>',
            -- 关闭窗口
            close = '<esc>',
            -- 预览窗口上下滚动
            preview_scrolling_up = '<C-k>',
            preview_scrolling_down = '<C-j>',

            open = '<CR>',
            open_horizontal = '<C-h>',
            open_vertical = '<S-SPACE>',
        },

        trouble = {
            toggle = '<A-P>',
        },

        which_key = {
            toggle = '<A-/>',
        },
        hop = {
            toggle = '\\',
        },
        zen = {
            toggle = '<A-z>',
        },

        gitsigns = {
            diffthis = '<A-G>',
        },

        -- s_tab = {
        --     split = 'ts',
        --     prev = 'th',
        --     next = 'tl',
        --     first = 'tj',
        --     last = 'tk',
        --     close = 'tc',
        -- },

        terminal_to_normal = '<Esc>',
        -- TODO:

        -- proxy
        -- im-select
    },
    mkdnflow = {
        enable = true,
        next_link = 'gn',
        prev_link = 'gp',
        next_heading = 'gj',
        prev_heading = 'gk',
        go_back = '<C-o>',
        follow_link = 'gd',
        toggle_item = 'tt',
    },
    comment = {
        enable = true,
        -- Normal 模式快捷键
        toggler = {
            line = 'gcc', -- 行注释
            block = 'gbc', -- 块注释
        },
        -- Visual 模式
        opleader = {
            line = 'gc',
            bock = 'gb',
        },
    },
    venn = {
        -- toggle keymappings for venn using <leader>v
        enable = true,
        -- venn.nvim: enable or disable keymappings
        toggle = '<leader>v',
        -- draw a box by pressing "f" with visual selection
        draw_box = 'f',
    },
}

return M
