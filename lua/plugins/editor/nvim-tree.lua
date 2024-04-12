local Lazyvim = require('lazyvim')
local Keys = require('keymaps').nvimtree
local Icon = require('icons')
-- File explorer
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
      -- default
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
          down = { Keys.scroll_down },
          -- scroll up float buffer
          up = { Keys.scroll_up },
          -- enable/disable float windows
          toggle = { '<TAB>' },
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
    { Keys.toggle, '<CMD>NvimTreeFindFileToggle<CR>', desc = 'File Explorer', },
  },
  config = function()
    require('nvim-tree').setup({
      disable_netrw = true,
      -- project plugin
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = false,
        update_root = false,
        ignore_list = {},
      },

      view = { width = 40, preserve_window_proportions = true },
      renderer = {
        indent_markers = {
          icons = {
            corner = Icon.neotree.last_indent_marker,
            edge = Icon.neotree.indent_marker,
            item = Icon.neotree.indent_marker,
            bottom = Icon.neotree.last_indent_marker,
          },
        },
        icons = {
          web_devicons = { folder = { enable = true } },
          symlink_arrow = Icon.neotree.symlink_arrow,
          git_placement = 'after',
          glyphs = {
            default = Icon.neotree.file,
            symlink = Icon.neotree.symlink_file,
            bookmark = Icon.neotree.bookmark,
            modified = Icon.bufferline.modified_icon,
            folder = {
              arrow_closed = Icon.neotree.expander_collapsed,
              arrow_open = Icon.neotree.expander_expanded,
              default = Icon.neotree.folder_closed,
              open = Icon.neotree.folder_open,
              empty = Icon.neotree.folder_empty,
              empty_open = Icon.neotree.folder_empty,
              symlink = Icon.neotree.symlink,
              symlink_open = Icon.neotree.symlink,
            },
            git = {
              unstaged = Icon.git.unstaged,
              staged = Icon.git.staged,
              unmerged = Icon.git.unmerged,
              renamed = Icon.git.renamed,
              untracked = Icon.git.untracked,
              deleted = Icon.git.deleted,
              ignored = Icon.git.ignored,
            },
          },
        },
      },
      system_open = {
        -- TODO[2023/12/19]: mac/win support
        cmd = 'open',
        args = {},
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = Icon.diagnostics.Hint,
          info = Icon.diagnostics.Info,
          warning = Icon.diagnostics.Warn,
          error = Icon.diagnostics.Error,
        },
      },
      modified = { enable = true },
      actions = {
        open_file = {
          quit_on_open = true,
          resize_window = true,
          window_picker = {
            chars = 'FJDKSLA;',
          },
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
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Edit'))
        vim.keymap.set('n', 'o', api.node.run.system, opts('System Open'))
        -- vim.keymap.set('n', '<tab>', api.node.open.preview, opts('Preview'))
        vim.keymap.set('n', 't', api.node.open.tab, opts('Open in New Tab'))
        vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open in VSplit'))
        vim.keymap.set(
          'n',
          'h',
          api.node.open.horizontal,
          opts('Open in Split')
        )
        --
        vim.keymap.set(
          'n',
          'I',
          api.tree.toggle_gitignore_filter,
          opts('Toggle Git Ignored')
        )
        vim.keymap.set(
          'n',
          '.',
          api.tree.toggle_hidden_filter,
          opts('Toggle Dotfiles')
        )
        vim.keymap.set(
          'n',
          'u',
          api.tree.toggle_custom_filter,
          opts('Toggle Custom files')
        )
        vim.keymap.set(
          'n',
          'i',
          api.node.show_info_popup,
          opts('Toggle File Info')
        )
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Toggle Help'))

        vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
        --
        vim.keymap.set('n', 'f', api.live_filter.start, opts('Live Filter'))
        vim.keymap.set(
          'n',
          'F',
          api.live_filter.clear,
          opts('Clear Live Filter')
        )
        vim.keymap.set('n', ']', api.tree.change_root_to_node, opts('cd'))
        vim.keymap.set('n', '[', api.node.navigate.parent, opts('Dir Up'))

        vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
        vim.keymap.set('n', 'd', api.fs.remove, opts('Remove'))
        vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
        vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
        vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
        vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
        vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
        vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Path'))
        vim.keymap.set(
          'n',
          'gy',
          api.fs.copy.absolute_path,
          opts('Copy Abs Path')
        )
      end,
    })
  end,
}
