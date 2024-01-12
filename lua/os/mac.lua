return {
  -- Switch Input Method automatically depends on NeoVim's edit mode.
  {
    'keaising/im-select.nvim',
    config = function()
      require('im_select').setup({
        default_im_select = 'com.apple.keylayout.ABC',
        default_command = 'im-select',
      })
    end,
  },
}
