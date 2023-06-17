local project = requirePlugin('project_nvim')
local uConfig = require('uConfig')

if project == nil or not uConfig.enable.project then
    return
end

-- nvim-tree 連携
vim.g.nvim_tree_respect_buf_cwd = 1

project.setup({
    detection_methods = { 'lsp', 'pattern' },
    patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '.sln', '.vim' },
    silent_chdir = true,
})
