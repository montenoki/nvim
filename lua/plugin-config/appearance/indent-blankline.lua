local uConfig = require('uConfig')
local ident_blankline = requirePlugin('indent_blankline')

if ident_blankline == nil or not uConfig.enable.indent_blankline then
    return
end

ident_blankline.setup({
    -- blank line
    space_char_blankline = ' ',
    -- treesitter
    show_current_context = true,
    show_current_context_start = true,
    context_patterns = {
        'class',
        'function',
        'method',
        'element',
        '^if',
        '^while',
        '^for',
        '^object',
        '^table',
        'block',
        'arguments',
    },
    -- :echo &filetype
    filetype_exclude = {
        'null-ls-info',
        'dashboard',
        'packer',
        'terminal',
        'help',
        'log',
        'markdown',
        'TelescopePrompt',
        'lsp-installer',
        'lspinfo',
        'toggleterm',
        'text',
    },
    char = '|',
    -- char = '┆'
    -- char = '│'
    -- char = "⎸",
    -- char = '▏',
})
