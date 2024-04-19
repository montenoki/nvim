return {
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
