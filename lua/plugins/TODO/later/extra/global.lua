-- =============================================================================
-- If flag file exists, enable mode
-- =============================================================================
local liteFlagFile = vim.fn.stdpath('config') .. '/flg/enabled/lite.flg'
local flagFileExists = vim.loop.fs_stat(liteFlagFile)

if flagFileExists or vim.env.TERM == 'linux' then
  vim.g.lite = true
end
