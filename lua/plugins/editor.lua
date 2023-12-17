local Util = require('util')
local Icon = require('icons')
return {
  -- file explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    cmd = 'Neotree',
    keys = {
      {
        '<leader>e',
        function()
          require('neo-tree.command').execute({ toggle = true, dir = Util.root() })
        end,
        desc = 'Explorer NeoTree (root dir)',
      },
      {
        '<leader>ge',
        function()
          require('neo-tree.command').execute({ source = 'git_status', toggle = true })
        end,
        desc = 'Git explorer',
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == 'directory' then
          require('neo-tree')
        end
      end
    end,
    opts = {
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ['<space>'] = 'toggle_node',
          ['<tab>'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } }, --TODO[2023/12/17] config this later: image_nvim?
          ['v'] = 'open_vsplit',
          ['h'] = 'open_split',
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          indent_marker = Icon.neotree.indent_marker,
          last_indent_marker = Icon.neotree.last_indent_marker,
          expander_collapsed = Icon.neotree.expander_collapsed,
          expander_expanded = Icon.neotree.expander_expanded,
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          folder_closed = Icon.neotree.folder_closed,
          folder_open = Icon.neotree.folder_open,
          folder_empty = Icon.neotree.folder_empty,
        },
        git_status = {
          symbols = Icon.git,
        },
      },
    },
    config = function(_, opts)
      local function on_move(data)
        Util.lsp.on_rename(data.source, data.destination)
      end

      local events = require('neo-tree.events')
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED,   handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require('neo-tree').setup(opts)
      vim.api.nvim_create_autocmd('TermClose', {
        pattern = '*lazygit',
        callback = function()
          if package.loaded['neo-tree.sources.git_status'] then
            require('neo-tree.sources.git_status').refresh()
          end
        end,
      })
    end,
  },

  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      'nvim-lua/plenary.nvim',
      'LinArcX/telescope-env.nvim',
      'LinArcX/telescope-command-palette.nvim',
      'smartpde/telescope-recent-files',
      'rmagatti/session-lens',
      "nvim-telescope/telescope-project.nvim",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        enabled = vim.fn.executable('make') == 1,
        config = function()
          local telescope = require('telescope')
          Util.on_load('telescope.nvim', function()
            telescope.load_extension('session-lens')
            telescope.load_extension('project')
            telescope.load_extension('fzf')
            telescope.load_extension('env')
            telescope.load_extension('command_palette')
            telescope.load_extension('recent_files')
          end)
        end,
      },
    },
    keys = {
      -- {
      --   '<leader>,',
      --   '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>',
      --   desc = 'Switch Buffer',
      -- },
      {
        '<leader>/',
        Util.telescope('live_grep'),
        desc = 'Grep (root dir)',
      },
      {
        '<leader>?',
        Util.telescope('files'),
        desc = 'Find Files (root dir)',
      },
      {
        '<leader>:',
        '<cmd>Telescope commands<cr>',
        desc = 'Commands',
      },
      {
        '<leader>;',
        '<cmd>Telescope command_history<cr>',
        desc = "Command History",
      },
      -- git
      { '<leader>sc', '<cmd>Telescope git_commits<CR>', desc = 'commits' },
      { '<leader>ss', '<cmd>Telescope git_status<CR>',  desc = 'status' },
      -- search
      { '<leader>s"', '<cmd>Telescope registers<cr>',   desc = 'Registers' },
      {
        '<leader>sa',
        '<cmd>Telescope autocommands<cr>',
        desc = 'Auto Commands',
      },
      {
        '<leader>sd',
        '<cmd>Telescope diagnostics bufnr=0<cr>',
        desc = 'Document diagnostics',
      },
      {
        '<leader>sD',
        '<cmd>Telescope diagnostics<cr>',
        desc = 'Workspace diagnostics',
      },
      {
        '<leader>sh',
        '<cmd>Telescope highlights<cr>',
        desc = 'Search Highlight Groups',
      },
      { '<leader>sk', '<cmd>Telescope keymaps<cr>',     desc = 'Key Maps' },
      { '<leader>sm', '<cmd>Telescope marks<cr>',       desc = 'Jump to Mark' },
      { '<leader>so', '<cmd>Telescope vim_options<cr>', desc = 'Options' },
      {
        '<leader>uC',
        Util.telescope('colorscheme', { enable_preview = true }),
        desc = 'Colorscheme with preview',
      },
    },
    opts = function()
      local actions = require('telescope.actions')

      local open_with_trouble = function(...)
        return require('trouble.providers.telescope').open_with_trouble(...)
      end
      local open_selected_with_trouble = function(...)
        return require('trouble.providers.telescope').open_selected_with_trouble(...)
      end
      local find_files_no_ignore = function()
        local action_state = require('telescope.actions.state')
        local line = action_state.get_current_line()
        Util.telescope('find_files', { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require('telescope.actions.state')
        local line = action_state.get_current_line()
        Util.telescope('find_files', { hidden = true, default_text = line })()
      end

      return {
        defaults = {
          prompt_prefix = Icon.telescope.prompt_prefix,
          selection_caret = Icon.telescope.selection_caret,
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == '' then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              -- TODO[2023/12/17]: config this after trouble is fixed.
              -- ['<c-t>'] = open_with_trouble,
              -- ['<a-t>'] = open_selected_with_trouble,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<S-tab>'] = actions.cycle_history_next,
              ['<tab>'] = actions.cycle_history_prev,
              ['<C-v>'] = actions.select_vertical,
              ['<C-h>'] = actions.select_horizontal,
              ['<A-h>'] = actions.preview_scrolling_left,
              ['<A-l>'] = actions.preview_scrolling_right,
              ['<A-j>'] = actions.preview_scrolling_down,
              ['<A-k>'] = actions.preview_scrolling_up,
            },
            n = {
              ['q'] = actions.close,
            },
          },
        },
      }
    end,
  },
  -- move cursor between windows
  {
    'ggandor/leap.nvim',
    enabled = true,
    lazy = false,
    keys = {
      { '\\', mode = { 'n', 'x', 'o' }, desc = 'Leap from windows' },
    },
    config = function(_, opts)
      local leap = require('leap')
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      vim.keymap.set({ 'n', 'v' }, '\\', function()
        leap.leap({
          target_windows = vim.tbl_filter(function(win)
            return vim.api.nvim_win_get_config(win).focusable
          end, vim.api.nvim_tabpage_list_wins(0)),
        })
      end)
    end,
  },

  -- move windows
  {
    'sindrets/winshift.nvim',
    lazy = true,
    keys = {
      { '<leader>wm', '<cmd>WinShift<cr>', desc = 'Move window' },
    },
  },
  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit.
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    opts = {
      signs = Icon.gitsigns,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>hD", gs.diffthis, "Diff This")
        map("n", "<leader>hd", function() gs.diffthis("~") end, "Diff This ~")
      end,
    },
  },

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      { "<leader>k", '<cmd>WhichKey<cr>' },
    },
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { 'n', 'v' },
        ['g'] = { name = '+goto' },
        ['gs'] = { name = '+surround' },
        [']'] = { name = '+next' },
        ['['] = { name = '+prev' },
        ['<leader><tab>'] = { name = '+tabs' },
        ['<leader>b'] = { name = '+buffer' },
        ['<leader>c'] = { name = '+code' },
        ['<leader>f'] = { name = '+file/find' },
        ['<leader>g'] = { name = '+git' },
        ['<leader>gh'] = { name = '+hunks' },
        ['<leader>q'] = { name = '+quit/session' },
        ['<leader>s'] = { name = '+search' },
        ['<leader>u'] = { name = '+ui' },
        ['<leader>w'] = { name = '+windows' },
        ['<leader>x'] = { name = '+diagnostics/quickfix' },
      },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
  -- Automatically highlights other instances of the word under your cursor.
  -- This works with LSP, Treesitter, and regexp matching to find the other
  -- instances.
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { 'lsp' },
      },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set('n', key, function()
          require('illuminate')['goto_' .. dir .. '_reference'](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference', buffer = buffer })
      end

      map(']]', 'next')
      map('[[', 'prev')

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map(']]', 'next', buffer)
          map('[[', 'prev', buffer)
        end,
      })
    end,
    keys = {
      { ']]', desc = 'Next Reference' },
      { '[[', desc = 'Prev Reference' },
    },
  },
  -- buffer remove
  {
    'echasnovski/mini.bufremove',

    keys = {},
  },

  -- better diagnostics list and others
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = { use_diagnostic_signs = true },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>',  desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics (Trouble)' },
      { '<leader>xl', '<cmd>TroubleToggle loclist<cr>',               desc = 'Location List (Trouble)' },
      { '<leader>xq', '<cmd>TroubleToggle quickfix<cr>',              desc = 'Quickfix List (Trouble)' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Previous trouble/quickfix item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Next trouble/quickfix item',
      },
    },
  },
  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    config = true,
    opts = {
      keywords = {
        TODO = { icon = Icon.todo_comments.TODO, color = 'info' },
        NOTE = { icon = Icon.todo_comments.NOTE, color = 'hint', alt = { 'INFO', 'NOTE' } },
        WARN = { icon = Icon.todo_comments.WARN, color = 'warning', alt = { 'WARNING', 'XXX' } },
        FIX = { icon = Icon.todo_comments.FIX, color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } },
      },
      highlight = {
        pattern = [[.*<(KEYWORDS)]],
      },
      search = {
        command = 'rg',
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
    },
  },

  -- project
  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = true,
      detection_methods = { 'lsp', 'pattern' },
      patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '.sln', '.vim' },
      silent_chdir = true,
    },
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      Util.on_load("telescope.nvim", function()
        require("telescope").load_extension("projects")
      end)
    end,
    keys = {
      { "<leader>sp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
  },

  -- Session manager
  -- TODO[2023/12/17]: fix
  -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/400
  {
    'rmagatti/auto-session',
    opts = {
      log_level = vim.log.levels.ERROR,
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      auto_session_use_git_branch = false,

      auto_session_enable_last_session = false,

      -- ⚠️ This will only work if Telescope.nvim is installed
      -- The following are already the default values, no need to provide them if these are already the settings you want.
      session_lens = {
        -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
        buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },

      cwd_change_handling = {
        restore_upcoming_session = true,
        pre_cwd_changed_hook = nil,
        post_cwd_changed_hook = function()
          require('lualine').refresh()
        end,
      },
    },
  },

}
