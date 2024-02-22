return {
  -- Switch Input Method automatically depends on NeoVim's edit mode.
  {
    'keaising/im-select.nvim',
    opts = {
      default_im_select = 'com.apple.keylayout.ABC',
      default_command = 'im-select',
    },
  },
}
