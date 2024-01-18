local Util = require('util')
local Icon = require('icons')
local keybinds = require('keymaps')
return {
  -- Better `vim.notify()`
  {
    'rcarriga/nvim-notify',
    keys = {
      -- stylua: ignore
      { '<LEADER>un', function() require('notify').dismiss({ silent = true, pending = true }) end, desc = 'Dismiss all Notifications' },
    },
    opts = {
      timeout = 5000,
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

  -- Better vim.ui
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
      { '<LEADER>tp', '<CMD>BufferLinePick<CR>', desc = 'Pick tab' },
      { '<LEADER>tP', '<CMD>BufferLinePickClose<CR>', desc = 'Pick close tab' },
    },
    opts = {
      options = {
        mode = 'tabs',
        close_command = function(n)
          require('mini.bufremove').delete(n, false)
        end,
        right_mouse_command = function(n)
          require('mini.bufremove').delete(n, false)
        end,

        buffer_close_icon = Icon.bufferline.buffer_close_icon,
        modified_icon = Icon.bufferline.modified_icon,
        close_icon = Icon.bufferline.close_icon,
        left_trunc_marker = Icon.bufferline.left_trunc_marker,
        right_trunc_marker = Icon.bufferline.right_trunc_marker,
        show_buffer_icons = Icon.bufferline.show_buffer_icons,
        indicator = {
          icon = '||', -- this should be omitted if indicator style is not 'icon'
          style = 'icon',
        },
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            highlight = 'Directory',
            text_align = 'left',
          },
          {
            filetype = 'dapui_scopes',
            text = 'Debug Mode',
            highlight = 'Directory',
            text_align = 'left',
          },
          {
            filetype = 'Outline',
            text = 'Outline',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
        diagnostics = 'nvim_lsp',
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd('BufAdd', {
        group = vim.api.nvim_create_augroup(
          'reload_bufferline',
          { clear = true }
        ),
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- Set an empty statusline till lualine loads
        vim.o.statusline = ' '
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      local lualine_require = require('lualine_require')
      lualine_require.require = require

      vim.o.laststatus = vim.g.lualine_laststatus
      return {
        options = {
          globalstatus = true,
          disabled_filetypes = {
            winbar = { 'NvimTree', 'dap-repl' },
          },
          component_separators = Icon.lualine.component_separators,
          section_separators = Icon.lualine.section_separators,
        },
        extensions = {
          'nvim-tree',
          'mason',
          'quickfix',
          'symbols-outline',
          'lazy',
          'toggleterm',
          'nvim-dap-ui',
        },
        sections = {
          lualine_a = {
            function()
              return Icon.lualine.nvim
            end,
            'mode',
          },
          lualine_b = {
            'branch',
          },
          lualine_c = {
            function()
              return Icon.lualine.session
                .. ' '
                .. require('auto-session.lib').current_session_name()
            end,
          },
          lualine_x = {
            {
              'macro-recording',
              ---@diagnostic disable-next-line: undefined-field
              fmt = Util.lualine.show_macro_recording,
              color = Util.ui.fg('Error'),
            },
            {
              function()
                ---@diagnostic disable-next-line: undefined-field
                return require('noice').api.status.command.get()
              end,
              cond = function()
                return package.loaded['noice']
                  ---@diagnostic disable-next-line: undefined-field
                  and require('noice').api.status.command.has()
              end,
              color = Util.ui.fg('Comment'),
            },
            {
              function()
                return Icon.bug .. require('dap').status()
              end,
              cond = function()
                return package.loaded['dap'] and require('dap').status() ~= ''
              end,
              color = Util.ui.fg('Debug'),
            },
            {
              function()
                local icon = Icon.cmp.Copilot
                local status = require('copilot.api').status.data
                return icon .. (status.message or '')
              end,
              cond = function()
                if not package.loaded['copilot'] then
                  return
                end
                local ok, clients = pcall(
                  require('util').lsp.get_clients,
                  { name = 'copilot', bufnr = 0 }
                )
                if not ok then
                  return false
                end
                return ok and #clients > 0
              end,
              color = function()
                if not package.loaded['copilot'] then
                  return
                end
                local status = require('copilot.api').status.data
                local colors = {
                  [''] = Util.ui.fg('Special'),
                  ['Normal'] = Util.ui.fg('Special'),
                  ['Warning'] = Util.ui.fg('DiagnosticError'),
                  ['InProgress'] = Util.ui.fg('DiagnosticWarn'),
                }
                return colors[status.status] or colors['']
              end,
            },
          },
          lualine_y = {},
          lualine_z = {
            'location',
            'progress',
            { 'fileformat', symbols = Icon.lualine.symbols },
            function()
              return Icon.clock .. os.date('%R')
            end,
          },
        },
        winbar = {
          lualine_a = {
            {
              'filetype',
              icon_only = true,
              separator = '',
              padding = { left = 1, right = 0 },
            },
            { Util.lualine.pretty_path() },
          },
          lualine_b = {
            {
              'diff',
              symbols = {
                added = Icon.git.added,
                modified = Icon.git.modified,
                removed = Icon.git.removed,
              },
              source = function()
                ---@diagnostic disable-next-line: undefined-field
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
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = {
            {
              'filetype',
              icon_only = true,
              separator = '',
              padding = { left = 1, right = 0 },
            },
            { Util.lualine.pretty_path() },
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },

  -- Indent guides for Neovim
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    opts = {
      indent = Icon.indent,
      scope = { enabled = false },
      exclude = {
        -- stylua: ignore
        filetypes = {
          'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'trouble',
          'lazy', 'mason', 'notify', 'toggleterm', 'lazyterm',
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
        -- stylua: ignore
        pattern = {
          'help', 'alpha', 'dashboard', 'nvim-tree', 'Trouble', 'trouble',
          'lazy', 'mason', 'notify', 'toggleterm', 'lazyterm',
        },
        callback = function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- Dev icons
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- UI components
  { 'MunifTanjim/nui.nvim', lazy = true },

  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    opts = {
      lsp = {
        progress = {
          enabled = true,
          -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
          -- See the section on formatting for more details on how to customize.
          --- @type NoiceFormat|string
          format = 'lsp_progress',
          --- @type NoiceFormat|string
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
      cmdline = {
        format = {
          cmdline = { icon = Icon.noice.cmdline },
          search_down = { icon = Icon.noice.search_down },
          search_up = { icon = Icon.noice.search_up },
          filter = { icon = Icon.noice.filter },
          lua = { icon = Icon.noice.lua },
          help = { icon = Icon.noice.help },
        },
      },
      format = {
        level = {
          icons = {
            error = Icon.diagnostics.Error,
            warn = Icon.diagnostics.Warn,
            info = Icon.diagnostics.Info,
          },
        },
      },
      popupmenu = {
        kind_icons = vim.g.lite_mode and false or {},
      },
      inc_rename = {
        cmdline = {
          format = {
            IncRename = { icon = Icon.noice.IncRename },
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<C-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c",                 desc = "Redirect Cmdline" },
      { "<LEADER>snl", function() require("noice").cmd("last") end,                   desc = "Noice Last Message" },
      { "<LEADER>snh", function() require("noice").cmd("history") end,                desc = "Noice History" },
      { "<LEADER>sna", function() require("noice").cmd("all") end,                    desc = "Noice All" },
      { "<LEADER>snd", function() require("noice").cmd("dismiss") end,                desc = "Dismiss All Noice" },
      {
        keybinds.scroll_down,
        function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" },
      },
      {
        keybinds.scroll_up,
        function() if not require("noice.lsp").scroll(-4) then return "<C-b>" end end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" },
      },
    },
  },

  -- Color code display like: #00ffff
  {
    'norcalli/nvim-colorizer.lua',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    keys = {
      {
        '<LEADER>uc',
        function()
          local colorizer = require('colorizer')
          if colorizer.is_buffer_attached(0) then
            colorizer.detach_from_buffer(0)
            Util.warn('Disabled Colorizer', { title = 'Option' })
          else
            colorizer.attach_to_buffer(0)
            Util.info('Enabled Colorizer', { title = 'Option' })
          end
        end,
        desc = 'Toggle Colorizer',
      },
    },
  },

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
      },
    },
  },

  -- TODO[2023/12/20]: config this later
  -- Better Fold
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require('statuscol.builtin')
          require('statuscol').setup({
            relculright = true,
            segments = {
              {
                text = { builtin.foldfunc },
                click = 'v:lua.ScFa',
              },
              {
                text = { '%s' },
                click = 'v:lua.ScSa',
              },
              {
                text = { builtin.lnumfunc, ' ' },
                click = 'v:lua.ScLa',
              },
            },
          })
        end,
      },
    },
    config = function()
      local ufo = require('ufo')
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (Icon.ufo.suffix):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end

      local ftMap = {
        lua = 'treesitter',
        python = { 'treesitter', 'indent' },
        git = '',
      }

      ---@diagnostic disable-next-line: missing-fields
      ufo.setup({
        fold_virt_text_handler = handler,
        open_fold_hl_timeout = 150,
        close_fold_kinds = { 'imports', 'comment' },
        preview = {
          win_config = {
            border = { '', '─', '', '', '', '─', '', '' },
            winhighlight = 'Normal:Folded',
            winblend = 0,
          },
          mappings = {
            scrollU = keybinds.scroll_up,
            scrollD = keybinds.scroll_down,
          },
        },
        ---@diagnostic disable-next-line: unused-local
        provider_selector = function(_bufnr_, filetype, _buftype_)
          return ftMap[filetype]
        end,
      })

      vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open All Folds' })
      vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close All Folds' })
      vim.keymap.set(
        'n',
        'zr',
        ufo.openFoldsExceptKinds,
        { desc = 'Open Folds' }
      )
      -- vim.keymap.set('n', 'zm', ufo.closeFoldWith, { desc = "Close Fold With" })
      vim.keymap.set('n', 'K', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { desc = 'Peek Folded Lines' })
    end,
  },
}
