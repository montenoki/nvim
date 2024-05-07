return {
  -- Switch Input Method automatically depends on NeoVim's edit mode.
  {
    'keaising/im-select.nvim',
    opts = {
      keep_quiet_on_no_binary = true,
      default_im_select = 'xkb:us::eng',
      default_command = 'ibus',
    },
  },
}
