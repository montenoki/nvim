return {
  -- Switch Input Method automatically depends on NeoVim's edit mode.
  {
    'keaising/im-select.nvim',
    opts = {
      default_im_select = 'com.apple.keylayout.ABC',
      default_command = 'im-select',
      keep_quiet_on_no_binary = true,
    },
  },
}
