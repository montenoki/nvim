local Util = require('util')
local keybinds = require('keymaps')
local Icon = require('icons')
return {
  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      {
        'JMarkin/nvim-tree.lua-float-preview',
        lazy = true,
        -- default
        opts = {
          -- wrap nvimtree commands
          wrap_nvimtree_commands = true,
          -- lines for scroll
          scroll_lines = 20,
          -- window config
          window = {
            style = 'minimal',
            relative = 'win',
            border = 'rounded',
            wrap = false,
          },
          mapping = {
            -- scroll down float buffer
            down = { keybinds.scroll_down },
            -- scroll up float buffer
            up = { keybinds.scroll_up },
            -- enable/disable float windows
            toggle = { '<TAB>' },
          },
          -- hooks if return false preview doesn't shown
          hooks = {
            pre_open = function(path)
              -- if file > 5 MB or not text -> not preview
              local size = require('float-preview.utils').get_size(path)
              if type(size) ~= 'number' then
                return false
              end
              local is_text = require('float-preview.utils').is_text(path)
              return size < 5 and is_text
            end,
            post_open = function(_)
              return true
            end,
          },
        },
      },
    },
    keys = {
      { '<LEADER>e', '<CMD>NvimTreeFindFileToggle<CR>', desc = 'Explorer Find File' },
    },
    config = function()
      require('nvim-tree').setup({
        disable_netrw = true,
        -- project plugin
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = false,
          update_root = false,
          ignore_list = {},
        },

        view = { width = 40 },
        renderer = {
          indent_markers = {
            icons = {
              corner = Icon.neotree.last_indent_marker,
              edge = Icon.neotree.indent_marker,
              item = Icon.neotree.indent_marker,
              bottom = Icon.neotree.last_indent_marker,
            },
          },
          icons = {
            web_devicons = { folder = { enable = true } },
            symlink_arrow = Icon.neotree.symlink_arrow,
            git_placement = 'after',
            glyphs = {
              default = Icon.neotree.file,
              symlink = Icon.neotree.symlink_file,
              bookmark = Icon.neotree.bookmark,
              modified = Icon.bufferline.modified_icon,
              folder = {
                arrow_closed = Icon.neotree.expander_collapsed,
                arrow_open = Icon.neotree.expander_expanded,
                default = Icon.neotree.folder_closed,
                open = Icon.neotree.folder_open,
                empty = Icon.neotree.folder_empty,
                empty_open = Icon.neotree.folder_empty,
                symlink = Icon.neotree.symlink,
                symlink_open = Icon.neotree.symlink,
              },
              git = {
                unstaged = Icon.git.unstaged,
                staged = Icon.git.staged,
                unmerged = Icon.git.unmerged,
                renamed = Icon.git.renamed,
                untracked = Icon.git.untracked,
                deleted = Icon.git.deleted,
                ignored = Icon.git.ignored,
              },
            },
          },
        },
        system_open = {
          -- TODO[2023/12/19]: mac/win support
          cmd = 'open',
          args = {},
        },
        diagnostics = {
          enable = true,
          icons = {
            hint = Icon.diagnostics.Hint,
            info = Icon.diagnostics.Info,
            warning = Icon.diagnostics.Warn,
            error = Icon.diagnostics.Error,
          },
        },
        modified = { enable = true },
        actions = {
          open_file = {
            quit_on_open = true,
            resize_window = true,
            window_picker = {
              chars = "FJDKSLA;"
            },
          }
        },
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')
          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          local FloatPreview = require('float-preview')
          FloatPreview.attach_nvimtree(bufnr)
          -- custom mappings
          vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Edit'))
          vim.keymap.set('n', 'o', api.node.run.system, opts('System Open'))
          -- vim.keymap.set('n', '<tab>', api.node.open.preview, opts('Preview'))
          vim.keymap.set('n', 't', api.node.open.tab, opts('Open in New Tab'))
          vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open in VSplit'))
          vim.keymap.set('n', 'h', api.node.open.horizontal, opts('Open in Split'))
          --
          vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignored'))
          vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
          vim.keymap.set('n', 'u', api.tree.toggle_custom_filter, opts('Toggle Custom files'))
          vim.keymap.set('n', 'i', api.node.show_info_popup, opts('Toggle File Info'))
          vim.keymap.set('n', '?', api.tree.toggle_help, opts('Toggle Help'))

          vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
          --
          vim.keymap.set('n', 'f', api.live_filter.start, opts('Live Filter'))
          vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clear Live Filter'))
          vim.keymap.set('n', ']', api.tree.change_root_to_node, opts('cd'))
          vim.keymap.set('n', '[', api.node.navigate.parent, opts('Dir Up'))

          vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
          vim.keymap.set('n', 'd', api.fs.remove, opts('Remove'))
          vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
          vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
          vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
          vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
          vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
          vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Path'))
          vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Abs Path'))
        end,
      })
    end,
  },

  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
  -- TODO[2023/12/20]: Config this later
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
      'nvim-telescope/telescope-project.nvim',
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
      {
        '<LEADER>,',
        '<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>',
        desc = 'Switch Buffer',
      },
      {
        '<LEADER>/',
        Util.telescope('live_grep'),
        desc = 'Grep (root dir)',
      },
      {
        '<LEADER>?',
        Util.telescope('files'),
        desc = 'Find Files (root dir)',
      },
      {
        '<LEADER>:',
        '<CMD>Telescope commands<CR>',
        desc = 'Commands',
      },
      {
        '<LEADER>;',
        '<CMD>Telescope command_history<CR>',
        desc = 'Command History',
      },
      -- git
      { '<LEADER>sc', '<CMD>Telescope git_commits<CR>', desc = 'commits' },
      { '<LEADER>ss', '<CMD>Telescope git_status<CR>',  desc = 'status' },
      -- search
      { '<LEADER>s"', '<CMD>Telescope registers<CR>',   desc = 'Registers' },
      {
        '<LEADER>sa',
        '<CMD>Telescope autocommands<CR>',
        desc = 'Auto Commands',
      },
      {
        '<LEADER>sd',
        '<CMD>Telescope diagnostics bufnr=0<CR>',
        desc = 'Document diagnostics',
      },
      {
        '<LEADER>sD',
        '<CMD>Telescope diagnostics<CR>',
        desc = 'Workspace diagnostics',
      },
      {
        '<LEADER>sh',
        '<CMD>Telescope highlights<CR>',
        desc = 'Search Highlight Groups',
      },
      { '<LEADER>sk', '<CMD>Telescope keymaps<CR>',     desc = 'Key Maps' },
      { '<LEADER>sm', '<CMD>Telescope marks<CR>',       desc = 'Jump to Mark' },
      { '<LEADER>so', '<CMD>Telescope vim_options<CR>', desc = 'Options' },
      {
        '<LEADER>uC',
        Util.telescope('colorscheme', { enable_preview = true }),
        desc = 'Colorscheme with preview',
      },
    },
    opts = function()
      local actions = require('telescope.actions')

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
              ['<C-t>'] = actions.select_tab,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<S-TAB>'] = actions.cycle_history_next,
              ['<TAB>'] = actions.cycle_history_prev,
              ['<C-v>'] = actions.select_vertical,
              ['<C-h>'] = actions.select_horizontal,
              [keybinds.scroll_left] = actions.preview_scrolling_left,
              [keybinds.scroll_right] = actions.preview_scrolling_right,
              [keybinds.scroll_down] = actions.preview_scrolling_down,
              [keybinds.scroll_up] = actions.preview_scrolling_up,
            },
            n = {
              ['q'] = actions.close,
            },
          },
        },
      }
    end,
  },

  -- move windows
  {
    'sindrets/winshift.nvim',
    lazy = true,
    keys = {
      { '<LEADER>wm', '<CMD>WinShift<CR>', desc = 'Move window' },
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
        map("n", "<LEADER>hp", gs.preview_hunk, "Preview Hunk")
        map("n", "<LEADER>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<LEADER>hD", gs.diffthis, "Diff This")
        map("n", "<LEADER>hd", function() gs.diffthis("~") end, "Diff This ~")
      end,
    },
  },

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      { '<LEADER>k', '<CMD>WhichKey<CR>' },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
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
  { 'echasnovski/mini.bufremove' },

  -- better diagnostics list and others
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = { use_diagnostic_signs = true },
    keys = {
      { '<LEADER>xx', '<CMD>TroubleToggle document_diagnostics<CR>',  desc = 'Document Diagnostics (Trouble)' },
      { '<LEADER>xX', '<CMD>TroubleToggle workspace_diagnostics<CR>', desc = 'Workspace Diagnostics (Trouble)' },
      { '<LEADER>xl', '<CMD>TroubleToggle loclist<CR>',               desc = 'Location List (Trouble)' },
      { '<LEADER>xq', '<CMD>TroubleToggle quickfix<CR>',              desc = 'Quickfix List (Trouble)' },
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
      { "<LEADER>xt", "<CMD>TodoTrouble<CR>",                              desc = "Todo (Trouble)" },
      { "<LEADER>xT", "<CMD>TodoTrouble keywords=TODO,FIX,FIXME<CR>",      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<LEADER>st", "<CMD>TodoTelescope<CR>",                            desc = "Todo" },
      { "<LEADER>sT", "<CMD>TodoTelescope keywords=TODO,FIX,FIXME<CR>",    desc = "Todo/Fix/Fixme" },
    },
  },

  -- project
  {
    'ahmedkhalf/project.nvim',
    opts = {
      manual_mode = true,
      detection_methods = { 'lsp', 'pattern' },
      patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '.sln', '.vim' },
      silent_chdir = true,
    },
    event = 'VeryLazy',
    config = function(_, opts)
      require('project_nvim').setup(opts)
      Util.on_load('telescope.nvim', function()
        require('telescope').load_extension('projects')
      end)
    end,
    keys = {
      { '<LEADER>sp', '<CMD>Telescope projects<CR>', desc = 'Projects' },
    },
  },

  -- Session manager
  {
    'rmagatti/auto-session',
    opts = {
      log_level = vim.log.levels.ERROR,
      auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
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

  -- Terminal trigger
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    lazy = false,
    opts = {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.3
        end
      end,
      open_mapping = '<c-\\>',
      insert_mappings = true,
      start_in_insert = true,
      terminal_mappings = true,
    },
    init = function()
      local Terminal = require('toggleterm.terminal').Terminal
      local gitui = Terminal:new({
        cmd = 'gitui',
        dir = 'git_dir',
        direction = 'float',
        float_opts = {
          border = 'double',
        },
        on_open = function(term)
          vim.cmd('startinsert!')
          local opt = { noremap = true, silent = true }
          -- q / <leader>tg 关闭 terminal
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<CMD>close<CR>', opt)
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', '<A-g>', '<CMD>close<CR>', opt)
          -- ESC ���取消，留给gitui
          if vim.fn.mapcheck('<Esc>', 't') ~= '' then
            vim.api.nvim_del_keymap('t', '<Esc>')
          end
        end,
        on_close = function(_)
          -- 添加回来
          local opt = { noremap = true, silent = true }
          vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', opt)
        end,
      })
      local terms = {}

      function _G.term_toggle(style)
        local number = vim.v.count
        if terms[number] == nil then
          terms[number] = Terminal:new({})
        end
        terms[number].direction = style
        terms[number].id = number
        terms[number]:toggle()
      end

      function _G.gitui_toggle()
        gitui:toggle()
      end

      vim.keymap.set({ 'n', 't' }, 'tg', '<CMD>lua gitui_toggle()<CR>', { desc = 'Toggle GitUI' })
      vim.keymap.set(
        { 'n', 't' },
        'tt',
        '<CMD>lua term_toggle([[horizontal]])<CR>',
        { desc = 'Toggle Terimal Bottom' }
      )
      vim.keymap.set(
        { 'n', 't' },
        'tf',
        '<CMD>lua term_toggle([[float]])<CR>',
        { desc = 'Toggle Terimal float' }
      )
      vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', { desc = 'Quit Terminal' })
    end,
  },
}
