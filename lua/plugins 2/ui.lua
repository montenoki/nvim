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


  -- Indent guides for Neovim


  -- Active indent guide and indent text objects. When you're browsing
  -- code, this highlights the current level of indentation, and animates
  -- the highlighting.


  -- Dev icons


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
    enabled = false,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    cond = function()
      return vim.g.lite_mode == nil
    end,
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
    -- animations
    {
      'echasnovski/mini.animate',
      event = 'VeryLazy',
      opts = function()
        -- don't use animate when scrolling with the mouse
        local mouse_scrolled = false
        for _, scroll in ipairs({ 'Up', 'Down' }) do
          local key = '<ScrollWheel' .. scroll .. '>'
          vim.keymap.set({ '', 'i' }, key, function()
            mouse_scrolled = true
            return key
          end, { expr = true })
        end

        local animate = require('mini.animate')
        return {
          resize = {
            timing = animate.gen_timing.linear({
              duration = 100,
              unit = 'total',
            }),
          },
          scroll = {
            timing = animate.gen_timing.linear({
              duration = 150,
              unit = 'total',
            }),
            subscroll = animate.gen_subscroll.equal({
              predicate = function(total_scroll)
                if mouse_scrolled then
                  mouse_scrolled = false
                  return false
                end
                return total_scroll > 1
              end,
            }),
          },
        }
      end,
    },
  },
}
