-- Powershell Setting for Windows
local powershell_options = {
  shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell',
  shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;",
  shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode',
  shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode',
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
  },
}
