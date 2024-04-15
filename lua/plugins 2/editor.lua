local Util = require('util')
local keybinds = require('keymaps')
local Icon = require('icons')
return {


  -- better diagnostics list and others
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = { use_diagnostic_signs = true },
    keys = {
      {
        '<LEADER>xx',
        '<CMD>TroubleToggle document_diagnostics<CR>',
        desc = 'Document Diagnostics (Trouble)',
      },
      {
        '<LEADER>xX',
        '<CMD>TroubleToggle workspace_diagnostics<CR>',
        desc = 'Workspace Diagnostics (Trouble)',
      },
      {
        '<LEADER>xl',
        '<CMD>TroubleToggle loclist<CR>',
        desc = 'Location List (Trouble)',
      },
      {
        '<LEADER>xq',
        '<CMD>TroubleToggle quickfix<CR>',
        desc = 'Quickfix List (Trouble)',
      },
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
        NOTE = {
          icon = Icon.todo_comments.NOTE,
          color = 'hint',
          alt = { 'INFO', 'NOTE' },
        },
        WARN = {
          icon = Icon.todo_comments.WARN,
          color = 'warning',
          alt = { 'WARNING', 'XXX' },
        },
        FIX = {
          icon = Icon.todo_comments.FIX,
          color = 'error',
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
        },
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
      patterns = {
        '.git',
        '_darcs',
        '.hg',
        '.bzr',
        '.svn',
        'Makefile',
        'package.json',
        '.sln',
        '.vim',
      },
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
      auto_session_suppress_dirs = {
        '~/',
        '~/Projects',
        '~/Downloads',
        '/',
        '~/codes',
      },
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

        local venv = require('venv-selector').get_active_venv()
        local os_name = vim.loop.os_uname().sysname
        if venv ~= nil then
          local cmd
          if string.find(os_name, 'Windows') then
            cmd = venv .. 'Scripts\\activate.ps1'
            vim.cmd(number .. "TermExec cmd='" .. cmd .. "'")
          else
            cmd = 'source ' .. venv .. '/bin/activate;'
            vim.cmd(number .. [[TermExec cmd=']] .. cmd .. "'")
          end
        end
      end

      function _G.gitui_toggle()
        gitui:toggle()
      end

      vim.keymap.set({ 'n' }, 'tg', '<CMD>lua gitui_toggle()<CR>', { desc = 'Toggle GitUI' })
      vim.keymap.set({ 'n' }, 'tt', '<CMD>lua term_toggle([[horizontal]])<CR>', { desc = 'Toggle Terimal Bottom' })
      vim.keymap.set({ 'n' }, 'tf', '<CMD>lua term_toggle([[float]])<CR>', { desc = 'Toggle Terimal float' })
      vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', { desc = 'Quit Terminal' })
    end,
  },

  -- Outline
  {
    'simrat39/symbols-outline.nvim',
    keys = {
      { '<LEADER>cs', '<CMD>SymbolsOutline<CR>', desc = 'Symbols Outline' },
    },
    cmd = 'SymbolsOutline',
    opts = function()
      local defaults = require('symbols-outline.config').defaults
      local opts = {
        show_guides = false,
        relative_width = false,
        width = 40,
        autofold_depth = 1,
        auto_unfold_hover = true,
        fold_markers = { Icon.fillchars.foldclose, Icon.fillchars.foldopen },
        keymaps = {
          close = { '<ESC>', 'q' },
          goto_location = '<CR>',
          focus_location = '<TAB>',
          hover_symbol = 'h',
          rename_symbol = '<LEADER>r',
          code_actions = '<LEADER>ca',
          fold = 'c',
          unfold = 'o',
          fold_all = 'zM',
          unfold_all = 'zR',
          fold_reset = 'R',
        },
        symbols = {},
        symbol_blacklist = {},
      }
      local filter = {
        default = {
          'Class',
          'Constructor',
          'Enum',
          'Field',
          'Function',
          'Interface',
          'Method',
          'Module',
          'Namespace',
          'Package',
          'Property',
          'Struct',
          'Trait',
        },
      }

      if type(filter) == 'table' then
        filter = filter.default
        if type(filter) == 'table' then
          for kind, symbol in pairs(defaults.symbols) do
            opts.symbols[kind] = {
              icon = Icon.navic[kind] or symbol.icon,
              hl = symbol.hl,
            }
            if not vim.tbl_contains(filter, kind) then
              table.insert(opts.symbol_blacklist, kind)
            end
          end
        end
      end
      return opts
    end,
  },

  -- Neogit
  {
    'NeogitOrg/neogit',
    keys = {
      { '<LEADER>g', '<CMD>Neogit<CR>', desc = 'NeoGit' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = true,
  },
}
