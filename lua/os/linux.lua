return {
  -- Switch Input Method automatically depends on NeoVim's edit mode.
  {
    'keaising/im-select.nvim',
    opts = {
      default_im_select = 'keyboard-us',
      default_command = 'fcitx5-remote',
    },
  },
}
