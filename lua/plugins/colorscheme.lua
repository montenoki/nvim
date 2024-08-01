return {
  { 'EdenEast/nightfox.nvim', lazy = true },
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    opts = {
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
    },
  },
  { 'Mofiqul/dracula.nvim', lazy = true },
  {
    'neanias/everforest-nvim',
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require('everforest').setup({
        disable_italic_comments = true,
      })
    end,
  },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = false
      vim.g.gruvbox_material_disable_italic_comment = true
      -- vim.cmd.colorscheme('gruvbox-material')
    end,
  },
}
