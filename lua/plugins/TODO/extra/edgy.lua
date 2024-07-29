return {
  'folke/edgy.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
      left = { size = 30 },
      bottom = { size = 10 },
      right = { size = 30 },
      top = { size = 10 },
    },
    bottom = {
      -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
      {
        ft = 'toggleterm',
        size = { height = 0.4 },
        -- exclude floating windows
        filter = function(_, win)
          return vim.api.nvim_win_get_config(win).relative == ''
        end,
      },
    },
    left = {
      -- Neo-tree filesystem always takes half the screen height
      {
        title = 'File Explorer',
        ft = 'NvimTree',
        -- filter = function(buf)
        --   return vim.b[buf].neo_tree_source == 'filesystem'
        -- end,
        size = {},
      },
    },
  },
}
