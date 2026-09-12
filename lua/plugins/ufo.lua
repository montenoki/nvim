local keymapping = require("keymapping")
return {
    {
        "kevinhwang91/nvim-ufo",
        event = "LazyFile",
        dependencies = { "kevinhwang91/promise-async" },
        init = function()
            -- foldlevel=99 继承 LazyVim 默认值；foldenable 使用 Neovim 默认值。
            -- 新窗口同样保持较大的折叠层级，由 UFO 的映射控制展开和折叠。
            vim.opt.foldcolumn = "1"
            vim.opt.foldlevelstart = 99

            -- 当前 Neovim 已默认声明折叠能力，语言服务器统一由 LazyVim 配置。
        end,
        keys = {
            -- UFO 的接口不会像原生命令那样改变 foldlevel。
            {
                "zR",
                function()
                    require("ufo").openAllFolds()
                end,
                desc = "展开全部折叠",
            },
            {
                "zM",
                function()
                    require("ufo").closeAllFolds()
                end,
                desc = "关闭全部折叠",
            },
            {
                keymapping.ufo.peek,
                function()
                    local winid = require("ufo").peekFoldedLinesUnderCursor()
                    if not winid then
                        vim.lsp.buf.hover()
                    end
                end,
                desc = "预览折叠内容或悬浮文档",
            },
        },
        opts = {
            -- 折叠文本处理
            fold_virt_text_handler = function(
                virtText,
                lnum,
                endLnum,
                width,
                truncate,
                ctx
            )
                if width <= 0 then
                    return {}
                end
                local newVirtText = {}
                -- 使用正在绘制的文件统计总行数，避免分屏时误用当前文件。
                local totalLines = vim.api.nvim_buf_line_count(ctx.bufnr)
                -- 隐藏行数不包含仍显示的折叠首行。
                local foldedLines = endLnum - lnum

                local suffix = ("   %d 行 %d%%"):format(
                    foldedLines,
                    foldedLines / totalLines * 100
                )
                -- 窄窗口先缩短摘要，再按显示宽度截断，保证正文可用宽度非负。
                if vim.fn.strdisplaywidth(suffix) > width then
                    suffix = (" %d 行"):format(foldedLines)
                end
                suffix = truncate(suffix, width)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = math.max(0, width - sufWidth)
                local curWidth = 0

                for _, chunk in ipairs(virtText) do
                    if curWidth >= targetWidth then
                        break
                    end
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

            provider_selector = function(_, filetype, buftype)
                -- 不接管终端、帮助和插件面板等特殊缓冲区；保留 Git 类型的排除。
                if buftype ~= "" or filetype == "git" then
                    return ""
                end
                -- 普通文件优先使用 LSP；来源不可用时尝试 Tree-sitter，不按缩进猜测。
                -- LSP 正常返回空结果时不会回退；两者均不可用时不生成自动折叠。
                return { "lsp", "treesitter" }
            end,
        },
    },
}
