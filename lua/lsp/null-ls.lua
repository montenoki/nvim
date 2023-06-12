local null_ls = requirePlugin('null-ls')
if null_ls == nil then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = false,
    sources = {
        -- lua
        formatting.stylua,
        -- Python
        formatting.isort,

        formatting.black.with({ extra_args = { '--fast' } }),
        diagnostics.flake8.with({ extra_args = { '--max-line-length=120', '--ignore=F401,E226,W292,E122,E402' } }),
        diagnostics.markdownlint,
        null_ls.builtins.formatting.shfmt,
        -- rust
        -- formatting.rustfmt,
        -----------------------------------------------------
        -- json
        -- npm install -g fixjson
        -- formatting.fixjson,
        -- toml
        -- cargo install taplo-cli
        -- formatting.taplo,
        -----------------------------------------------------
        -- markdownlint-cli2
        -- diagnostics.markdownlint.with({
        --   prefer_local = "node_modules/.bin",
        --   command = "markdownlint-cli2",
        --   args = { "$FILENAME", "#node_modules" },
        -- }),
        --
        -- code actions ---------------------
        -- code_actions.gitsigns,
        -- code_actions.refactoring,
    },
    -- #{m}: message
    -- #{s}: source name (defaults to null-ls if not specified)
    -- #{c}: code (if available)
    diagnostics_format = '[#{s}] #{m}: #{c}',
    on_attach = function(_)
        vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()']])
        -- if client.resolved_capabilities.document_formatting then
        --   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
        -- end
    end,
})
