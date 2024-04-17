local Icons = require('icons')
local keybinds = require('keymaps')
local function t(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), 'm', true)
end
local function can_execute(arg)
  return vim.fn[arg]() == 1
end
return {
  -- auto completion

  -- AI completion
  {
    'zbirenbaum/copilot.lua',
    enabled = vim.g.copilot and true or false,
    cmd = 'Copilot',
    build = ':Copilot auth',
    opts = {
      suggestion = { enabled = true },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}
