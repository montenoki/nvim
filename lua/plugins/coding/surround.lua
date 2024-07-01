--- Plugin settings: comment
-- @author monten (monten.oki@gmail.com)
-- @license MIT
-- @copyright monten.oki 2024

local Keys = require('keymaps').surround
return {
  'echasnovski/mini.surround',
  cond = vim.g.vscode == nil,
  keys = function(_, keys)
    -- Populate the keys based on the user's options
    local plugin = require('lazy.core.config').spec.plugins['mini.surround']
    local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
    local mappings = {
      { opts.mappings.add, desc = 'Add Surrounding', mode = { 'n', 'v' } },
      { opts.mappings.delete, desc = 'Delete Surrounding' },
      { opts.mappings.find, desc = 'Find Right Surrounding' },
      { opts.mappings.find_left, desc = 'Find Left Surrounding' },
      { opts.mappings.highlight, desc = 'Highlight Surrounding' },
      { opts.mappings.replace, desc = 'Replace Surrounding' },
    }
    mappings = vim.tbl_filter(function(m)
      return m[1] and #m[1] > 0
    end, mappings)
    return vim.list_extend(mappings, keys)
  end,
  opts = {
    mappings = {
      add = Keys.add, -- Add surrounding in Normal and Visual modes
      delete = Keys.delete, -- Delete surrounding
      replace = Keys.replace, -- Replace surrounding
      find = Keys.find, -- Find surrounding (to the right)
      find_left = Keys.find_left, -- Find surrounding (to the left)
      highlight = Keys.highlight, -- Highlight surrounding
      update_n_lines = '', -- Update `n_lines`
    },
  },
}
