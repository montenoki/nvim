local Util = require('util')
local Icon = require('icons')
local keybinds = require('keymaps')
return {
  -- Better `vim.notify()`
  


  -- Indent guides for Neovim


  -- Active indent guide and indent text objects. When you're browsing
  -- code, this highlights the current level of indentation, and animates
  -- the highlighting.


  -- Dev icons



  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  

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
  
}
