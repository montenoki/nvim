local Ascii_icons = require('util.ascii_icons')

local Keys = require('keymaps').gitsigns
return {
  {
    'lewis6991/gitsigns.nvim',
    cond = vim.g.vscode == nil,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    opts = {
      signs = vim.g.lite == nil and {
        add = { text = '+▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = 'U▎' },
      } or Ascii_icons.gitsigns,
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
      -- stylua: ignore start
      map("n", Keys.next_hunk, gs.next_hunk, "Next Hunk")
      map("n", Keys.prev_hunk, gs.prev_hunk, "Prev Hunk")
      map("n", Keys.preview_hunk, gs.preview_hunk, "Preview Hunk")
      map("n", Keys.blame_line, function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", Keys.diff, gs.diffthis, "Diff This")
      map("n", Keys.diff_tilde, function() gs.diffthis("~") end, "Diff This ~")
      end,
    },
  },
  {
    'lualine.nvim',
    cond = vim.g.vscode == nil,
    opts = function(_, opts)
      local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end
      table.insert(
        opts.winbar.lualine_x,
        {
          'diff',
          source = diff_source,
          symbols = vim.g.lite == nil and { added = ' ', modified = ' ', removed = ' ' } or Ascii_icons.git,
        }
      )
    end,
  },
}
