-- Powershell Setting for Windows
local powershell_options = {
  shell = vim.fn.executable('pwsh') == 1 and 'pwsh -NoLogo' or 'powershell',
  shellcmdflag = '-ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
  shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
  shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
  shellquote = '',
  shellxquote = '',
}
for option, value in pairs(powershell_options) do
  vim.opt[option] = value
end

return {
  -- Switch Input Method automatically depends on NeoVim's edit mode.
  {
    'keaising/im-select.nvim',
    enabled = false,
    default_im_select = '1033',
    default_command = '~\\AppData\\Local\\nvim\\im-select.exe',
  },
}
