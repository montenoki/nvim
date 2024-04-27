if vim.g.vscode == nil then
  if vim.g.lite then
    vim.cmd('colorscheme baretty')
  else
    vim.cmd('colorscheme kanagawa')
  end
end
