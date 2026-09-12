-- 维护中文按词操作的文件类型范围，以及 Jieba 与 mini.surround 的适配。
-- 插件加载、安装和按键注册由 lua/plugins/editor/jieba.lua 负责。
local M = {}

-- 按文件类型筛选，不直接检查窗口性质；常见文件树、终端和帮助类型不在清单中。
-- 声明为 markdown 等受支持类型的预览缓冲区仍可能启用这些映射。
-- 映射作用于整个文件，中文注释和字符串都能按词编辑。
---@type string[]
M.filetypes = {
    -- 正文与提交说明。
    "markdown",
    "text",
    "gitcommit",

    -- 编程语言与脚本。
    "lua",
    "vim",
    "python",
    "rust",
    "go",
    "c",
    "cpp",
    "java",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "sql",

    -- 网页组件、标记与样式。
    "vue",
    "svelte",
    "html",
    "css",
    "scss",
    "xml",

    -- Shell。
    "sh",
    "bash",
    "zsh",
    "fish",

    -- 系统、项目与数据配置。
    "nix",
    "terraform",
    "terraform-vars",
    "hcl",
    "yaml",
    "yaml.ansible",
    "yaml.docker-compose",
    "json",
    "jsonc",
    "toml",

    -- 构建文件。
    "dockerfile",
    "make",
    "cmake",
}

-- 只为 Surround 的添加操作分流，复制、删除等操作继续调用 Jieba。
---@param motion "iw"|"aw" 词内或含周围空白的词语文本对象
---@return string 映射待执行的按键序列
function M.operator_textobject(motion)
    if
        vim.v.operator == "g@"
        and vim.o.operatorfunc == "v:lua.MiniSurround.add"
    then
        -- 保留 Surround 发起的操作，只借助 Jieba 确定中文词语范围。
        return '<Cmd>lua require("config.languages.jieba").select_for_surround("'
            .. motion
            .. '")<CR>'
    end
    return "<Plug>(Jieba_" .. motion .. ")"
end

-- 依赖 JiebaModelOmap 的范围字段和 MiniSurround.add 的操作约定。
-- 升级相关插件后运行 tests/jieba_surround.lua，验证选区、计数和点号重复。
---@param motion "iw"|"aw"
function M.select_for_surround(motion)
    -- 获取词语的起止位置，保留 iw/aw 的计数和空白选择规则。
    local region =
        vim.fn.JiebaModelOmap(motion, vim.fn.getcurpos(), vim.v.count1, "g@")
    -- Vimscript 返回的布尔值可能是字符串，不能直接作为 Lua 条件。
    if tonumber(region.prevent_change) == 1 then
        vim.cmd("normal! " .. vim.keycode("<Esc>"))
        return
    end

    -- 在原操作中建立选区，交回 Surround 处理符号输入及点号重复。
    vim.fn.cursor(region.langle[2], region.langle[3])
    vim.cmd("normal! " .. region.visualmode)
    vim.fn.cursor(region.rangle[2], region.rangle[3])
    -- iw/aw 通常返回含末字符的范围；兼容用户的 selection=exclusive。
    if region.visualmode == "v" then
        if
            region.selection ~= "exclusive"
            and vim.o.selection == "exclusive"
        then
            vim.cmd("normal! l")
        elseif
            region.selection == "exclusive"
            and vim.o.selection ~= "exclusive"
        then
            vim.cmd("normal! h")
        end
    end
end

return M
