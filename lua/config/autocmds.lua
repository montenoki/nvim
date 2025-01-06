---@diagnostic disable: undefined-field
-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_del_augroup_by_name("lazyvim_highlight_yank")

local function augroup(name)
    return vim.api.nvim_create_augroup("TEN_" .. name, { clear = true })
end

-- Prevent formatoptions from being overwritten
vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup("preserve_formatoptions"),
    pattern = "*",
    callback = function()
        vim.opt.formatoptions = {
            c = true,
            r = true,
            q = true,
            n = true,
            m = true,
            M = true,
            j = true,
        }
    end,
})

-- Enable text wrapping for text and markdown files
vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup("text_wrap_for_docs"),
    pattern = { "*.txt", "*.md" },
    callback = function()
        vim.opt.formatoptions:append("t")
    end,
})

-- Restore cursor to last editing position when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("restore_cursor_pos"),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if
            vim.tbl_contains(exclude, vim.bo[buf].filetype)
            or vim.b[buf].lazyvim_last_loc
        then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(
                vim.api.nvim_win_set_cursor,
                vim.api.nvim_get_current_win(),
                mark
            )
        end
    end,
})

-- Create parent directories automatically when saving a file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_mkdir"),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'Avante',
    callback = function()
        vim.keymap.set({'n', 'o'}, '<ESC>', '<Nop>', { buffer = true })
    end
})
