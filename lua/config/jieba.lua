local M = {}

-- 仅在这些正文和代码文件中启用；不接管文件树、终端、帮助等插件窗口。
-- 映射作用于整个文件，中文注释和字符串都能按词编辑。
M.filetypes = {
    "markdown",
    "text",
    "gitcommit",
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
    "vue",
    "svelte",
    "html",
    "css",
    "scss",
    "sql",
    "sh",
    "bash",
    "zsh",
    "fish",
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
    "xml",
    "dockerfile",
    "make",
    "cmake",
}

-- 只为 Surround 的添加操作分流，复制、删除等操作继续调用 Jieba。
function M.operator_textobject(motion)
    if
        vim.v.operator == "g@"
        and vim.o.operatorfunc == "v:lua.MiniSurround.add"
    then
        -- 保留 Surround 发起的操作，只借助 Jieba 确定中文词语范围。
        return '<Cmd>lua require("config.jieba").select_for_surround("'
            .. motion
            .. '")<CR>'
    end
    return "<Plug>(Jieba_" .. motion .. ")"
end

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
