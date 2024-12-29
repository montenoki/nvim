local utils = require("utils")

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      globalstatus = true,
      disabled_filetypes = { winbar = { "dap-repl" } },
      component_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = {
        { "mode", icon = "" },
      },
      lualine_b = {
        { "branch", icon = "" },
      },
      lualine_c = {
        {
          function()
            local clients =
              vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
            if vim.fn.exists(":LspInfo") == 0 then
              return ":off"
            end
            return ":" .. tostring(#vim.tbl_keys(clients))
          end,
          color = function()
            local clients =
              vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
            return #vim.tbl_keys(clients) > 0 and "DiagnosticInfo"
              or "DiagnosticUnnecessary"
          end,
          on_click = function()
            vim.cmd("LspInfo")
          end,
          icon = " ",
        },
        { "filename", path = 1, file_status = false },
      },
      -- lualine_x = {},
      lualine_z = {
        {
          function()
            return ""
          end,
          on_click = function()
            utils.toggle_option("spell")
          end,
          color = function()
            return vim.opt.spell:get() and {} or { fg = "normal" }
          end,
        },
        {
          function()
            return "󰀫"
          end,
          on_click = function()
            utils.toggle_option("list")
          end,
          color = function()
            return vim.opt.list:get() and {} or { fg = "normal" }
          end,
        },
        {
          function()
            return ""
          end,
          on_click = function()
            utils.toggle_option("relativenumber")
          end,
          color = function()
            return vim.opt.relativenumber:get() and {} or { fg = "normal" }
          end,
        },
        function()
          local icon = " "
          return icon .. os.date("%R")
        end,
      },
    },
    winbar = {
      lualine_a = {
        {
          "filename",
          file_status = true,
          newfile_status = true,
          symbols = {
            modified = "󰏫",
            readonly = "",
            unnamed = "[No Name]",
            newfile = "[New]",
          },
        },
      },
      lualine_y = {
        "diagnostics",
      },
    },
    inactive_winbar = {

      lualine_b = {
        {
          "filename",
          file_status = true,
          newfile_status = true,
          symbols = {
            modified = "󰏫",
            readonly = "",
            unnamed = "[No Name]",
            newfile = "[New]",
          },
        },
      },
    },
  },
}
