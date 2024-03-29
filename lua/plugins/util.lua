return {
  -- Session management. This saves your session in the background,
  -- keeping track of open buffers, window arrangement, and more.
  -- You can restore sessions when returning through the dashboard.
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = { options = vim.opt.sessionoptions:get() },
    keys = {
      {
        '<LEADER>qr',
        function()
          require('persistence').load()
        end,
        desc = 'Restore Session',
      },
      {
        '<LEADER>ql',
        function()
          require('persistence').load({ last = true })
        end,
        desc = 'Restore Last Session',
      },
      {
        '<LEADER>qd',
        function()
          require('persistence').stop()
        end,
        desc = "Don't Save Current Session",
      },
      {
        '<LEADER>qs',
        '<CMD>SessionSave<CR>',
        desc = 'Save Current Session',
      },
    },
  },

  -- Library used by other plugins
  { 'nvim-lua/plenary.nvim' },

  -- Switch Input Method automatically depends on NeoVim's edit mode.
  {
    'keaising/im-select.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    opts = {
      -- IM will be set to `default_im_select` in `normal` mode
      -- For Windows/WSL, default: "1033", aka: English US Keyboard
      -- For macOS, default: "com.apple.keylayout.ABC", aka: US
      -- For Linux, default:
      --               "keyboard-us" for Fcitx5
      --               "1" for Fcitx
      --               "xkb:us::eng" for ibus
      -- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
      -- default_im_select = 'com.apple.keylayout.ABC',

      -- Can be binary's name or binary's full path,
      -- e.g. 'im-select' or '/usr/local/bin/im-select'
      -- For Windows/WSL, default: "im-select.exe"
      -- For macOS, default: "im-select"
      -- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus"
      -- default_command = 'im-select.exe',
    },
    config = function(_, opts)
      require('im_select').setup(opts)
    end,
  },

  -- Colorscheme maker
  { 'rktjmp/lush.nvim', enabled = false },
}
