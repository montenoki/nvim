local M = {}
-- Server List:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
M.lsp_servers = {
  lua_ls = {
    -- mason = false, -- set to false if you don't want this server to be installed with mason
    -- Use this to add any additional keymaps
    -- for specific lsp servers
    -- keys = {},
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
  pylyzer = {
    python = {
      chechOnType = true,
    },
  },
  pyright = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        useLibraryCodeForTypes = true,
      },
    },
  },
  ruff_lsp = {
    init_options = {
      settings = {
        -- Any extra CLI arguments for `ruff` go here.
        args = {},
      },
    },
  },
}
M.mason_ensure_installed = {}
M.ts_ensure_installed = {
  "arduino",
  "bash",
  "c",
  "c_sharp",
  "cmake",
  "comment",
  "cpp",
  "css",
  "csv",
  "cuda",
  "diff",
  "dockerfile",
  "dot",
  "fish",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "go",
  "html",
  "htmldjango",
  "http",
  "hurl",
  "ini",
  "java",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "JSON",
  "jsonnet",
  "julia",
  "kconfig",
  "latex",
  "lua",
  "luadoc",
  "lua",
  "luau",
  "make",
  "markdown",
  "markdown_inline",
  "matlab",
  "mermaid",
  "objc",
  "pascal",
  "passwd",
  "pem",
  "perl",
  "php",
  "phpdoc",
  "psv",
  "purescript",
  "python",
  "r",
  "regex",
  "ruby",
  "rust",
  "scala",
  "scfg",
  "scheme",
  "sql",
  "ssh_config",
  "swift",
  "systemtap",
  "todotxt",
  "toml",
  "tsv",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "vue",
  "xml",
  "yaml",
  }

return M
