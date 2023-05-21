local project = requirePlugin('project_nvim')
if project == nil then
    return
end

-- nvim-tree 連携
vim.g.nvim_tree_respect_buf_cwd = 1

project.setup({
    detection_methods = { 'pattern' },
    patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', '.sln', '.vim' },
})
