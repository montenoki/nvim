# checkhealth 原始报告：deployed

采集日期：2026-09-12。终端 UI 启动后采集；扩展发现所有已启用插件的 health 模块。

```text

==============================================================================
avante:                                                                     ✅

avante.nvim ~
- ✅ OK Found required plugin: nvim-lua/plenary.nvim
- ✅ OK Found required plugin: MunifTanjim/nui.nvim
- ✅ OK Found icons plugin (nvim-web-devicons or mini.icons)
- ✅ OK Using native input provider (no additional dependencies required)

TreeSitter Dependencies ~
- ✅ OK All essential TreeSitter parsers are installed
- ✅ OK TreeSitter highlighter is available

==============================================================================
blink.cmp:                                                                1 ⚠️

System ~
- ✅ OK curl is installed
- ✅ OK git is installed
- ✅ OK Your system is supported by pre-built binaries (x86_64-unknown-linux-gnu)
- ✅ OK blink_cmp_fuzzy lib is downloaded/built

Sources ~
- ⚠️ WARNING Some providers may show up as "disabled" but are enabled dynamically (e.g. cmdline)

Default sources ~
- lsp (blink.cmp.sources.lsp)
- path (blink.cmp.sources.path)
- snippets (blink.cmp.sources.snippets)
- buffer (blink.cmp.sources.buffer)

Cmdline sources ~
- buffer (blink.cmp.sources.buffer)
- cmdline (blink.cmp.sources.cmdline)

Disabled sources ~
- omni (blink.cmp.sources.complete_func)

==============================================================================
conform:                                                                    ✅

conform.nvim report ~
- Log file: /home/ten/.local/state/nvim/conform.log

==============================================================================
copilot:                                                                  1 ❌

{copilot.lua} ~
- {copilot.lua} GitHub Copilot plugin for Neovim

Copilot Dependencies ~
- ✅ OK `node` found: v24.19.0

Copilot Authentication ~
- No environment token set (`GITHUB_COPILOT_TOKEN` or `GH_COPILOT_TOKEN`)
- No local credentials found
- Expected location: `/home/ten/.config/github-copilot/auth.db`
- Run `:Copilot auth` to authenticate
- ❌ ERROR Copilot LSP client not available
- Check that the plugin is properly loaded and configured
- Or restart Neovim if the plugin was just installed

==============================================================================
crates:                                                                     ✅

- skipping health check, setup hasn't been called

==============================================================================
dressing:                                                                   ✅

dressing.nvim ~
- ✅ OK vim.ui.input active
- ✅ OK vim.ui.select active: telescope

==============================================================================
fzf_lua:                                                                  4 ⚠️

fzf-lua [required] ~
- ✅ OK 'fzf' `0.72.0 (refs/tags/v0.72.0)`
- ✅ OK 'git' `git version 2.54.0`
- ✅ OK 'rg' `ripgrep 15.2.0 (rev e89fff89ac)`
- ✅ OK 'fd' `fd 10.4.2`

fzf-lua [optional] ~
- ⚠️ WARNING `nvim-web-devicons` or `mini.icons` not found
- ✅ OK 'rg' `ripgrep 15.2.0 (rev e89fff89ac)`
- ✅ OK 'fd' `fd 10.4.2`
- ✅ OK 'bat' `bat 0.26.1`
- ✅ OK 'delta' `delta 0.19.2`

fzf-lua [optional:media] ~
- ⚠️ WARNING 'viu' not found
- ⚠️ WARNING 'chafa' not found
- ⚠️ WARNING 'ueberzugpp' not found

fzf-lua [env] ~
- ✅ OK `FZF_DEFAULT_OPTS` is not set
- ✅ OK `FZF_DEFAULT_OPTS_FILE` is not set

==============================================================================
grug-far:                                                                 1 ⚠️

Checking external dependencies ~
- ✅ OK rg: found ripgrep 15.2.0 (rev e89fff89ac)
- ⚠️ WARNING ast-grep: not found. Install [ast-grep](https://ast-grep.github.io) for extended capabilities

==============================================================================
img-clip:                                                                   ✅

img-clip.nvim ~
- ✅ OK `wl-clipboard` is installed

==============================================================================
lazy:                                                                     1 ⚠️

lazy.nvim ~
- {lazy.nvim} version `11.17.5`
- ✅ OK {git} `version 2.54.0`
- ⚠️ WARNING found existing packages at `/home/ten/.local/share/nvim/site/pack/core`
- ✅ OK packer_compiled.lua not found

luarocks ~
- ✅ OK luarocks disabled

==============================================================================
lazyvim:                                                                    ✅

LazyVim ~
- ✅ OK Using Neovim >= 0.11.2
- ✅ OK `git` is installed
- ✅ OK `rg` is installed
- ✅ OK `fd` is installed
- ✅ OK `lazygit` is installed
- ✅ OK `fzf` is installed
- ✅ OK `curl` is installed

LazyVim nvim-treesitter ~
- ✅ OK `C compiler` is installed
- ✅ OK `curl` is installed
- ✅ OK `tar` is installed
- ✅ OK `tree-sitter (CLI)` is installed

==============================================================================
lspconfig:                                                                  ✅

- Skipped. This healthcheck is redundant with `:checkhealth vim.lsp`.

==============================================================================
neo-tree:                                                                 1 ⚠️

Required dependencies ~
- ✅ OK nvim-lua/plenary.nvim is installed
- ✅ OK MunifTanjim/nui.nvim is installed

Optional icons ~
- ✅ OK nvim-tree/nvim-web-devicons is installed

Optional preview image support (only need one): ~
- ✅ OK folke/snacks.nvim is installed
- 3rd/image.nvim is not installed

Optional LSP integration for commands (like copy/delete/move/etc.) ~
- Crysthamus/nvim-file-operations is not installed
- antosha417/nvim-lsp-file-operations is not installed

Optional window picker (for _with_window_picker commands) ~
- ✅ OK s1n7ax/nvim-window-picker is installed

Configuration ~
- ✅ OK Configuration conforms to the neotree.Config.Base schema

Trash executables (prioritized in descending order, `:h neo-tree-trash`) ~
- ⚠️ WARNING `gio` not found (from glib2)
- (Neo-tree will fall back to its own implementation of the XDG freedesktop trash spec, as needed)

==============================================================================
noice:                                                                      ✅

noice.nvim ~
- ✅ OK *Neovim* >= 0.9.0
- ✅ OK You're using a GUI that should work ok
- ✅ OK *vim.go.lazyredraw* is not enabled
- ✅ OK `snacks.nvim` is installed
- ✅ OK {TreeSitter} `vim` parser is installed
- ✅ OK {TreeSitter} `regex` parser is installed
- ✅ OK {TreeSitter} `lua` parser is installed
- ✅ OK {TreeSitter} `bash` parser is installed
- ✅ OK {TreeSitter} `markdown` parser is installed
- ✅ OK {TreeSitter} `markdown_inline` parser is installed
- ✅ OK `vim.notify` is set to **Noice**
- ✅ OK `vim.lsp.buf.hover` is set to **Noice**
- ✅ OK `vim.lsp.buf.signature_help` is set to **Noice**
- ✅ OK `vim.lsp.util.convert_input_to_markdown_lines` is set to **Noice**
- ✅ OK `vim.lsp.util.stylize_markdown` is set to **Noice**

==============================================================================
nvim-treesitter:                                                            ✅

Requirements ~
- ✅ OK Neovim was compiled with tree-sitter runtime ABI version 15 (required >=13).
- ✅ OK tree-sitter-cli 0.26.8 (/nix/store/fs8rilp9lhm67v5z40mnrx9zzxdb7dqx-tree-sitter-0.26.8/bin/tree-sitter)
- ✅ OK tar 1.35.0 (/run/current-system/sw/bin/tar)
- ✅ OK curl 8.21.0 (/run/current-system/sw/bin/curl)
  curl 8.21.0 (x86_64-pc-linux-gnu) libcurl/8.21.0 OpenSSL/3.6.3 zlib/1.3.2 brotli/1.2.0 zstd/1.5.7 libidn2/2.3.8 libpsl/0.21.5 libssh2/1.11.1 nghttp2/1.69.0 ngtcp2/1.22.1 nghttp3/1.15.0 mit-krb5/1.22.2
  Release-Date: 2026-06-24
  Protocols: dict file ftp ftps gopher gophers http https imap imaps ipfs ipns mqtt mqtts pop3 pop3s rtsp scp sftp smtp smtps telnet tftp
  Features: alt-svc AsynchDNS brotli GSS-API HSTS HTTP2 HTTP3 HTTPS-proxy IDN IPv6 Kerberos Largefile libz PSL SPNEGO SSL threadsafe TLS-SRP UnixSockets zstd

OS Info ~
- machine: x86_64
- version: #1-NixOS SMP PREEMPT_DYNAMIC Thu Aug 27 12:35:27 UTC 2026
- sysname: Linux
- release: 7.2.1

Install directory for parsers and queries ~
- /home/ten/.local/share/nvim/site
- ✅ OK is writable.
- ✅ OK is in runtimepath.

Installed languages     H L F I J ~

  Legend: [H]ighlights, [L]ocals, [F]olds, [I]ndents, In[J]ections ~

==============================================================================
opencode:                                                                 1 ❌

opencode.nvim ~
- OS: Linux 7.2.1 (x86_64)
- `nvim` version: `0.12.4`
- opencode.nvim git commit hash: `41622312d5d8fb074699c1d5d96f089286191376`
- `vim.g.opencode_opts`: {}

opencode.nvim [binaries] ~
- ❌ ERROR `opencode` executable not found in `$PATH`.
  - ADVICE:
    - Install `opencode` and ensure it's in your `$PATH`.
- ✅ OK `curl` available.
- ✅ OK `pgrep` available.
- ✅ OK `lsof` available.

opencode.nvim [snacks] ~
- ✅ OK snacks.input enabled: `ask()` enhanced.
- ✅ OK snacks.picker enabled: `select()` enhanced.

==============================================================================
render-markdown:                                                    3 ⚠️  1 ❌

render-markdown.nvim [versions] ~
- ✅ OK neovim >= 0.11
- ✅ OK tree-sitter ABI: 15
- ✅ OK plugin: 8.13.1

render-markdown.nvim [configuration] ~
- ✅ OK valid

render-markdown.nvim [tree-sitter markdown] ~
- ✅ OK parser: installed
- ✅ OK ABI: 15
- ✅ OK highlights: /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/markdown/highlights.scm
- ✅ OK highlighter: enabled

render-markdown.nvim [tree-sitter markdown_inline] ~
- ✅ OK parser: installed
- ✅ OK ABI: 15
- ✅ OK highlights: /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/markdown_inline/highlights.scm

render-markdown.nvim [tree-sitter html] ~
- ✅ OK parser: installed
- ✅ OK ABI: 14

render-markdown.nvim [tree-sitter latex] ~
- ⚠️ WARNING parser: not installed
  - ADVICE:
    - disable latex support to avoid this warning
      require("render-markdown").setup({
          latex = { enabled = false },
      })
- ⚠️ WARNING ABI: unknown
  - ADVICE:
    - disable latex support to avoid this warning
      require("render-markdown").setup({
          latex = { enabled = false },
      })

render-markdown.nvim [tree-sitter yaml] ~
- ✅ OK parser: installed
- ✅ OK ABI: 15

render-markdown.nvim [icons] ~
- ✅ OK using: nvim-web-devicons

render-markdown.nvim [latex] ~
- ⚠️ WARNING none installed: { "utftex", "latex2text" }
  - ADVICE:
    - disable latex support to avoid this warning
      require("render-markdown").setup({
          latex = { enabled = false },
      })

render-markdown.nvim [conflicts] ~
- ✅ OK headlines: not installed
- ✅ OK markview: not installed
- ❌ ERROR Failed to run healthcheck for "render-markdown" plugin. Exception:
  ...ocal/share/nvim/lazy/obsidian.nvim/lua/obsidian/init.lua:49: Obsidian client has not been set! Did you forget to call 'setup()'?


==============================================================================
rustaceanvim:                                                             1 ❌

Checking for Lua dependencies ~
- ✅ OK optional dependency nvim-dap not installed. Needed for debugging features [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)

Checking external dependencies ~
- ❌ ERROR rust-analyzer: not found: Could not find an executable binary.
  rustaceanvim requires [rust-analyzer](https://rust-analyzer.github.io/).
  Required by the LSP client.

- ✅ OK Cargo: found cargo 1.95.0 (f2d3ce0bd 2026-03-21)
- ✅ OK rustc: found rustc 1.95.0 (59807616e 2026-04-14) (built from a source tarball)

Checking config ~
- ✅ OK No errors found in config.

Checking for conflicting plugins ~
- ✅ OK No conflicting plugins detected.

Checking for tree-sitter parser ~
- ✅ OK tree-sitter parser for Rust detected.

==============================================================================
snacks:                                                            10 ⚠️ 10 ❌

Snacks ~
- ✅ OK setup called

Snacks.bigfile ~
- ✅ OK setup {enabled}

Snacks.dashboard ~
- ✅ OK setup {enabled}
- ✅ OK setup ran
- ✅ OK dashboard opened

Snacks.explorer ~
- ⚠️ WARNING setup {disabled}
- ❌ ERROR None of the tools found: 'trash', 'gio', 'kioclient5', 'kioclient'
- ⚠️ WARNING No system trash command found; deleting files will be permanent

Snacks.image ~
- ⚠️ WARNING setup {disabled}
- ❌ ERROR None of the tools found: 'kitty', 'wezterm', 'ghostty'
- ❌ ERROR None of the tools found: 'magick', 'convert'
- ❌ ERROR `magick` is required to convert images. Only PNG files will be displayed.
- ✅ OK Terminal Dimensions:
  - {size}: `0` x `0` pixels
  - {scale}: `1.00`
  - {cell}: `0` x `0` pixels
- ✅ OK Available Treesitter languages:
    `html`, `javascript`, `markdown_inline`, `markdown`, `tsx`
- ⚠️ WARNING Missing Treesitter languages:
    `css`, `latex`, `norg`, `scss`, `svelte`, `typst`, `vue`
- ⚠️ WARNING Image rendering in docs with missing treesitter parsers won't work
- ❌ ERROR Tool not found: 'gs'
- ⚠️ WARNING `gs` is required to render PDF files
- ❌ ERROR None of the tools found: 'tectonic', 'pdflatex'
- ⚠️ WARNING `tectonic` or `pdflatex` is required to render LaTeX math expressions
- ❌ ERROR Tool not found: 'mmdc'
- ⚠️ WARNING `mmdc` is required to render Mermaid diagrams
- ❌ ERROR your terminal does not support the kitty graphics protocol
- supported terminals: `kitty`, `wezterm`, `ghostty`

Snacks.input ~
- ✅ OK setup {enabled}
- ❌ ERROR `vim.ui.input` is not set to `Snacks.input`

Snacks.lazygit ~
- ✅ OK {lazygit} installed

Snacks.notifier ~
- ✅ OK setup {enabled}
- ✅ OK is ready

Snacks.picker ~
- ✅ OK setup {enabled}
- ❌ ERROR `vim.ui.select` is not set to `Snacks.picker.select`
- ✅ OK Available Treesitter languages:
    `regex`
- ✅ OK 'git' `git version 2.54.0`
- ✅ OK 'rg' `ripgrep 15.2.0 (rev e89fff89ac)`
- ✅ OK `Snacks.picker.grep()` is available
- ✅ OK 'fd' `fd 10.4.2`
- ✅ OK `Snacks.picker.files()` is available
- ✅ OK `Snacks.picker.explorer()` is available
- ⚠️ WARNING `SQLite3` is not available. Frecency and history will be stored in a file instead.

Snacks.quickfile ~
- ✅ OK setup {enabled}

Snacks.scope ~
- ✅ OK setup {enabled}

Snacks.scroll ~
- ✅ OK setup {enabled}

Snacks.statuscolumn ~
- ⚠️ WARNING setup {disabled}

Snacks.terminal ~
- ✅ OK shell configured
  - `vim.o.shell`: /run/current-system/sw/bin/zsh
  - `parsed`: { "/run/current-system/sw/bin/zsh" }

Snacks.toggle ~
- ✅ OK {which-key} is installed

Snacks.words ~
- ✅ OK setup {enabled}

==============================================================================
telescope:                                                                  ✅

Checking for required plugins ~
- ✅ OK plenary installed.

Checking external dependencies ~
- ✅ OK rg: found ripgrep 15.2.0 (rev e89fff89ac)
- ✅ OK fd: found fd 10.4.2

===== Installed extensions ===== ~

==============================================================================
venv-selector:                                                              ✅

venv-selector ~
- ✅ OK Settings are correct

==============================================================================
vim.deprecated:                                                             ✅

- ✅ OK No deprecated functions detected

==============================================================================
vim.health:                                                               1 ⚠️

System Info ~
- ⚠️ WARNING Nvim 0.12.5 is available (current: 0.12.4)
- Nvim version: `v0.12.4`
- Operating system: Linux 7.2.1
- Terminal: unknown
- $TERM: foot

Configuration ~
- ✅ OK no issues found

Runtime ~
- ✅ OK $VIMRUNTIME: /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime

Performance ~
- ✅ OK Build type: Release

Remote Plugins ~
- ✅ OK Up to date

Terminal ~
- key_backspace (kbs) terminfo entry: `key_backspace=\177`
- key_dc (kdch1) terminfo entry: `key_dc=\E[3~`
- $COLORTERM="truecolor"

External Tools ~
- ✅ OK ripgrep 15.2.0 (rev e89fff89ac) (/home/ten/.codex/packages/standalone/releases/0.153.4-x86_64-unknown-linux-musl/codex-path/rg)
- ✅ OK vim.ui.open: handler found (xdg-open)
- ✅ OK git version 2.54.0 (/etc/profiles/per-user/ten/bin/git)
- ✅ OK curl 8.21.0 (/run/current-system/sw/bin/curl)
  curl 8.21.0 (x86_64-pc-linux-gnu) libcurl/8.21.0 OpenSSL/3.6.3 zlib/1.3.2 brotli/1.2.0 zstd/1.5.7 libidn2/2.3.8 libpsl/0.21.5 libssh2/1.11.1 nghttp2/1.69.0 ngtcp2/1.22.1 nghttp3/1.15.0 mit-krb5/1.22.2
  Release-Date: 2026-06-24
  Protocols: dict file ftp ftps gopher gophers http https imap imaps ipfs ipns mqtt mqtts pop3 pop3s rtsp scp sftp smtp smtps telnet tftp
  Features: alt-svc AsynchDNS brotli GSS-API HSTS HTTP2 HTTP3 HTTPS-proxy IDN IPv6 Kerberos Largefile libz PSL SPNEGO SSL threadsafe TLS-SRP UnixSockets zstd

==============================================================================
vim.lsp:                                                                 10 ⚠️

- LSP log level : WARN
- Log path: /home/ten/.local/state/nvim/lsp.log
- Log size: 1 KB

vim.lsp: Active Features ~
- codelens
  - Active buffers:


vim.lsp: Active Clients ~
- No active clients

vim.lsp: Enabled Configurations ~
- ⚠️ WARNING 'ansible-language-server' is not executable. Configuration will not be used.
- ansiblels:
  - capabilities: {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true
        }
      }
    }
  - cmd: { "ansible-language-server", "--stdio" }
  - filetypes: yaml.ansible
  - keys: { { "<leader>cl", <function 1>,
        desc = "Lsp Info",
        mode = "n"
      }, { "gd", <function 2>,
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", <function 3>,
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", <function 4>,
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", <function 5>,
        desc = "Goto T[y]pe Definition",
        mode = "n"
      }, { "gD", <function 6>,
        desc = "Goto Declaration",
        mode = "n"
      }, { "K", <function 7>,
        desc = "Hover",
        mode = "n"
      }, { "gK", <function 8>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "n"
      }, { "<c-k>", <function 9>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "i"
      }, { "<leader>ca", <function 10>,
        desc = "Code Action",
        has = "codeAction",
        mode = { "n", "x" }
      }, { "<leader>cc", <function 11>,
        desc = "Run Codelens",
        has = "codeLens",
        mode = { "n", "x" }
      }, { "<leader>cC", <function 12>,
        desc = "Refresh & Display Codelens",
        has = "codeLens",
        mode = { "n" }
      }, { "<leader>cR", <function 13>,
        desc = "Rename File",
        has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
        mode = { "n" }
      }, { "<leader>cr", <function 14>,
        desc = "Rename",
        has = "rename",
        mode = "n"
      }, { "<leader>cA", <function 15>,
        desc = "Source Action",
        has = "codeAction",
        mode = "n"
      }, { "]]", <function 16>,
        desc = "Next Reference",
        enabled = <function 17>,
        has = "documentHighlight",
        mode = "n"
      }, { "[[", <function 18>,
        desc = "Prev Reference",
        enabled = <function 19>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-n>", <function 20>,
        desc = "Next Reference",
        enabled = <function 21>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-p>", <function 22>,
        desc = "Prev Reference",
        enabled = <function 23>,
        has = "documentHighlight",
        mode = "n"
      }, { "<leader>co", <function 24>,
        desc = "Organize Imports",
        enabled = <function 25>,
        has = "codeAction",
        mode = "n"
      }, { "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>",
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>",
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>",
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>",
        desc = "Goto T[y]pe Definition",
        mode = "n"
      } }
  - root_markers: { "ansible.cfg", ".ansible-lint" }
  - settings: {
      ansible = {
        ansible = {
          path = "ansible"
        },
        executionEnvironment = {
          enabled = false
        },
        python = {
          interpreterPath = "python"
        },
        validation = {
          enabled = true,
          lint = {
            enabled = true,
            path = "ansible-lint"
          }
        }
      }
    }

- bashls:
  - capabilities: {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true
        }
      }
    }
  - cmd: { "bash-language-server", "start" }
  - filetypes: bash, sh
  - keys: { { "<leader>cl", <function 1>,
        desc = "Lsp Info",
        mode = "n"
      }, { "gd", <function 2>,
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", <function 3>,
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", <function 4>,
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", <function 5>,
        desc = "Goto T[y]pe Definition",
        mode = "n"
      }, { "gD", <function 6>,
        desc = "Goto Declaration",
        mode = "n"
      }, { "K", <function 7>,
        desc = "Hover",
        mode = "n"
      }, { "gK", <function 8>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "n"
      }, { "<c-k>", <function 9>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "i"
      }, { "<leader>ca", <function 10>,
        desc = "Code Action",
        has = "codeAction",
        mode = { "n", "x" }
      }, { "<leader>cc", <function 11>,
        desc = "Run Codelens",
        has = "codeLens",
        mode = { "n", "x" }
      }, { "<leader>cC", <function 12>,
        desc = "Refresh & Display Codelens",
        has = "codeLens",
        mode = { "n" }
      }, { "<leader>cR", <function 13>,
        desc = "Rename File",
        has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
        mode = { "n" }
      }, { "<leader>cr", <function 14>,
        desc = "Rename",
        has = "rename",
        mode = "n"
      }, { "<leader>cA", <function 15>,
        desc = "Source Action",
        has = "codeAction",
        mode = "n"
      }, { "]]", <function 16>,
        desc = "Next Reference",
        enabled = <function 17>,
        has = "documentHighlight",
        mode = "n"
      }, { "[[", <function 18>,
        desc = "Prev Reference",
        enabled = <function 19>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-n>", <function 20>,
        desc = "Next Reference",
        enabled = <function 21>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-p>", <function 22>,
        desc = "Prev Reference",
        enabled = <function 23>,
        has = "documentHighlight",
        mode = "n"
      }, { "<leader>co", <function 24>,
        desc = "Organize Imports",
        enabled = <function 25>,
        has = "codeAction",
        mode = "n"
      }, { "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>",
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>",
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>",
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>",
        desc = "Goto T[y]pe Definition",
        mode = "n"
      } }
  - root_markers: { ".git" }
  - settings: {
      bashIde = {
        globPattern = "*@(.sh|.inc|.bash|.command)"
      },
      filetypes = { "sh", "zsh" }
    }

- ⚠️ WARNING 'docker-compose-langserver' is not executable. Configuration will not be used.
- ⚠️ WARNING Unknown filetype 'yaml.docker-compose' (Hint: filename extension != filetype).
- docker_compose_language_service:
  - capabilities: {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true
        }
      }
    }
  - cmd: { "docker-compose-langserver", "--stdio" }
  - filetypes: yaml.docker-compose
  - keys: { { "<leader>cl", <function 1>,
        desc = "Lsp Info",
        mode = "n"
      }, { "gd", <function 2>,
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", <function 3>,
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", <function 4>,
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", <function 5>,
        desc = "Goto T[y]pe Definition",
        mode = "n"
      }, { "gD", <function 6>,
        desc = "Goto Declaration",
        mode = "n"
      }, { "K", <function 7>,
        desc = "Hover",
        mode = "n"
      }, { "gK", <function 8>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "n"
      }, { "<c-k>", <function 9>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "i"
      }, { "<leader>ca", <function 10>,
        desc = "Code Action",
        has = "codeAction",
        mode = { "n", "x" }
      }, { "<leader>cc", <function 11>,
        desc = "Run Codelens",
        has = "codeLens",
        mode = { "n", "x" }
      }, { "<leader>cC", <function 12>,
        desc = "Refresh & Display Codelens",
        has = "codeLens",
        mode = { "n" }
      }, { "<leader>cR", <function 13>,
        desc = "Rename File",
        has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
        mode = { "n" }
      }, { "<leader>cr", <function 14>,
        desc = "Rename",
        has = "rename",
        mode = "n"
      }, { "<leader>cA", <function 15>,
        desc = "Source Action",
        has = "codeAction",
        mode = "n"
      }, { "]]", <function 16>,
        desc = "Next Reference",
        enabled = <function 17>,
        has = "documentHighlight",
        mode = "n"
      }, { "[[", <function 18>,
        desc = "Prev Reference",
        enabled = <function 19>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-n>", <function 20>,
        desc = "Next Reference",
        enabled = <function 21>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-p>", <function 22>,
        desc = "Prev Reference",
        enabled = <function 23>,
        has = "documentHighlight",
        mode = "n"
      }, { "<leader>co", <function 24>,
        desc = "Organize Imports",
        enabled = <function 25>,
        has = "codeAction",
        mode = "n"
      }, { "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>",
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>",
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>",
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>",
        desc = "Goto T[y]pe Definition",
        mode = "n"
      } }
  - root_markers: { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" }

- ⚠️ WARNING 'docker-langserver' is not executable. Configuration will not be used.
- dockerls:
  - capabilities: {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true
        }
      }
    }
  - cmd: { "docker-langserver", "--stdio" }
  - filetypes: dockerfile
  - keys: { { "<leader>cl", <function 1>,
        desc = "Lsp Info",
        mode = "n"
      }, { "gd", <function 2>,
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", <function 3>,
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", <function 4>,
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", <function 5>,
        desc = "Goto T[y]pe Definition",
        mode = "n"
      }, { "gD", <function 6>,
        desc = "Goto Declaration",
        mode = "n"
      }, { "K", <function 7>,
        desc = "Hover",
        mode = "n"
      }, { "gK", <function 8>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "n"
      }, { "<c-k>", <function 9>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "i"
      }, { "<leader>ca", <function 10>,
        desc = "Code Action",
        has = "codeAction",
        mode = { "n", "x" }
      }, { "<leader>cc", <function 11>,
        desc = "Run Codelens",
        has = "codeLens",
        mode = { "n", "x" }
      }, { "<leader>cC", <function 12>,
        desc = "Refresh & Display Codelens",
        has = "codeLens",
        mode = { "n" }
      }, { "<leader>cR", <function 13>,
        desc = "Rename File",
        has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
        mode = { "n" }
      }, { "<leader>cr", <function 14>,
        desc = "Rename",
        has = "rename",
        mode = "n"
      }, { "<leader>cA", <function 15>,
        desc = "Source Action",
        has = "codeAction",
        mode = "n"
      }, { "]]", <function 16>,
        desc = "Next Reference",
        enabled = <function 17>,
        has = "documentHighlight",
        mode = "n"
      }, { "[[", <function 18>,
        desc = "Prev Reference",
        enabled = <function 19>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-n>", <function 20>,
        desc = "Next Reference",
        enabled = <function 21>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-p>", <function 22>,
        desc = "Prev Reference",
        enabled = <function 23>,
        has = "documentHighlight",
        mode = "n"
      }, { "<leader>co", <function 24>,
        desc = "Organize Imports",
        enabled = <function 25>,
        has = "codeAction",
        mode = "n"
      }, { "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>",
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>",
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>",
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>",
        desc = "Goto T[y]pe Definition",
        mode = "n"
      } }
  - root_markers: { "Dockerfile" }

- lua_ls:
  - capabilities: {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true
        }
      }
    }
  - cmd: { "lua-language-server" }
  - filetypes: lua
  - keys: { { "<leader>cl", <function 1>,
        desc = "Lsp Info",
        mode = "n"
      }, { "gd", <function 2>,
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", <function 3>,
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", <function 4>,
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", <function 5>,
        desc = "Goto T[y]pe Definition",
        mode = "n"
      }, { "gD", <function 6>,
        desc = "Goto Declaration",
        mode = "n"
      }, { "K", <function 7>,
        desc = "Hover",
        mode = "n"
      }, { "gK", <function 8>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "n"
      }, { "<c-k>", <function 9>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "i"
      }, { "<leader>ca", <function 10>,
        desc = "Code Action",
        has = "codeAction",
        mode = { "n", "x" }
      }, { "<leader>cc", <function 11>,
        desc = "Run Codelens",
        has = "codeLens",
        mode = { "n", "x" }
      }, { "<leader>cC", <function 12>,
        desc = "Refresh & Display Codelens",
        has = "codeLens",
        mode = { "n" }
      }, { "<leader>cR", <function 13>,
        desc = "Rename File",
        has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
        mode = { "n" }
      }, { "<leader>cr", <function 14>,
        desc = "Rename",
        has = "rename",
        mode = "n"
      }, { "<leader>cA", <function 15>,
        desc = "Source Action",
        has = "codeAction",
        mode = "n"
      }, { "]]", <function 16>,
        desc = "Next Reference",
        enabled = <function 17>,
        has = "documentHighlight",
        mode = "n"
      }, { "[[", <function 18>,
        desc = "Prev Reference",
        enabled = <function 19>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-n>", <function 20>,
        desc = "Next Reference",
        enabled = <function 21>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-p>", <function 22>,
        desc = "Prev Reference",
        enabled = <function 23>,
        has = "documentHighlight",
        mode = "n"
      }, { "<leader>co", <function 24>,
        desc = "Organize Imports",
        enabled = <function 25>,
        has = "codeAction",
        mode = "n"
      }, { "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>",
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>",
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>",
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>",
        desc = "Goto T[y]pe Definition",
        mode = "n"
      } }
  - root_markers: { { ".emmyrc.json", ".luarc.json", ".luarc.jsonc" }, { ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml" }, { ".git" } }
  - settings: {
      Lua = {
        codeLens = {
          enable = true
        },
        completion = {
          callSnippet = "Replace"
        },
        doc = {
          privateName = { "^_" }
        },
        hint = {
          arrayIndex = "Disable",
          enable = true,
          paramName = "Disable",
          paramType = true,
          semicolon = "Disable",
          setType = false
        },
        workspace = {
          checkThirdParty = false
        }
      }
    }

- nil_ls:
  - capabilities: {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true
        }
      }
    }
  - cmd: { "nil" }
  - filetypes: nix
  - keys: { { "<leader>cl", <function 1>,
        desc = "Lsp Info",
        mode = "n"
      }, { "gd", <function 2>,
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", <function 3>,
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", <function 4>,
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", <function 5>,
        desc = "Goto T[y]pe Definition",
        mode = "n"
      }, { "gD", <function 6>,
        desc = "Goto Declaration",
        mode = "n"
      }, { "K", <function 7>,
        desc = "Hover",
        mode = "n"
      }, { "gK", <function 8>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "n"
      }, { "<c-k>", <function 9>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "i"
      }, { "<leader>ca", <function 10>,
        desc = "Code Action",
        has = "codeAction",
        mode = { "n", "x" }
      }, { "<leader>cc", <function 11>,
        desc = "Run Codelens",
        has = "codeLens",
        mode = { "n", "x" }
      }, { "<leader>cC", <function 12>,
        desc = "Refresh & Display Codelens",
        has = "codeLens",
        mode = { "n" }
      }, { "<leader>cR", <function 13>,
        desc = "Rename File",
        has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
        mode = { "n" }
      }, { "<leader>cr", <function 14>,
        desc = "Rename",
        has = "rename",
        mode = "n"
      }, { "<leader>cA", <function 15>,
        desc = "Source Action",
        has = "codeAction",
        mode = "n"
      }, { "]]", <function 16>,
        desc = "Next Reference",
        enabled = <function 17>,
        has = "documentHighlight",
        mode = "n"
      }, { "[[", <function 18>,
        desc = "Prev Reference",
        enabled = <function 19>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-n>", <function 20>,
        desc = "Next Reference",
        enabled = <function 21>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-p>", <function 22>,
        desc = "Prev Reference",
        enabled = <function 23>,
        has = "documentHighlight",
        mode = "n"
      }, { "<leader>co", <function 24>,
        desc = "Organize Imports",
        enabled = <function 25>,
        has = "codeAction",
        mode = "n"
      }, { "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>",
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>",
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>",
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>",
        desc = "Goto T[y]pe Definition",
        mode = "n"
      } }
  - root_markers: { "flake.nix", ".git" }

- ⚠️ WARNING 'pyright-langserver' is not executable. Configuration will not be used.
- pyright:
  - capabilities: {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true
        }
      }
    }
  - cmd: { "pyright-langserver", "--stdio" }
  - enabled: true
  - filetypes: python
  - keys: { { "<leader>cl", <function 1>,
        desc = "Lsp Info",
        mode = "n"
      }, { "gd", <function 2>,
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", <function 3>,
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", <function 4>,
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", <function 5>,
        desc = "Goto T[y]pe Definition",
        mode = "n"
      }, { "gD", <function 6>,
        desc = "Goto Declaration",
        mode = "n"
      }, { "K", <function 7>,
        desc = "Hover",
        mode = "n"
      }, { "gK", <function 8>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "n"
      }, { "<c-k>", <function 9>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "i"
      }, { "<leader>ca", <function 10>,
        desc = "Code Action",
        has = "codeAction",
        mode = { "n", "x" }
      }, { "<leader>cc", <function 11>,
        desc = "Run Codelens",
        has = "codeLens",
        mode = { "n", "x" }
      }, { "<leader>cC", <function 12>,
        desc = "Refresh & Display Codelens",
        has = "codeLens",
        mode = { "n" }
      }, { "<leader>cR", <function 13>,
        desc = "Rename File",
        has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
        mode = { "n" }
      }, { "<leader>cr", <function 14>,
        desc = "Rename",
        has = "rename",
        mode = "n"
      }, { "<leader>cA", <function 15>,
        desc = "Source Action",
        has = "codeAction",
        mode = "n"
      }, { "]]", <function 16>,
        desc = "Next Reference",
        enabled = <function 17>,
        has = "documentHighlight",
        mode = "n"
      }, { "[[", <function 18>,
        desc = "Prev Reference",
        enabled = <function 19>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-n>", <function 20>,
        desc = "Next Reference",
        enabled = <function 21>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-p>", <function 22>,
        desc = "Prev Reference",
        enabled = <function 23>,
        has = "documentHighlight",
        mode = "n"
      }, { "<leader>co", <function 24>,
        desc = "Organize Imports",
        enabled = <function 25>,
        has = "codeAction",
        mode = "n"
      }, { "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>",
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>",
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>",
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>",
        desc = "Goto T[y]pe Definition",
        mode = "n"
      } }
  - on_attach: <function @/home/ten/.local/share/nvim/lazy/nvim-lspconfig/lsp/pyright.lua:61>
  - root_markers: { "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" }
  - settings: {
      pyright = {
        disableTaggedHints = true
      },
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true
        }
      }
    }

- ⚠️ WARNING 'ruff' is not executable. Configuration will not be used.
- ruff:
  - capabilities: {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true
        }
      }
    }
  - cmd: { "ruff", "server" }
  - cmd_env: {
      RUFF_TRACE = "messages"
    }
  - enabled: true
  - filetypes: python
  - init_options: {
      settings = {
        logLevel = "error"
      }
    }
  - keys: { { "<leader>cl", <function 1>,
        desc = "Lsp Info",
        mode = "n"
      }, { "gd", <function 2>,
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", <function 3>,
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", <function 4>,
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", <function 5>,
        desc = "Goto T[y]pe Definition",
        mode = "n"
      }, { "gD", <function 6>,
        desc = "Goto Declaration",
        mode = "n"
      }, { "K", <function 7>,
        desc = "Hover",
        mode = "n"
      }, { "gK", <function 8>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "n"
      }, { "<c-k>", <function 9>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "i"
      }, { "<leader>ca", <function 10>,
        desc = "Code Action",
        has = "codeAction",
        mode = { "n", "x" }
      }, { "<leader>cc", <function 11>,
        desc = "Run Codelens",
        has = "codeLens",
        mode = { "n", "x" }
      }, { "<leader>cC", <function 12>,
        desc = "Refresh & Display Codelens",
        has = "codeLens",
        mode = { "n" }
      }, { "<leader>cR", <function 13>,
        desc = "Rename File",
        has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
        mode = { "n" }
      }, { "<leader>cr", <function 14>,
        desc = "Rename",
        has = "rename",
        mode = "n"
      }, { "<leader>cA", <function 15>,
        desc = "Source Action",
        has = "codeAction",
        mode = "n"
      }, { "]]", <function 16>,
        desc = "Next Reference",
        enabled = <function 17>,
        has = "documentHighlight",
        mode = "n"
      }, { "[[", <function 18>,
        desc = "Prev Reference",
        enabled = <function 19>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-n>", <function 20>,
        desc = "Next Reference",
        enabled = <function 21>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-p>", <function 22>,
        desc = "Prev Reference",
        enabled = <function 23>,
        has = "documentHighlight",
        mode = "n"
      }, { "<leader>co", <function 24>,
        desc = "Organize Imports",
        enabled = <function 25>,
        has = "codeAction",
        mode = "n"
      }, { "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>",
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>",
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>",
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>",
        desc = "Goto T[y]pe Definition",
        mode = "n"
      } }
  - root_markers: { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" }
  - settings: {}

- ⚠️ WARNING 'terraform-ls' is not executable. Configuration will not be used.
- terraformls:
  - capabilities: {
      experimental = {
        showReferencesCommandId = "client.showReferences"
      },
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true
        }
      }
    }
  - cmd: { "terraform-ls", "serve" }
  - filetypes: terraform, terraform-vars
  - keys: { { "<leader>cl", <function 1>,
        desc = "Lsp Info",
        mode = "n"
      }, { "gd", <function 2>,
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", <function 3>,
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", <function 4>,
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", <function 5>,
        desc = "Goto T[y]pe Definition",
        mode = "n"
      }, { "gD", <function 6>,
        desc = "Goto Declaration",
        mode = "n"
      }, { "K", <function 7>,
        desc = "Hover",
        mode = "n"
      }, { "gK", <function 8>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "n"
      }, { "<c-k>", <function 9>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "i"
      }, { "<leader>ca", <function 10>,
        desc = "Code Action",
        has = "codeAction",
        mode = { "n", "x" }
      }, { "<leader>cc", <function 11>,
        desc = "Run Codelens",
        has = "codeLens",
        mode = { "n", "x" }
      }, { "<leader>cC", <function 12>,
        desc = "Refresh & Display Codelens",
        has = "codeLens",
        mode = { "n" }
      }, { "<leader>cR", <function 13>,
        desc = "Rename File",
        has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
        mode = { "n" }
      }, { "<leader>cr", <function 14>,
        desc = "Rename",
        has = "rename",
        mode = "n"
      }, { "<leader>cA", <function 15>,
        desc = "Source Action",
        has = "codeAction",
        mode = "n"
      }, { "]]", <function 16>,
        desc = "Next Reference",
        enabled = <function 17>,
        has = "documentHighlight",
        mode = "n"
      }, { "[[", <function 18>,
        desc = "Prev Reference",
        enabled = <function 19>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-n>", <function 20>,
        desc = "Next Reference",
        enabled = <function 21>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-p>", <function 22>,
        desc = "Prev Reference",
        enabled = <function 23>,
        has = "documentHighlight",
        mode = "n"
      }, { "<leader>co", <function 24>,
        desc = "Organize Imports",
        enabled = <function 25>,
        has = "codeAction",
        mode = "n"
      }, { "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>",
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>",
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>",
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>",
        desc = "Goto T[y]pe Definition",
        mode = "n"
      } }
  - on_attach: <function @/home/ten/.local/share/nvim/lazy/nvim-lspconfig/lsp/terraformls.lua:45>
  - root_markers: { ".terraform", ".git" }

- ⚠️ WARNING Unknown filetype 'yaml.docker-compose' (Hint: filename extension != filetype).
- ⚠️ WARNING Unknown filetype 'yaml.gitlab' (Hint: filename extension != filetype).
- ⚠️ WARNING Unknown filetype 'yaml.helm-values' (Hint: filename extension != filetype).
- yamlls:
  - before_init: <function @/home/ten/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/lang/yaml.lua:32>
  - capabilities: {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
        }
      },
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true
        }
      }
    }
  - cmd: <function @/home/ten/.local/share/nvim/lazy/nvim-lspconfig/lsp/yamlls.lua:64>
  - filetypes: yaml, yaml.docker-compose, yaml.gitlab, yaml.helm-values
  - keys: { { "<leader>cl", <function 1>,
        desc = "Lsp Info",
        mode = "n"
      }, { "gd", <function 2>,
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", <function 3>,
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", <function 4>,
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", <function 5>,
        desc = "Goto T[y]pe Definition",
        mode = "n"
      }, { "gD", <function 6>,
        desc = "Goto Declaration",
        mode = "n"
      }, { "K", <function 7>,
        desc = "Hover",
        mode = "n"
      }, { "gK", <function 8>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "n"
      }, { "<c-k>", <function 9>,
        desc = "Signature Help",
        has = "signatureHelp",
        mode = "i"
      }, { "<leader>ca", <function 10>,
        desc = "Code Action",
        has = "codeAction",
        mode = { "n", "x" }
      }, { "<leader>cc", <function 11>,
        desc = "Run Codelens",
        has = "codeLens",
        mode = { "n", "x" }
      }, { "<leader>cC", <function 12>,
        desc = "Refresh & Display Codelens",
        has = "codeLens",
        mode = { "n" }
      }, { "<leader>cR", <function 13>,
        desc = "Rename File",
        has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
        mode = { "n" }
      }, { "<leader>cr", <function 14>,
        desc = "Rename",
        has = "rename",
        mode = "n"
      }, { "<leader>cA", <function 15>,
        desc = "Source Action",
        has = "codeAction",
        mode = "n"
      }, { "]]", <function 16>,
        desc = "Next Reference",
        enabled = <function 17>,
        has = "documentHighlight",
        mode = "n"
      }, { "[[", <function 18>,
        desc = "Prev Reference",
        enabled = <function 19>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-n>", <function 20>,
        desc = "Next Reference",
        enabled = <function 21>,
        has = "documentHighlight",
        mode = "n"
      }, { "<a-p>", <function 22>,
        desc = "Prev Reference",
        enabled = <function 23>,
        has = "documentHighlight",
        mode = "n"
      }, { "<leader>co", <function 24>,
        desc = "Organize Imports",
        enabled = <function 25>,
        has = "codeAction",
        mode = "n"
      }, { "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>",
        desc = "Goto Definition",
        has = "definition",
        mode = "n"
      }, { "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>",
        desc = "References",
        mode = "n",
        nowait = true
      }, { "gI", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>",
        desc = "Goto Implementation",
        mode = "n"
      }, { "gy", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>",
        desc = "Goto T[y]pe Definition",
        mode = "n"
      } }
  - on_init: <function @/home/ten/.local/share/nvim/lazy/nvim-lspconfig/lsp/yamlls.lua:83>
  - root_markers: { ".git" }
  - settings: {
      redhat = {
        telemetry = {
          enabled = false
        }
      },
      yaml = {
        format = {
          enable = true
        },
        keyOrdering = false,
        schemaStore = {
          enable = false,
          url = ""
        },
        validate = true
      }
    }


vim.lsp: File Watcher ~
- file watching "(workspace/didChangeWatchedFiles)" disabled on all clients

vim.lsp: Position Encodings ~
- No active clients

==============================================================================
vim.pack:                                                                 1 ⚠️

vim.pack: basics ~
- Git: version 2.54.0 (/etc/profiles/per-user/ten/bin/git)
- Lockfile: /home/ten/.config/nvim/nvim-pack-lock.json
- Plugin directory: /home/ten/.local/share/nvim/site/pack/core/opt
- ⚠️ WARNING Lockfile is absent, plugin directory is present. Restart Nvim and run `vim.pack.add({})` to regenerate the lockfile

vim.pack: plugin directory ~
- ✅ OK

==============================================================================
vim.provider:                                                               ✅

Clipboard (optional) ~
- ✅ OK Clipboard tool found: wl-copy

Node.js provider (optional) ~
- Disabled (loaded_node_provider=0).

Perl provider (optional) ~
- Disabled (loaded_perl_provider=0).

Python 3 provider (optional) ~
- `g:python3_host_prog` is not set. Searching for pynvim-python in the environment.
- Executable: /nix/store/y5d7nk0n0sfd6ms91mvpgb7cgx5fy52v-python3-3.13.15-env/bin/pynvim-python
- Python version: 3.13.15
- pynvim version: 0.6.0
- ✅ OK Latest pynvim is installed.

Python virtualenv ~
- ✅ OK no $VIRTUAL_ENV

Ruby provider (optional) ~
- Disabled (loaded_ruby_provider=0).

==============================================================================
vim.treesitter:                                                             ✅

Treesitter features ~
- Treesitter ABI support: min 13, max 15
- WASM parser support: false

Treesitter parsers ~
- ✅ OK Parser: bash                      ABI: 15, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/bash.so
- ✅ OK Parser: c                         ABI: 15, path: /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/lib/nvim/parser/c.so
- ✅ OK Parser: c                    (not loaded), path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/c.so
- ✅ OK Parser: diff                      ABI: 15, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/diff.so
- ✅ OK Parser: dockerfile                ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/dockerfile.so
- ✅ OK Parser: dtd                       ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/dtd.so
- ✅ OK Parser: git_config                ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/git_config.so
- ✅ OK Parser: git_rebase                ABI: 15, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/git_rebase.so
- ✅ OK Parser: gitattributes             ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/gitattributes.so
- ✅ OK Parser: gitcommit                 ABI: 15, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/gitcommit.so
- ✅ OK Parser: gitignore                 ABI: 13, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/gitignore.so
- ✅ OK Parser: hcl                       ABI: 15, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/hcl.so
- ✅ OK Parser: html                      ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/html.so
- ✅ OK Parser: javascript                ABI: 15, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/javascript.so
- ✅ OK Parser: jsdoc                     ABI: 15, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/jsdoc.so
- ✅ OK Parser: json                      ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/json.so
- ✅ OK Parser: lua                       ABI: 15, path: /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/lib/nvim/parser/lua.so
- ✅ OK Parser: lua                  (not loaded), path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/lua.so
- ✅ OK Parser: luadoc                    ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/luadoc.so
- ✅ OK Parser: luap                      ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/luap.so
- ✅ OK Parser: markdown                  ABI: 15, path: /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/lib/nvim/parser/markdown.so
- ✅ OK Parser: markdown             (not loaded), path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/markdown.so
- ✅ OK Parser: markdown_inline           ABI: 15, path: /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/lib/nvim/parser/markdown_inline.so
- ✅ OK Parser: markdown_inline      (not loaded), path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/markdown_inline.so
- ✅ OK Parser: ninja                     ABI: 13, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/ninja.so
- ✅ OK Parser: nix                       ABI: 13, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/nix.so
- ✅ OK Parser: printf                    ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/printf.so
- ✅ OK Parser: python                    ABI: 15, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/python.so
- ✅ OK Parser: query                     ABI: 15, path: /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/lib/nvim/parser/query.so
- ✅ OK Parser: query                (not loaded), path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/query.so
- ✅ OK Parser: regex                     ABI: 15, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/regex.so
- ✅ OK Parser: ron                       ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/ron.so
- ✅ OK Parser: rst                       ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/rst.so
- ✅ OK Parser: rust                      ABI: 15, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/rust.so
- ✅ OK Parser: sql                       ABI: 15, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/sql.so
- ✅ OK Parser: terraform                 ABI: 15, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/terraform.so
- ✅ OK Parser: toml                      ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/toml.so
- ✅ OK Parser: tsx                       ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/tsx.so
- ✅ OK Parser: typescript                ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/typescript.so
- ✅ OK Parser: vim                       ABI: 15, path: /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/lib/nvim/parser/vim.so
- ✅ OK Parser: vim                  (not loaded), path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/vim.so
- ✅ OK Parser: vimdoc                    ABI: 15, path: /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/lib/nvim/parser/vimdoc.so
- ✅ OK Parser: vimdoc               (not loaded), path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/vimdoc.so
- ✅ OK Parser: xml                       ABI: 14, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/xml.so
- ✅ OK Parser: yaml                      ABI: 15, path: /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/parser/yaml.so

Treesitter queries ~
- ✅ OK apex            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/apex
- ✅ OK astro           textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/astro
- ✅ OK bash            folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/bash
- ✅ OK bash            highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/bash
- ✅ OK bash            indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/bash
- ✅ OK bash            injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/bash
- ✅ OK bash            locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/bash
- ✅ OK bash            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/bash
- ✅ OK bibtex          textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/bibtex
- ✅ OK c               folds           /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/c
- ✅ OK c               folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/c
- ✅ OK c               highlights      /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/c
- ✅ OK c               highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/c
- ✅ OK c               indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/c
- ✅ OK c               injections      /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/c
- ✅ OK c               injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/c
- ✅ OK c               locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/c
- ✅ OK c               textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/c
- ✅ OK c_sharp         textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/c_sharp
- ✅ OK cmake           textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/cmake
- ✅ OK cpp             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/cpp
- ✅ OK css             images          /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/css
- ✅ OK css             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/css
- ✅ OK cuda            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/cuda
- ✅ OK dart            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/dart
- ✅ OK diff            folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/diff
- ✅ OK diff            highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/diff
- ✅ OK diff            injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/diff
- ✅ OK dockerfile      highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/dockerfile
- ✅ OK dockerfile      injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/dockerfile
- ✅ OK dockerfile      textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/dockerfile
- ✅ OK dtd             folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/dtd
- ✅ OK dtd             highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/dtd
- ✅ OK dtd             injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/dtd
- ✅ OK dtd             locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/dtd
- ✅ OK ecma            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/ecma
- ✅ OK elixir          textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/elixir
- ✅ OK elm             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/elm
- ✅ OK enforce         textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/enforce
- ✅ OK fennel          textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/fennel
- ✅ OK fish            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/fish
- ✅ OK foam            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/foam
- ✅ OK gdscript        textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/gdscript
- ✅ OK git_config      folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/git_config
- ✅ OK git_config      highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/git_config
- ✅ OK git_config      injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/git_config
- ✅ OK git_config      textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/git_config
- ✅ OK git_rebase      highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/git_rebase
- ✅ OK git_rebase      injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/git_rebase
- ✅ OK gitattributes   highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/gitattributes
- ✅ OK gitattributes   injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/gitattributes
- ✅ OK gitattributes   locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/gitattributes
- ✅ OK gitcommit       highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/gitcommit
- ✅ OK gitcommit       injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/gitcommit
- ✅ OK gitignore       highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/gitignore
- ✅ OK gitignore       injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/gitignore
- ✅ OK gleam           textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/gleam
- ✅ OK glimmer         textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/glimmer
- ✅ OK glsl            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/glsl
- ✅ OK go              textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/go
- ✅ OK hack            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/hack
- ✅ OK haskell         textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/haskell
- ✅ OK hcl             folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/hcl
- ✅ OK hcl             highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/hcl
- ✅ OK hcl             indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/hcl
- ✅ OK hcl             injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/hcl
- ✅ OK hcl             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/hcl
- ✅ OK heex            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/heex
- ✅ OK hlsl            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/hlsl
- ✅ OK html            folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/html
- ✅ OK html            highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/html
- ✅ OK html            images          /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/html
- ✅ OK html            indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/html
- ✅ OK html            injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/html
- ✅ OK html            locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/html
- ✅ OK html            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/html
- ✅ OK inko            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/inko
- ✅ OK java            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/java
- ✅ OK javascript      folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/javascript
- ✅ OK javascript      highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/javascript
- ✅ OK javascript      images          /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/javascript
- ✅ OK javascript      indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/javascript
- ✅ OK javascript      injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/javascript
- ✅ OK javascript      locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/javascript
- ✅ OK javascript      textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/javascript
- ✅ OK jsdoc           highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/jsdoc
- ✅ OK json            folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/json
- ✅ OK json            highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/json
- ✅ OK json            indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/json
- ✅ OK json            injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/json
- ✅ OK json            locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/json
- ✅ OK json            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/json
- ✅ OK jsx             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/jsx
- ✅ OK julia           textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/julia
- ✅ OK kotlin          textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/kotlin
- ✅ OK latex           images          /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/latex
- ✅ OK latex           textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/latex
- ✅ OK lua             folds           /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/lua
- ✅ OK lua             folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/lua
- ✅ OK lua             highlights      /home/ten/.local/share/nvim/lazy/LazyVim/queries/lua
- ✅ OK lua             highlights      /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/lua
- ✅ OK lua             highlights      /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/lua
- ✅ OK lua             highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/lua
- ✅ OK lua             indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/lua
- ✅ OK lua             injections      /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/lua
- ✅ OK lua             injections      /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/lua
- ✅ OK lua             injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/lua
- ✅ OK lua             locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/lua
- ✅ OK lua             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/lua
- ✅ OK luadoc          highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/luadoc
- ✅ OK luap            highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/luap
- ✅ OK markdown        folds           /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/markdown
- ✅ OK markdown        folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/markdown
- ✅ OK markdown        highlights      /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/markdown
- ✅ OK markdown        highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/markdown
- ✅ OK markdown        images          /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/markdown
- ✅ OK markdown        indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/markdown
- ✅ OK markdown        injections      /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/markdown
- ✅ OK markdown        injections      /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/markdown
- ✅ OK markdown        injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/markdown
- ✅ OK markdown        textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/markdown
- ✅ OK markdown_inline highlights      /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/markdown_inline
- ✅ OK markdown_inline highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/markdown_inline
- ✅ OK markdown_inline images          /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/markdown_inline
- ✅ OK markdown_inline injections      /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/markdown_inline
- ✅ OK markdown_inline injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/markdown_inline
- ✅ OK matlab          textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/matlab
- ✅ OK nasm            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/nasm
- ✅ OK nim             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/nim
- ✅ OK ninja           folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/ninja
- ✅ OK ninja           highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/ninja
- ✅ OK ninja           indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/ninja
- ✅ OK ninja           injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/ninja
- ✅ OK nix             folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/nix
- ✅ OK nix             highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/nix
- ✅ OK nix             indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/nix
- ✅ OK nix             injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/nix
- ✅ OK nix             locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/nix
- ✅ OK nix             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/nix
- ✅ OK norg            images          /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/norg
- ✅ OK ocaml           textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/ocaml
- ✅ OK odin            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/odin
- ✅ OK perl            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/perl
- ✅ OK php             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/php
- ✅ OK php_only        textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/php_only
- ✅ OK printf          highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/printf
- ✅ OK python          folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/python
- ✅ OK python          highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/python
- ✅ OK python          indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/python
- ✅ OK python          injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/python
- ✅ OK python          locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/python
- ✅ OK python          textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/python
- ✅ OK ql              textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/ql
- ✅ OK query           folds           /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/query
- ✅ OK query           folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/query
- ✅ OK query           highlights      /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/query
- ✅ OK query           highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/query
- ✅ OK query           indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/query
- ✅ OK query           injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/query
- ✅ OK query           locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/query
- ✅ OK query           textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/query
- ✅ OK r               textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/r
- ✅ OK readline        textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/readline
- ✅ OK regex           highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/regex
- ✅ OK ron             folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/ron
- ✅ OK ron             highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/ron
- ✅ OK ron             indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/ron
- ✅ OK ron             injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/ron
- ✅ OK ron             locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/ron
- ✅ OK rst             highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/rst
- ✅ OK rst             injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/rst
- ✅ OK rst             locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/rst
- ✅ OK rst             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/rst
- ✅ OK ruby            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/ruby
- ✅ OK rust            folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/rust
- ✅ OK rust            highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/rust
- ✅ OK rust            indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/rust
- ✅ OK rust            injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/rust
- ✅ OK rust            locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/rust
- ✅ OK rust            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/rust
- ✅ OK scala           textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/scala
- ✅ OK scss            images          /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/scss
- ✅ OK scss            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/scss
- ✅ OK slang           textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/slang
- ✅ OK sql             folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/sql
- ✅ OK sql             highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/sql
- ✅ OK sql             indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/sql
- ✅ OK sql             injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/sql
- ✅ OK supercollider   textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/supercollider
- ✅ OK svelte          images          /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/svelte
- ✅ OK svelte          textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/svelte
- ✅ OK swift           textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/swift
- ✅ OK systemverilog   textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/systemverilog
- ✅ OK tact            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/tact
- ✅ OK terraform       folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/terraform
- ✅ OK terraform       highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/terraform
- ✅ OK terraform       indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/terraform
- ✅ OK terraform       injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/terraform
- ✅ OK terraform       textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/terraform
- ✅ OK toml            folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/toml
- ✅ OK toml            highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/toml
- ✅ OK toml            indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/toml
- ✅ OK toml            injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/toml
- ✅ OK toml            locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/toml
- ✅ OK toml            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/toml
- ✅ OK tsx             folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/tsx
- ✅ OK tsx             highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/tsx
- ✅ OK tsx             images          /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/tsx
- ✅ OK tsx             indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/tsx
- ✅ OK tsx             injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/tsx
- ✅ OK tsx             locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/tsx
- ✅ OK tsx             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/tsx
- ✅ OK twig            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/twig
- ✅ OK typescript      folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/typescript
- ✅ OK typescript      highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/typescript
- ✅ OK typescript      indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/typescript
- ✅ OK typescript      injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/typescript
- ✅ OK typescript      locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/typescript
- ✅ OK typescript      textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/typescript
- ✅ OK typst           images          /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/typst
- ✅ OK v               textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/v
- ✅ OK vim             folds           /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/vim
- ✅ OK vim             folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/vim
- ✅ OK vim             highlights      /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/vim
- ✅ OK vim             highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/vim
- ✅ OK vim             injections      /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/vim
- ✅ OK vim             injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/vim
- ✅ OK vim             locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/vim
- ✅ OK vim             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/vim
- ✅ OK vimdoc          highlights      /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/vimdoc
- ✅ OK vimdoc          highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/vimdoc
- ✅ OK vimdoc          injections      /nix/store/hi8r0ag26xi8cfqp51yi18v85zi4xlr8-neovim-unwrapped-0.12.4/share/nvim/runtime/queries/vimdoc
- ✅ OK vimdoc          injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/vimdoc
- ✅ OK vue             images          /home/ten/.local/share/nvim/lazy/snacks.nvim/queries/vue
- ✅ OK vue             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/vue
- ✅ OK wgsl            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/wgsl
- ✅ OK wgsl_bevy       textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/wgsl_bevy
- ✅ OK xml             folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/xml
- ✅ OK xml             highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/xml
- ✅ OK xml             indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/xml
- ✅ OK xml             injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/xml
- ✅ OK xml             locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/xml
- ✅ OK yaml            folds           /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/yaml
- ✅ OK yaml            highlights      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/yaml
- ✅ OK yaml            indents         /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/yaml
- ✅ OK yaml            injections      /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/yaml
- ✅ OK yaml            locals          /nix/store/6zfg8cnr4kafdyjyczlpa58f533y76g9-nvim-treesitter-runtime/queries/yaml
- ✅ OK yaml            textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/yaml
- ✅ OK zig             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/zig
- ✅ OK zsh             textobjects     /home/ten/.local/share/nvim/lazy/nvim-treesitter-textobjects/queries/zsh

==============================================================================
which-key:                                                                8 ⚠️

- ✅ OK Most of these checks are for informational purposes only.
  WARNINGS should be treated as a warning, and don't necessarily indicate a problem with your config.
  Please |DON'T| report these warnings as an issue.

Checking your config ~
- ✅ OK |mini.icons| is installed
- ✅ OK |nvim-web-devicons| is installed

Checking for issues with your mappings ~
- ✅ OK No issues reported

checking for overlapping keymaps ~
- ⚠️ WARNING In mode `n`, <g> overlaps with <gO>, <gzr>, <gzf>, <gza>, <gzd>, <gzn>, <gzh>, <gzF>, <gc>, <gcc>, <gco>, <gcO>, <grr>, <gra>, <grx>, <grn>, <gri>, <grt>, <g_>, <gp>, <go>, <goo>, <gP>, <g[>, <g%>, <gx>, <g]>, <gs>:
  - <g>: goto
  - <gO>: vim.lsp.buf.document_symbol()
  - <gzr>: Replace Surrounding
  - <gzf>: Find Right Surrounding
  - <gza>: Add Surrounding
  - <gzd>: Delete Surrounding
  - <gzn>: Update `MiniSurround.config.n_lines`
  - <gzh>: Highlight Surrounding
  - <gzF>: Find Left Surrounding
  - <gc>: Toggle comment
  - <gcc>: Toggle comment line
  - <gco>: Add Comment Below
  - <gcO>: Add Comment Above
  - <grr>: vim.lsp.buf.references()
  - <gra>: vim.lsp.buf.code_action()
  - <grx>: vim.lsp.codelens.run()
  - <grn>: vim.lsp.buf.rename()
  - <gri>: vim.lsp.buf.implementation()
  - <grt>: vim.lsp.buf.type_definition()
  - <g_>: Goto the end of line
  - <gp>: Put Text After Selection
  - <go>: Add range to opencode
  - <goo>: Add line to opencode
  - <gP>: Put Text Before Selection
  - <g[>: Move to left "around"
  - <g%>: Cycle backwards through results
  - <gx>: Open with system app
  - <g]>: Move to right "around"
  - <gs>: surround
- ⚠️ WARNING In mode `x`, <a> overlaps with <a%>, <an>, <ai>, <al>:
  - <a>: around
  - <an>: next
  - <ai>: indent
  - <al>: last
- ⚠️ WARNING In mode `x`, <i> overlaps with <in>, <ii>, <il>:
  - <i>: inside
  - <in>: next
  - <ii>: indent
  - <il>: last
- ⚠️ WARNING In mode `o`, <a> overlaps with <an>, <ai>, <al>:
  - <a>: around
  - <an>: next
  - <ai>: indent
  - <al>: last
- ⚠️ WARNING In mode `o`, <i> overlaps with <in>, <ii>, <il>:
  - <i>: inside
  - <in>: next
  - <ii>: indent
  - <il>: last
- ⚠️ WARNING In mode `n`, <go> overlaps with <goo>:
  - <go>: Add range to opencode
  - <goo>: Add line to opencode
- ⚠️ WARNING In mode `n`, <gc> overlaps with <gcc>, <gco>, <gcO>:
  - <gc>: Toggle comment
  - <gcc>: Toggle comment line
  - <gco>: Add Comment Below
  - <gcO>: Add Comment Above
- ✅ OK Overlapping keymaps are only reported for informational purposes.
  This doesn't necessarily mean there is a problem with your config.

Checking for duplicate mappings ~
- ⚠️ WARNING Duplicates for <<LEADER>wm> in mode `n`:
  * Windows Manager: `{ icon = "" }`
  * Enable Zoom Mode: `{ real = true, <metatable> = { __index = <function 1> } }`
- ✅ OK Duplicate mappings are only reported for informational purposes.
  This doesn't necessarily mean there is a problem with your config.

```
