local keymaps = require('keymaps')
return {
    'echasnovski/mini.indentscope',
    cond = vim.g.vscode == nil,
    -- dependencies
    version = '*', -- wait till new 0.7.0 release to put it back on semver
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    opts = {
        symbol = '│',
        options = { try_as_border = true },
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
            -- Textobjects
            object_scope = keymaps.indentscope.obj_scope,
            object_scope_with_border = keymaps.indentscope.obj_scope_with_border,
            -- Motions (jump to respective border line; if not present - body line)
            goto_top = keymaps.indentscope.goto_top,
            goto_bottom = keymaps.indentscope.goto_btm,
        },
    },
    init = function()
        vim.api.nvim_create_autocmd('FileType', {
      -- stylua: ignore
      pattern = {
        'help', 'alpha', 'dashboard', 'nvim-tree', 'Trouble', 'trouble',
        'lazy', 'mason', 'notify', 'toggleterm', 'lazyterm',
      },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
        })
    end,
}
