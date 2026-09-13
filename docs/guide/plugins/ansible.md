# 编辑并按需运行 Ansible

> 来源：LazyVim Ansible Extra：ansiblels + nvim-ansible。

## 什么时候用

写 Playbook、Role，希望用 Ansible 的字段检查，并在明确准备好后执行任务时使用。

## 怎么用

| 模式 / 场景        | 键位或命令         | 会发生什么                          |
| ------------------ | ------------------ | ----------------------------------- |
| Ansible YAML、普通 | `K` / `<leader>ca` | 查看说明 / 可用代码操作。           |
| Ansible YAML、普通 | `<leader>cd`       | 阅读诊断。                          |
| Ansible YAML、普通 | `<leader>ta`       | 启动插件的 Playbook/Role 运行入口。 |
| 命令               | `:set filetype?`   | 确认识别为 yaml.ansible。           |

## 跟着做一次

先打开 Playbook，用 `:set filetype?` 确认类型，再检查诊断。确实准备运行时才按 `<leader>ta`，按插件提示选择运行方式，并确认使用的 inventory 和环境。

## 在你的配置里

普通 YAML 不一定被识别为 Ansible，所以没有 ta 菜单时先检查 filetype。运行入口会执行 Ansible 工作流，可能修改目标机器；它不是只做语法检查。Ansible、相关 lint 工具和目标环境由你现有系统或项目环境提供。

## 继续查

入口：[Ansible Extra](../../../lazyvim.json)。
相关：[YAML](yaml-json.md)。

[返回卡片目录](../README.md)
