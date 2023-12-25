local vscode = require('vscode-neovim')
local opt = vim.opt
vim.notify = vscode.notify
local function augroup(name)
  return vim.api.nvim_create_augroup('vscode_' .. name, { clear = true })
end

opt.showmode = true
vim.notify(vim.api.nvim_get_mode().mode)


-- vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
--   group = augroup('test'),
--   command = 'lua vim.notify(vim.api.nvim_get_mode().mode)',
-- })
