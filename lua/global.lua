-- =============================================================================
-- If flag file exists, enable mode
-- =============================================================================
local liteFlagFile = vim.fn.stdpath('config') .. '/flg/enabled/lite.flg'
if vim.fn.empty(vim.fn.glob(liteFlagFile)) == 0 or vim.env.TERM == 'linux' then
  vim.g.lite = true
end
