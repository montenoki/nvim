local Util = require('util')
local Icon = require('icons')
return {
  -- Better `vim.notify()`
  {
    'rcarriga/nvim-notify',
    keys = {
      -- stylua: ignore
      -- { '<leader>un', function() require('notify').dismiss({ silent = true, pending = true }) end, desc = 'Dismiss all Notifications' },
    },
    opts = {
      timeout = 4000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      if not Util.has('noice.nvim') then
        Util.on_very_lazy(function()
          vim.notify = require('notify')
        end)
      end
    end,
  },

  -- better vim.ui
  {
    'stevearc/dressing.nvim',
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load({ plugins = { 'dressing.nvim' } })
        return vim.ui.input(...)
      end
    end,
  },

  -- This is what powers LazyVim's fancy-looking
  -- tabs, which include filetype icons and close buttons.
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<LEADER>t', '<CMD>BufferLinePick<CR>', desc = 'Pick tab' },
      { '<LEADER>T', '<CMD>BufferLinePickClose<CR>', desc = 'Pick close tab' },
    },
    opts = {
      options = {
        mode = 'tabs',
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,

        buffer_close_icon = Icon.bufferline.buffer_close_icon,
        modified_icon = Icon.bufferline.modified_icon,
        close_icon = Icon.bufferline.close_icon,
        left_trunc_marker = Icon.bufferline.left_trunc_marker,
        right_trunc_marker = Icon.bufferline.right_trunc_marker,
        show_buffer_icons = Icon.bufferline.show_buffer_icons,
        indicator = {
          icon = '|', -- this should be omitted if indicator style is not 'icon'
          style = 'icon',
        },

        offsets = {
          { filetype = 'neo-tree', text = 'File Explorer', highlight = 'Directory', text_align = 'left' },
          { filetype = 'dapui_scopes', text = 'Debug Mode', highlight = 'Directory', text_align = 'left' },
          { filetype = 'Outline', text = 'Outline', highlight = 'Directory', text_align = 'left' },
        },
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(_, _, diag)
          local ret = (diag.error and Icon.diagnostics.Error .. diag.error .. ' ' or '')
            .. (diag.warning and Icon.diagnostics.Warn .. diag.warning or '')
          return vim.trim(ret)
        end,
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd('BufAdd', {
        callback = function()
          vim.schedule(function()
            ---@diagnostic disable-next-line: undefined-global
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = ' '
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require('lualine_require')
      lualine_require.require = require

      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          globalstatus = true,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'starter' } },
          component_separators = Icon.lualine.component_separators,
          section_separators = Icon.lualine.section_separators,
        },
        extensions = { 'neo-tree', 'lazy', 'toggleterm', 'nvim-dap-ui' },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            {
              'diff',
              symbols = {
                added = Icon.git.added,
                modified = Icon.git.modified,
                removed = Icon.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_c = {
            Util.lualine.root_dir(),
            { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            { Util.lualine.pretty_path() },
          },
          lualine_x = {
            {
              'macro-recording',
              fmt = Util.lualine.show_macro_recording,
              color = Util.ui.fg('Error'),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Util.ui.fg("Comment"),
            },
            -- TODO[2023/12/12]: config this after dap is fixed.
            -- stylua: ignore
            -- {
            --   function() return Icon.bug .. require("dap").status() end,
            --   cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            --   color = Util.ui.fg("Debug"),
            -- },
          },
          lualine_y = {
            {
              'diagnostics',
              symbols = {
                error = Icon.diagnostics.Error,
                warn = Icon.diagnostics.Warn,
                info = Icon.diagnostics.Info,
                hint = Icon.diagnostics.Hint,
              },
            },
          },
          lualine_z = {
            { 'fileformat', symbols = Icon.lualine.symbols },
            function()
              return Icon.clock .. os.date('%R')
            end,
          },
        },
      }
    end,
  },

  -- indent guides for Neovim
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    opts = {
      indent = Icon.indent,
      scope = { enabled = false },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
      },
    },
    main = 'ibl',
  },

  -- Active indent guide and indent text objects. When you're browsing
  -- code, this highlights the current level of indentation, and animates
  -- the highlighting.
  {
    'echasnovski/mini.indentscope',
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    opts = {
      symbol = Icon.indent.char,
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- Displays a popup with possible key bindings of the command you started typing
  {
    'folke/which-key.nvim',
    -- TODO[2023/12/12]: config this after noice and which-key is fixed.
    -- opts = function(_, opts)
    --   if require('lazyvim.util').has('noice.nvim') then
    --     opts.defaults['<leader>sn'] = { name = '+noice' }
    --   end
    -- end,
  },

  -- icons
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- ui components
  { 'MunifTanjim/nui.nvim', lazy = true },

  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        progress = {
          enabled = true,
          -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
          -- See the section on formatting for more details on how to customize.
          format = 'lsp_progress',
          format_done = 'lsp_progress_done',
          throttle = 1000 / 30, -- frequency to update lsp progress message
          view = 'mini',
        },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
  },

  -- Color code display like: #00ffff
  {
    'norcalli/nvim-colorizer.lua',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    keys = {
      {
        '<leader>uc',
        '<CMD>ColorizerToggle<CR>',
        desc = 'Toggle Colorizer',
      },
    },
  },

  -- TODO[2023/12/7]: config this later
  -- Scroll Bar
  {
    'petertriho/nvim-scrollbar',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    opts = {
      show_in_active_only = true,
      handle = {
        blend = 25,
      },
      handlers = {
        gitsigns = true,
      }
    },
  },
}
