local utils = require('utils')

local M = {}

local supported = {
    'css',
    'graphql',
    'handlebars',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'jsonc',
    'less',
    'markdown',
    'markdown.mdx',
    'scss',
    'typescript',
    'typescriptreact',
    'vue',
    'yaml',
}

--- Checks if a Prettier config file exists for the given context
function M.has_config(ctx)
    vim.fn.system({ 'prettier', '--find-config-path', ctx.filename })
    return vim.v.shell_error == 0
end

--- Checks if a parser can be inferred for the given context:
--- * If the filetype is in the supported list, return true
--- * Otherwise, check if a parser can be inferred
function M.has_parser(ctx)
    local ft = vim.bo[ctx.buf].filetype --[[@as string]]
    -- default filetypes are always supported
    if vim.tbl_contains(supported, ft) then
        return true
    end
    -- otherwise, check if a parser can be inferred
    local ret = vim.fn.system({ 'prettier', '--file-info', ctx.filename })
    ---@type boolean, string?
    local ok, parser = pcall(function()
        return vim.fn.json_decode(ret).inferredParser
    end)
    return ok and parser and parser ~= vim.NIL
end

M.has_config = utils.memoize(M.has_config)
M.has_parser = utils.memoize(M.has_parser)

return {
    {
        'williamboman/mason.nvim',
        opts = { ensure_installed = { 'prettier' } },
    },

    -- conform
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            for _, ft in ipairs(supported) do
                opts.formatters_by_ft[ft] = { 'prettier' }
            end

            opts.formatters = opts.formatters or {}
            opts.formatters.prettier = {
                condition = function(_, ctx)
                    return M.has_parser(ctx) and (vim.g.lazyvim_prettier_needs_config ~= true or M.has_config(ctx))
                end,
            }
        end,
    },

    -- none-ls support
    {
        'nvimtools/none-ls.nvim',
        optional = true,
        opts = function(_, opts)
            local nls = require('null-ls')
            opts.sources = opts.sources or {}
            table.insert(opts.sources, nls.builtins.formatting.prettier)
        end,
    },
}
