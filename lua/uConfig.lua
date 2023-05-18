local M = {
    lite_mode = true,

    config_path = vim.fn.stdpath('config'), 
    
    enable_magic_search = true,

    enable_impatient = false,



    keys = {

        leader_key = ' ',

        -- : 模式
        c_next_item = '<C-j>',
        c_prev_item = '<C-k>',

        -- normal 模式
        n_save = '<leader>w', -- :w
        n_save_quit = '<leader>wq', --:wq
        n_save_all = '<leader>wa', -- :wa
        -- n_save_all_quit = "<leader>qa", -- :wqa
        n_force_quit = '<leader>q', -- :qa!

        n_v_scroll_down_small = '<C-j>',
        n_v_scroll_up_small = '<C-k>',

        n_v_scroll_down_large = '<C-d>',
        n_v_scroll_up_large = '<C-u>',

        -- cmp 快捷键
        cmp_complete = '<A-.>',
        cmp_abort = '<A-,>',
        cmp_confirm = '<CR>',
        cmp_scroll_doc_up = '<C-u>',
        cmp_scroll_doc_down = '<C-d>',
        cmp_select_prev_item = '<S-tab>',
        cmp_select_next_item = '<Tab>',

        -- luasnip
        snip_jump_next = '<C-l>',
        snip_jump_prev = '<C-h>',
        snip_next_choice = '<C-j>',
        snip_prev_choice = '<C-k>',

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

            -- <leader> + hjkl 窗口之间跳转
            -- jump_left = "<leader>h",
            -- jump_right = "<leader>j",
            -- jump_up = "<leader>k",
            -- jump_down = "<leader>l",

            -- 窗口比例控制
            width_decrease = 's,',
            width_increase = 's.',
            height_decrease = 'sj',
            height_increase = 'sk',
            size_equal = 's=',
        },

        s_tab = {
            split = 'ts',
            prev = 'th',
            next = 'tl',
            first = 'tj',
            last = 'tk',
            close = 'tc',
        },

        fold = {
            open = 'Z',
            close = 'zz',
        },

        format = '<leader>f',

        terminal_to_normal = '<Esc>',
        -- TODO

        -- proxy
        -- im-select
    },

    nvimtreesitter = {
        -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
        languages = { 'vim', 'lua', 'python', 'query' },

        keys ={
            init_selection = '<CR>',
            node_incremental = '<CR>',
            scope_incremental = '<TAB>',
            node_decremental = '<BS>',
            swap_next = '<leader>a',
            swap_prev = '<leader>A',
        },
    },

    nvimTree = {

        enable = true,
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
        clear_filter = 'f',

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

        prev = '<C-h>',
        next = '<C-l>',
        close = '<leader>bc',
        close_others = '<leader>bo',
        close_pick = '<leader>bp',
    },

    trouble = {
        enable = true,

        toggle = '<leader>xx',
        workspace = '<leader>xw',
        document = '<leader>xd',
        loclist = '<leader>xl',
        quickfix = '<leader>xq',
        references = 'gR',
    },

    telescope = {

        enable = true,

        find_files = '<C-p>',
        live_grep = '<C-f>',

        -- 上下移动
        move_selection_next = '<tab>',
        move_selection_previous = '<S-tab>',
        -- 历史记录
        cycle_history_next = '<C-n>',
        cycle_history_prev = '<C-p>',
        -- 关闭窗口
        close = '<esc>',
        -- 预览窗口上下滚动
        preview_scrolling_up = '<C-u>',
        preview_scrolling_down = '<C-d>',
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

    ufo = {
        enable = true,
        openAllFolds = 'zR',
        closeAllFolds = 'zM',
        openFoldsExceptKinds = 'zr',
        closeFoldWith = 'zm',
        peekFoldedLinesUnderCursor = 'zh',
    },
    toggleterm = {
        enable = true,

        -- <leader>ta 浮动命令行窗口
        lazygit_toggle = '<leader>tg',
        -- <leader>tb 右侧命令行窗口
        float_toggle = '<leader>tt',
        -- <leader>tc 下方命令行窗口
        botton_toggle = '<A-\\>',
    },

    venn = {
        -- toggle keymappings for venn using <leader>v
        enable = true,
        -- venn.nvim: enable or disable keymappings
        toggle = '<leader>v',
        -- draw a box by pressing "f" with visual selection
        draw_box = 'f',
    },

    zen = {
        enable = true,
        toggle = '<leader>z',
    },

    lsp = {
        declaration = 'gD',
        references = 'gr',
        definition = 'gd',
        hover = 'gh',

        implementation = 'gi',
        signature_help = 'gI',
        
        code_action = '<leader>ca',
        format = '<leader>f',
        rename = '<leader>rn',
        type_definition = '<leader>D',

        -- diagnostic
        open_float = 'gP',
        goto_next = 'gJ', -- ]d
        goto_prev = 'gK', -- [d 
        setloclist = 'gp',

        add_workspace_folder = '<leader>wa',
        remove_workspace_folder = '<leader>wr',
        list_workspace_folders = '<leader>wl',
    },
    dap = {
        toggle = '<leader>dd',

        run = '<S-F5>',
        breakpoint_toggle = '<F8>',
        breakpoint_clear = '<S-F8>',

        continue = '<F5>',
        step_over = '<F10>',
        step_into = '<F11>',
        step_out = '<S-F11>',
        restart = '<F6>',
        stop = '<F12>',

        open_info = '<F2>',
    },
}

return M
