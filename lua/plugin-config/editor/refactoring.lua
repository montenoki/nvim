-- TODO
local uConfig = require('uConfig')
local refactoring = requirePlugin('refactoring')

if refactoring == nil or not uConfig.enable.refactoring then
    return
end

refactoring.setup({})

-- Remaps for the refactoring operations currently offered by the plugin
local opt = { noremap = true, silent = true, expr = false }
keymap('v', '<leader>re', [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], opt)
keymap('v', '<leader>rf', [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], opt)
keymap('v', '<leader>rv', [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], opt)
keymap('v', '<leader>ri', [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], opt)

-- Extract block doesn't need visual mode
keymap('n', '<leader>rb', [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], opt)
keymap('n', '<leader>rbf', [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], opt)

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
keymap('n', '<leader>ri', [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], opt)
