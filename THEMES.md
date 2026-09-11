# 主题与运行时状态

主题优先级：TenOS 当前主题 → Neovim 保存的偏好 → `tokyonight-night`。
不存在或无法加载的主题会继续向下回退；最后以内置 `habamax` 兜底。

Neovim 从 `$XDG_STATE_HOME/ten-theme/name` 读取系统主题，未设置
`XDG_STATE_HOME` 时使用 `~/.local/state/ten-theme/name`。
启动时同步，运行中监听文件变化，恢复焦点时补查。
不需要调用 `ten-theme`，也不依赖 NixOS 环境变量。
系统的 `name` 是实际生效的明暗变体，因此无需读取 `appearance.json`。
Nord 和 Retro 82 没有浅色变体时，继续跟随系统实际采用的深色主题。

| TenOS | Neovim 插件 | colorscheme |
| --- | --- | --- |
| tokyo-night | folke/tokyonight.nvim | tokyonight-night |
| tokyo-day | folke/tokyonight.nvim | tokyonight-day |
| kanagawa | rebelot/kanagawa.nvim | kanagawa-wave |
| kanagawa-lotus | rebelot/kanagawa.nvim | kanagawa-lotus |
| catppuccin-mocha | catppuccin/nvim | catppuccin-mocha |
| catppuccin-latte | catppuccin/nvim | catppuccin-latte |
| retro-82 | OldJobobo/retro-82.nvim | retro-82 |
| nord | shaunsingh/nord.nvim | nord |
| gruvbox | sainnhe/gruvbox-material | gruvbox-material |
| gruvbox-light | sainnhe/gruvbox-material | gruvbox-material（background=light） |
| tokyo-day | folke/tokyonight.nvim | tokyonight-day |
| kanagawa-lotus | rebelot/kanagawa.nvim | kanagawa-lotus |
| catppuccin-mocha | catppuccin/nvim | catppuccin-mocha |
| catppuccin-latte | catppuccin/nvim | catppuccin-latte |

`gruvbox-light` 同样使用 `gruvbox-material`，并设置 `background=light`；
其他浅色变体也同步 `background`。系统主题菜单只显示系列，深浅由独立开关控制。

颜色由各插件管理，系统仅提供主题名称。变体或插件版本之间可能存在配色差异。
Gruvbox 使用 Material 色板，对应当前 TenOS 的暖白与柔和蓝绿色。

补充的主题按 Omarchy 的配色风格选择 Neovim 插件，不追求插件来源或版本一致。
原有 Nord、Gruvbox 和 Catppuccin 继续复用。以下主题可以通过
`:colorscheme <名称>` 或主题选择器使用，不改变现有 TenOS 同步映射。

| 配色 | Neovim 插件 | colorscheme |
| --- | --- | --- |
| Ethereal | bjarneo/ethereal.nvim | ethereal |
| Everforest | neanias/everforest-nvim | everforest |
| Flexoki Light | kepano/flexoki-neovim | flexoki-light |
| Hackerman | bjarneo/hackerman.nvim | hackerman |
| Lumon | omacom-io/lumon.nvim | lumon |
| Matte Black | tahayvr/matteblack.nvim | matteblack |
| Miasma | OldJobobo/miasma.nvim | miasma |
| Osaka Jade | ribru17/bamboo.nvim | bamboo |
| Ristretto | loctvl842/monokai-pro.nvim | monokai-pro-ristretto |
| Rosé Pine | rose-pine/neovim | rose-pine-dawn（另有 rose-pine-main、rose-pine-moon） |
| Solitude | ficcdaf/ashen.nvim | ashen |
| Vantablack | bjarneo/vantablack.nvim | vantablack |
| White | bjarneo/white.nvim | white |

仅使用现成主题插件，不在本仓库自行维护颜色主题。
Aether 仅作为 Hackerman 的依赖保留。

参考：[Omarchy 主题目录](https://github.com/omacom/omarchy/tree/quattro/themes)、
[Monokai Pro 配色滤镜](https://github.com/loctvl842/monokai-pro.nvim)。

新增配色的按需加载及正反向切换验证：

```sh
XDG_STATE_HOME="$(mktemp -d)" XDG_CACHE_HOME="$(mktemp -d)" nvim --headless -u NONE -i NONE -l tests/themes_catalog.lua
```

通过 `:colorscheme tokyonight-night` 或 LazyVim 的主题选择器切换，
会保存到 `stdpath("state")/preferences.json`，通常是
`~/.local/state/nvim/preferences.json`。Snacks 选择器预览不会保存，确认后才保存。
可用 `:lua print(require("config.state").path)` 查看实际路径。

系统同步不会覆盖本地偏好。系统状态存在时，手动选择可在当前会话使用；
下次启动或系统主题变化时重新跟随系统。无系统状态时，重启使用本地偏好。
状态是每台机器本地保存的，不随配置仓库同步。

`config.state` 提供 `get(key)` / `set(key, value)`，以 JSON 保存并原子替换文件。
主题保存为 `"theme": { "name": "gruvbox-material", "background": "light" }`，
同时记住主题和明暗。兼容原来的字符串格式，下次手动选择时写入新格式。
手动 `:set background=light` / `dark` 也会保存主题明暗偏好。
底栏八个开关保存为 `toggle.*`：诊断、内联提示、
CodeLens、文本隐藏、拼写检查、空白字符、相对行号、自动格式化。
点击底栏开关后立即保存，启动时恢复。没有保存过的开关保持原有默认值。
窗口选项的已保存偏好应用于普通编辑窗口，包括新窗口和文件类型加载后；
LSP 功能在服务器稍后连接时也遵循当前选择。
仅底栏开关（及对应的 `utils.toggle_*` 调用）保存偏好，普通 `:set` 不会写入状态文件。

NixOS 使用 flake input 引入此仓库，需要更新 `nvim-config` input 并应用配置，
才能部署这些修改。主题插件版本固定在 `lazy-lock.json`。

验证（插件已安装时）：

```sh
XDG_STATE_HOME="$(mktemp -d)" nvim --headless -u NONE -i NONE -l tests/theme.lua
```

Lazy 按需加载与跨进程恢复验证：

```sh
theme_test_dir="$(mktemp -d)"
THEME_TEST_MODE=write XDG_STATE_HOME="$theme_test_dir" nvim --headless -u NONE -i NONE -l tests/theme_lazy.lua
THEME_TEST_MODE=read XDG_STATE_HOME="$theme_test_dir" nvim --headless -u NONE -i NONE -l tests/theme_lazy.lua
THEME_TEST_MODE=light-write XDG_STATE_HOME="$theme_test_dir" nvim --headless -u NONE -i NONE -l tests/theme_lazy.lua
THEME_TEST_MODE=light-read XDG_STATE_HOME="$theme_test_dir" nvim --headless -u NONE -i NONE -l tests/theme_lazy.lua
```

底栏开关的双向切换、跨进程恢复、窗口和 LSP 生命周期验证：

```sh
toggle_test_dir="$(mktemp -d)"
for mode in on restore off restore; do
  TOGGLE_TEST_MODE="$mode" XDG_STATE_HOME="$toggle_test_dir" nvim --headless -u NONE -i NONE -l tests/toggles.lua
done
```
