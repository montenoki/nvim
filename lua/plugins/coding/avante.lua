-- 复用 Avante 当前的引用列表；接受聊天动作时传入当前侧栏。
local function mentions()
    local utils = require("avante.utils")
    if vim.bo.filetype == "AvantePromptInput" then
        return utils.get_mentions()
    end
    local items = utils.get_chat_mentions()
    for _, item in ipairs(items) do
        local action = item.callback
        if action then
            -- 聊天引用回调实际接收侧栏，与通用回调的字符串参数类型不同。
            ---@cast action fun(sidebar: avante.Sidebar)
            item.callback = function()
                local sidebar = require("avante").get()
                action(sidebar)
            end
        end
    end
    return items
end

return {
    {
        "avante-corp/avante.nvim",
        -- make 默认下载预编译组件，原生库所需运行环境由 Nix 提供。
        build = vim.fn.has("win32") ~= 0
                and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            or "make",
        event = "VeryLazy",
        version = false, -- 跟随主分支，并由 lazy-lock.json 固定具体提交。
        -- 接管全局入口，局部发送、冲突处理和建议接受键继续由插件管理。
        keys = {
            {
                "<leader>aa",
                function()
                    require("avante.api").ask()
                end,
                mode = { "n", "v" },
                desc = "AI 提问／侧栏",
            },
            {
                "<leader>an",
                function()
                    require("avante.api").ask({ new_chat = true })
                end,
                mode = { "n", "v" },
                desc = "AI 新对话",
            },
            {
                "<leader>ae",
                function()
                    require("avante.api").edit()
                end,
                mode = "v",
                desc = "AI 编辑选区",
            },
            {
                "<leader>ah",
                function()
                    require("avante.api").select_history()
                end,
                desc = "AI 对话历史",
            },
            {
                "<leader>am",
                function()
                    require("avante.api").select_model()
                end,
                desc = "选择 AI 聊天模型",
            },
            {
                "<leader>aS",
                function()
                    require("avante.api").stop()
                end,
                desc = "停止 AI 请求",
            },
            {
                "<leader>ac",
                function()
                    local sidebar = require("avante").get()
                    if
                        not sidebar
                        or not sidebar:is_open()
                        or not sidebar.file_selector:add_current_buffer()
                    then
                        vim.notify(
                            "请先打开 AI 侧栏并选择要添加的文件",
                            vim.log.levels.INFO
                        )
                    end
                end,
                desc = "添加当前文件到 AI 上下文",
            },
            -- A04 尚未进入实施范围，保留已有的全部缓冲区添加入口。
            {
                "<leader>aB",
                function()
                    require("avante.api").add_buffer_files()
                end,
                desc = "添加全部缓冲区到 AI 上下文",
            },
        },
        config = function(_, opts)
            require("config.avante").setup(opts)
        end,
        opts = {
            provider = "openrouter",
            behaviour = { auto_set_keymaps = false, auto_suggestions = false },
            mappings = { select_model = "<leader>am" },
            auto_suggestions_provider = "openrouter_suggestions",
            -- 文件、模型等选择界面及输入框统一使用已有的 Snacks。
            selector = { provider = "snacks" },
            input = { provider = "snacks" },
            providers = {
                openrouter_suggestions = {
                    __inherited_from = "openai",
                    api_key_name = "OPENROUTER_API_KEY",
                    endpoint = "https://openrouter.ai/api/v1",
                    model = "deepseek/deepseek-v4.1-flash",
                    hide_in_model_selector = true,
                    timeout = 30000,
                    extra_request_body = {
                        temperature = 0.2,
                        max_tokens = 1024,
                    },
                },
                openrouter = {
                    __inherited_from = "openai",
                    api_key_name = "OPENROUTER_API_KEY",
                    endpoint = "https://openrouter.ai/api/v1",
                    model = "anthropic/claude-sonnet-4.5",
                    timeout = 120000,
                    extra_request_body = {
                        temperature = 0.75,
                        max_tokens = 20480,
                    },
                },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "folke/snacks.nvim",
            "nvim-tree/nvim-web-devicons",
            {
                "HakonHarnes/img-clip.nvim",
                opts = {
                    default = {
                        verbose = false,
                        prompt_for_file_name = false,
                        drag_and_drop = { insert_mode = true },
                    },
                    -- Avante 的图片存入聊天历史目录，绝对路径只对它生效。
                    -- 普通 Markdown 保持插件默认的相对路径。
                    filetypes = { AvanteInput = { use_absolute_path = true } },
                },
            },
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = { file_types = { "markdown", "Avante" } },
                ft = { "markdown", "Avante" },
            },
        },
    },
    {
        "saghen/blink.cmp",
        dependencies = { "Kaiser-Yang/blink-cmp-avante" },
        opts = {
            sources = {
                -- 只在 Avante 输入框启用，普通代码继续使用原来的补全源。
                per_filetype = {
                    AvanteInput = { "avante", "buffer" },
                    AvantePromptInput = { "avante", "buffer" },
                },
                providers = {
                    avante = {
                        name = "Avante",
                        module = "blink-cmp-avante",
                        opts = {
                            avante = {
                                mention = {
                                    -- 编辑提示框也需要 @ 引用，但不提供聊天侧栏专用动作。
                                    enable = function()
                                        return vim.bo.filetype == "AvanteInput"
                                            or vim.bo.filetype
                                                == "AvantePromptInput"
                                    end,
                                    get_items = mentions,
                                },
                            },
                        },
                    },
                },
            },
        },
    },
}
