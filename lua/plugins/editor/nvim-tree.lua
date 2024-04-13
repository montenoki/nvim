local Lazyvim = require('lazyvim')
local Keys = require('keymaps')
local Ascii_icons = require('util.ascii_icons').nvimtree
local map = vim.keymap.set

-- Toggle Adaptive Width
local VIEW_WIDTH_FIXED = 30
local view_width_max = VIEW_WIDTH_FIXED -- fixed to start

-- toggle the width and redraw
local function toggle_width_adaptive()
  if view_width_max == -1 then
    view_width_max = VIEW_WIDTH_FIXED
  else
    view_width_max = -1
  end

  require('nvim-tree.api').tree.reload()
end

return {
  'nvim-tree/nvim-tree.lua',
  cond = vim.g.vscode == nil,
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    {
      'JMarkin/nvim-tree.lua-float-preview',
      lazy = true,
      opts = {
        toggled_on = false,
        -- wrap nvimtree commands
        wrap_nvimtree_commands = true,
        -- lines for scroll
        scroll_lines = 20,
        -- window config
        window = {
          style = 'minimal',
          border = 'rounded',
          relative = 'win',
          wrap = false,
        },
        mapping = {
          -- scroll down float buffer
          down = { Keys.float_window.scroll_down },
          -- scroll up float buffer
          up = { Keys.float_window.scroll_up },
          -- enable/disable float windows
          toggle = { Keys.nvimtree.toggle_preview },
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
    { Keys.nvimtree.toggle, '<CMD>NvimTreeFindFileToggle<CR>', desc = 'File Explorer' },
  },
  opts = {
    disable_netrw = true,
    -- project plugin
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = false,
      update_root = false,
      ignore_list = {},
    },

    view = {
      width = {
        min = 30,
        max = function()
          return view_width_max
        end,
      },
      preserve_window_proportions = true,
    },
    renderer = {
      icons = {
        web_devicons = { folder = { enable = true } },
        git_placement = 'after',
      },
    },
    system_open = {
      -- TODO[2023/12/19]: mac/win support
      cmd = 'open',
      args = {},
    },
    diagnostics = {
      enable = true,
    },
    modified = { enable = true },
    actions = {
      open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = { chars = 'FJKDSLA;' },
      },
    },
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')
      local function opts(desc)
        return {
          desc = 'nvim-tree: ' .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end
      local FloatPreview = require('float-preview')
      FloatPreview.attach_nvimtree(bufnr)

      -- custom mappings
      map('n', '<CR>', api.node.open.edit, opts('Edit'))
      map('n', 'o', api.node.run.system, opts('System Open'))
      map('n', 't', api.node.open.tab, opts('Open in New Tab'))
      map('n', 'v', api.node.open.vertical, opts('Open in VSplit'))
      map('n', 'h', api.node.open.horizontal, opts('Open in Split'))

      map('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignored'))
      map('n', '.', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
      map('n', 'u', api.tree.toggle_custom_filter, opts('Toggle Custom files'))
      map('n', 'i', api.node.show_info_popup, opts('Toggle File Info'))
      map('n', '?', api.tree.toggle_help, opts('Toggle Help'))

      map('n', 'R', api.tree.reload, opts('Refresh'))
      map('n', 'f', api.live_filter.start, opts('Live Filter'))
      map('n', 'F', api.live_filter.clear, opts('Clear Live Filter'))
      map('n', ']', api.tree.change_root_to_node, opts('cd'))
      map('n', '[', api.node.navigate.parent, opts('Dir Up'))

      map('n', 'a', api.fs.create, opts('Create'))
      map('n', 'd', api.fs.remove, opts('Remove'))
      map('n', 'r', api.fs.rename, opts('Rename'))
      map('n', 'x', api.fs.cut, opts('Cut'))
      map('n', 'c', api.fs.copy.node, opts('Copy'))
      map('n', 'p', api.fs.paste, opts('Paste'))
      map('n', 'y', api.fs.copy.filename, opts('Copy Name'))
      map('n', 'Y', api.fs.copy.relative_path, opts('Copy Path'))
      map('n', 'gy', api.fs.copy.absolute_path, opts('Copy Abs Path'))
      map('n', 'A', toggle_width_adaptive, opts('Toggle Adaptive Width'))
    end,
  },
  config = function(_, opts)
    if vim.g.lite ~= nil then
      opts.renderer.indent_markers = { icons = Ascii_icons.indent_markers }
      opts.renderer.icons.symlink_arrow = Ascii_icons.symlink_arrow
      opts.renderer.icons.glyphs = Ascii_icons.glyphs
      opts.diagnostics.icons = Ascii_icons.diagnostics
    end
    require('nvim-tree').setup(opts)
  end,
}
