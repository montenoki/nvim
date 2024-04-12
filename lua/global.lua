-- If the flag file exists, enable mode
local lite_flg_path = vim.fn.stdpath('config') .. '/flg/enabled/lite_mode.flg'
if vim.fn.empty(vim.fn.glob(lite_flg_path)) == 0 or vim.env.TERM == 'linux' then
  vim.g.lite_mode = true
end
local copilot_flg_path = vim.fn.stdpath('config') .. '/flg/enabled/copilot.flg'
if vim.fn.empty(vim.fn.glob(copilot_flg_path)) == 0 then
  vim.g.copilot = true
end
