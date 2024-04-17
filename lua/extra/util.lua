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

  -- Switch Input Method automatically depends on NeoVim's edit mode.
  

  -- Colorscheme maker
  { 'rktjmp/lush.nvim', enabled = false },
}
