if vim.g.vscode == nil then
  if vim.g.lite then
    vim.cmd('colorscheme baretty')
  else
    require('nightfox').load()
    vim.cmd('colorscheme carbonfox')
    vim.api.nvim_set_hl(0, 'matchparen', { fg = '#ffe338', bold = true })
  end
end
