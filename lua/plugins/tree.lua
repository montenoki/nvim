local keymaps = require('keymaps')
local map = vim.keymap.set
local autocmds = require('autocmds')

-- fix nvimtree when using auto-session
vim.api.nvim_create_autocmd('BufEnter', {
  group = autocmds.augroup('NvimTreeAutoOpen'),
  pattern = 'NvimTree*',
  callback = function()
    local api = require('nvim-tree.api')
    local view = require('nvim-tree.view')
    if not view.is_visible() then
      api.tree.open()
    end
  end,
})

return {
  {
    'JMarkin/nvim-tree.lua-float-preview',
    lazy = true,
    opts = {
      toggled_on = false,
      -- window config
      mapping = {
        down = { keymaps.floatWindow.scrollDown },
        up = { keymaps.floatWindow.scrollUp },
        toggle = { keymaps.open.preview },
      },
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons', 'JMarkin/nvim-tree.lua-float-preview' },
    keys = {
      { keymaps.open.nvimTree, '<CMD>NvimTreeFindFileToggle<CR>', desc = 'File Explorer' },
    },
    init = function()
      -- Disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      disable_netrw = true,
      -- project plugin
      sync_root_with_cwd = true,
      respect_buf_cwd = true,

      view = {
        width = { min = 10, max = -1 },
        preserve_window_proportions = true,
      },
      renderer = {
        icons = {
          git_placement = 'after',
        },
      },
      system_open = {
        -- TODO[2023/12/19]: Add mac/win support
        cmd = 'open',
        args = {},
      },
      diagnostics = {
        enable = true,
      },
      modified = { enable = true },
      actions = {
        open_file = {
          window_picker = { chars = 'FJKDSLA' },
        },
      },
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local FloatPreview = require('float-preview')
        FloatPreview.attach_nvimtree(bufnr)

        -- custom mappings
        local function opts(desc)
          return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end
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
        map('n', 'q', api.tree.close, opts('Close Tree'))
      end,
    },
    config = function(_, opts)
      require('nvim-tree').setup(opts)
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = function(_, opts)
      if type(opts.options.disabled_filetypes.winbar) == 'table' then
        vim.list_extend(opts.options.disabled_filetypes.winbar, { 'NvimTree' })
      end
      if type(opts.extensions) == 'table' then
        vim.list_extend(opts.extensions, { 'nvim-tree' })
      end
    end,
  },
}
