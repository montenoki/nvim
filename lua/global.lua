local lite_flg_path = vim.fn.stdpath("config") .. "/lite_mode.flg"

if vim.fn.empty(vim.fn.glob(lite_flg_path)) == 0 then
    vim.g.lite_mode = true
end

vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\" -- todo: check this

vim.g.encoding = "UTF-8"

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable LazyVim auto format
-- vim.g.autoformat = true

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- Python Provider
local executable_path
local os_name = vim.loop.os_uname().sysname
if os_name == 'Windows' or os_name == 'Windows_NT' then
    executable_path = '\\.virtualenvs\\neovim\\Scripts\\python.exe'
else
    executable_path = '/.virtualenvs/neovim/bin/python'
end
local path = vim.env.HOME .. executable_path
vim.g.python3_host_prog = path
