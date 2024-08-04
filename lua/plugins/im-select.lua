return {
  'keaising/im-select.nvim',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
  opts = {
    -- IM will be set to `default_im_select` in `normal` mode
    -- For Windows/WSL, default: "1033", aka: English US Keyboard
    -- For macOS, default: "com.apple.keylayout.ABC", aka: US
    -- For Linux, default:
    --               "keyboard-us" for Fcitx5
    --               "1" for Fcitx
    --               "xkb:us::eng" for ibus
    -- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
    -- default_im_select = 'com.apple.keylayout.ABC',

    -- Can be binary's name or binary's full path,
    -- e.g. 'im-select' or '/usr/local/bin/im-select'
    -- For Windows/WSL, default: "im-select.exe"
    -- For macOS, default: "im-select"
    -- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus"
    -- default_command = 'im-select.exe',
  },
  config = function(_, opts)
    require('im_select').setup(opts)
  end,
}
