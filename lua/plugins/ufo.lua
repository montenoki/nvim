local keymapping = require("keymapping")
return {
    {
        "luukvbaal/statuscol.nvim",
        opts = function()
            local builtin = require("statuscol.builtin")
            return {
                relculright = true,
                segments = {
                    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                    { text = { "%s" }, click = "v:lua.ScSa" },
                    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                },
            }
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        event = "LazyFile",
        dependencies = { "kevinhwang91/promise-async" },
        init = function()
            vim.opt.foldcolumn = "1"
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
            vim.opt.foldenable = true

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange =
                { dynamicRegistration = false, lineFoldingOnly = true }
            local language_servers =
                require("lspconfig").util._available_servers() -- or list servers manually like {'gopls', 'clangd'}
            for _, ls in ipairs(language_servers) do
                require("lspconfig")[ls].setup({ capabilities = capabilities })
            end
        end,
        keys = {
            {
                keymapping.ufo.peek,
                function()
                    local winid = require("ufo").peekFoldedLinesUnderCursor()
                    if not winid then
                        vim.lsp.buf.hover()
                    end
                end,
                desc = "Peek Folded Lines",
            },
        },
        opts = {
            -- 折叠文本处理
            fold_virt_text_handler = function(
                virtText,
                lnum,
                endLnum,
                width,
                truncate
            )
                local newVirtText = {}
                -- 计算折叠行数和总行数
                local totalLines = vim.api.nvim_buf_line_count(0)
                local foldedLines = endLnum - lnum

                local suffix = ("   %d lines %d%%"):format(
                    foldedLines,
                    foldedLines / totalLines * 100
                )
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0

                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix
                                .. (" "):rep(
                                    targetWidth - curWidth - chunkWidth
                                )
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end,

            open_fold_hl_timeout = 150,

            close_fold_kinds_for_ft = {
                default = { "imports", "comment" },
            },

            preview = {
                win_config = {
                    border = { "", "─", "", "", "", "─", "", "" },
                    winhighlight = "Normal:Folded",
                    winblend = 0,
                },
                mappings = {
                    scrollU = keymapping.float_window.scroll_up,
                    scrollD = keymapping.float_window.scroll_down,
                },
            },

            provider_selector = function(_, filetype, _)
                local ftMap = {
                    lua = "treesitter",
                    python = { "treesitter", "indent" },
                    git = "",
                }
                return ftMap[filetype]
            end,
        },
    },
}
