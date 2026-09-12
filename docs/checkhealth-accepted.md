# 已接受的 checkhealth 提示

## fzf-lua 图片预览

- **原因：** 缺少 `viu`、`chafa`、`ueberzugpp`。
- **影响：** 对应图片预览不可用，文本搜索正常。
- **跳过：** 图片由 Yazi 和 image.nvim 预览。

## Snacks.image

- **原因与影响：**
  - Foot 使用 Sixel，不支持该插件需要的 Kitty 图形协议。
  - 部分 parser 缺失，对应文档的图片识别不可用。
  - 缺少 `gs`：无法预览 PDF。
  - 缺少 `tectonic/pdflatex`：无法生成公式图片。
  - 缺少 `mmdc`：无法生成 Mermaid 图片。
- **跳过：** 模块已禁用；图片使用 image.nvim，PDF 使用 Yazi。
  暂不需要公式和 Mermaid 图片；latex2text 文本显示不受影响。

## 项目语言工具

- **原因：** devShell 外缺少以下命令：
  - Rust：`rust-analyzer`
  - Ansible：`ansible-language-server`
  - Compose：`docker-compose-langserver`
  - Dockerfile：`docker-langserver`
  - Python：`pyright-langserver`、`ruff`
  - Terraform：`terraform-ls`
- **影响：** 对应语言服务无法启动。
- **跳过：** 由项目 devShell 提供，使用具体项目时再调试。

## GitLab / Helm 类型

- **原因：** yamlls 声明支持 `yaml.gitlab`、`yaml.helm-values`，
  但当前类型表未注册。
- **影响：** 不等于 LSP 失效，普通 `yaml` 仍受支持。
- **跳过：** 保留上游默认配置，有实际需求再调整。

## SQLite 回退

- **原因：** Snacks 无法加载 sqlite3 动态库。
- **影响：** 历史和使用频率改用文件存储。
- **跳过：** Snacks.picker 未启用，无需补库。

## 键位前缀重叠

- **原因：** `gc`、`i`、`a` 与更长映射共用前缀。
- **影响：** 可能等待后续按键，未发现实际操作异常。
- **跳过：** 保留注释和文本对象操作，有异常再查具体键位。

## 配置状态

- **Blink source disabled：** 部分来源动态启用，不代表失效，无需调整。
- **Dressing input 关闭：** 输入框由 Snacks.input 接管，保留现状。
- **Snacks 模块 disabled：** explorer/image/picker/statuscolumn 主动禁用，
  不提供相应功能，当前不需要启用。
- **Snacks select 未启用：** 选择框由 Dressing/Telescope 提供，保留现状。
