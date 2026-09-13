# 编辑 Dockerfile 和 Compose

> 来源：LazyVim Docker Extra + 本地 Compose 文件名识别。

## 什么时候用

编写镜像构建步骤或容器编排配置，希望查语法、字段和常见问题时使用。

## 怎么用

| 模式 / 场景              | 键位或命令                  | 会发生什么                                           |
| ------------------------ | --------------------------- | ---------------------------------------------------- |
| Dockerfile/Compose、普通 | `K`                         | 查看服务器能提供的说明。                             |
| 普通                     | `<leader>ca`                | 查看可用代码操作。                                   |
| 普通                     | `<leader>cd` / `<leader>xX` | 查看诊断。                                           |
| 命令                     | `:set filetype?`            | 确认文件类型，Compose 应识别为 yaml.docker-compose。 |
| 命令                     | `:checkhealth vim.lsp`      | 检查 Docker/Compose 服务。                           |

## 跟着做一次

打开 `compose.yaml`，先确认 filetype 是 `yaml.docker-compose`。在服务字段处试补全，写完后阅读诊断；实际启动容器仍在终端按项目的 Docker/Compose 流程进行。

## 在你的配置里

`docker-compose.yml`、`docker-compose.yaml`、`compose.yml`、`compose.yaml` 四个名字已显式识别。Dockerfile、Compose 使用不同服务器；编辑支持不代表 Docker daemon 已运行，也不会自动构建镜像或启动服务。

## 继续查

配置：[文件类型入口](../../../init.lua)、[语言 Extras](../../../lazyvim.json)。

[返回卡片目录](../README.md)
