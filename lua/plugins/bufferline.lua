local utils = require('utils')
local icons = require('config').icons

return {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    -- keys = {
    --     { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
    --     { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
    --     { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete Other Buffers' },
    --     { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
    --     { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
    --     { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    --     { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    --     { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    --     { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    --     { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
    --     { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    -- },
    opts = {
        options = {
            mode = 'tabs',
                -- stylua: ignore
                -- TODO: refactor
                close_command = function(n) utils.bufremove(n) end,
                -- stylua: ignore
                right_mouse_command = function(n) utils.bufremove(n) end,
            left_trunc_marker = '',
            right_trunc_marker = '',
            get_element_icon = function(opts)
                return icons.ft[opts.filetype] or ''
            end,
            always_show_bufferline = false,
            -- indicator = {
            --     icon = '||', -- this should be omitted if indicator style is not 'icon'
            --     style = 'icon',
            -- },
            offsets = {
                {
                    filetype = 'NvimTree',
                    text = 'File Explorer',
                    highlight = 'Directory',
                    text_align = 'left',
                },
                -- {
                --     filetype = 'dapui_scopes',
                --     text = 'Debug Mode',
                --     highlight = 'Directory',
                --     text_align = 'left',
                -- },
                -- {
                --     filetype = 'Outline',
                --     text = 'Outline',
                --     highlight = 'Directory',
                --     text_align = 'left',
                -- },
            },
            diagnostics = false,
        },
    },
    config = function(_, opts)
        local bufferline = require('bufferline')
        opts.options.style_preset = {
            bufferline.style_preset.no_italic,
        }

        bufferline.setup(opts)
        -- Fix bufferline when restoring a session
        vim.api.nvim_create_autocmd('BufAdd', {
            group = vim.api.nvim_create_augroup('reload_bufferline', { clear = true }),
            callback = function()
                vim.schedule(function()
                    pcall(nvim_bufferline)
                end)
            end,
        })
    end,
}
