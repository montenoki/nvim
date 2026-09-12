# 升级兼容性检查

只保留依赖上游行为的适配检查，不为普通选项、配色清单、界面布局逐项写断言。
测试使用本机已安装的插件，不验证真实 AI 回复或整个编辑器的所有功能。

| 测试 | 更新哪些插件后运行 | 保护的行为 |
| --- | --- | --- |
| `jieba_surround.lua` | jieba.vim、mini.surround、Leap | 中文 `iw/aw` 的范围、重复操作、操作符接线 |
| `ufo_provider.lua` | nvim-ufo、promise-async | LSP → Tree-sitter → 空结果；真实错误继续报出，真实 UFO 无解析器时正常返回 |
| `avante_completion.lua` | Avante、blink-cmp-avante、Blink | 原生模块能加载，候选接口和侧栏动作回调仍兼容 |
| `luasnip_nesting.lua` | LuaSnip、Blink | 嵌套片段前后跳转，并返回外层填写位置 |

在仓库根目录运行。下面使用现有 `nvim-test` 插件目录；后两项还要求
`~/.config/nvim-test` 指向本仓库。测试状态和缓存使用临时目录。
后两项启动完整配置，沿用其插件加载策略，运行前应已安装所需插件。

```sh
NVIM_TEST_PLUGIN_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/nvim-test/lazy"
export NVIM_TEST_PLUGIN_ROOT

for test in jieba_surround ufo_provider; do
    test_tmp=$(mktemp -d)
    XDG_DATA_HOME="$test_tmp/data" XDG_STATE_HOME="$test_tmp/state" \
        XDG_CACHE_HOME="$test_tmp/cache" \
        nvim --headless -u NONE -i NONE -l "tests/$test.lua" || break
done

for test in avante_completion luasnip_nesting; do
    test_tmp=$(mktemp -d)
    NVIM_APPNAME=nvim-test XDG_STATE_HOME="$test_tmp/state" \
        XDG_CACHE_HOME="$test_tmp/cache" NVIM_TEST_FILE="tests/$test.lua" \
        nvim --headless -i NONE \
        '+lua local ok, err = xpcall(function() dofile(vim.env.NVIM_TEST_FILE) end, debug.traceback); if not ok then print(err); vim.cmd("cquit") end' || break
done
```

缺少插件或 Avante 原生库会直接失败，应先修复依赖再重跑；不将缺依赖视作通过。
