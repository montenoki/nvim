-- If the flag file exists, enable mode
local lite_flg_path = vim.fn.stdpath('config') .. '/flg/enabled/lite_mode.flg'
if vim.fn.empty(vim.fn.glob(lite_flg_path)) == 0 or vim.env.TERM == 'linux' then
  vim.g.lite_mode = true
end
local copilot_flg_path = vim.fn.stdpath('config') .. '/flg/enabled/copilot.flg'
if vim.fn.empty(vim.fn.glob(copilot_flg_path)) == 0 then
  vim.g.copilot = true
end

vim.g.mapleader = ' '

vim.g.encoding = 'UTF-8'

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Python Provider
local executable_path
local os_name = vim.loop.os_uname().sysname
if string.find(os_name, 'Windows') then
  executable_path = '\\.virtualenvs\\neovim\\Scripts\\python.exe'
else
  executable_path = '/.virtualenvs/neovim/bin/python'
end
local path = vim.env.HOME .. executable_path
vim.g.python3_host_prog = path
