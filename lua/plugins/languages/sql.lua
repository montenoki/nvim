return {
    "stevearc/conform.nvim",
    -- 默认使用通用 SQL；数据库连接及方言由具体项目决定。
    opts = { formatters_by_ft = { sql = { "sql_formatter" } } },
}
