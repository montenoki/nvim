local Icons = require('icons')
local function t(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), "m", true)
end
local function can_execute(arg)
  return vim.fn[arg]() == 1
end
local function has_words_before()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local char = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
  return col ~= 0 and (char:match("%s") == nil and char:match("%p") == nil)
end
return {
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      'hrsh7th/cmp-cmdline',
      'dmitmel/cmp-cmdline-history',
      'SirVer/ultisnips',
      "quangnguyen30192/cmp-nvim-ultisnips",
      { 'montenoki/vim-snippets' },
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args) vim.fn['UltiSnips#Anon'](args.body) end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = 'ultisnips' },
          { name = 'cmdline' },
          { name = 'cmdline_history' },
          { name = "path" },
          {
            name = "buffer",
            option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end }
          },
        }),
        formatting = {
          format = function(_, item)
            local icons = Icons.cmp
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = { ghost_text = { hl_group = "CmpGhostText" } },
        sorting = defaults.sorting,
        mapping = {
          -- TODO[2023/12/19]: fix: noice config - Calculator display.
          ["<tab>"] = {
            i = function(fallback)
              if has_words_before() then
                if cmp.visible() then
                  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                elseif can_execute("UltiSnips#CanJumpForwards") then
                  t("<Plug>(cmpu-jump-forwards)")
                else
                  cmp.complete()
                end
              else
                fallback()
              end
            end,
            c = function()
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
              else
                cmp.complete()
              end
            end,
          },
          ["<S-tab>"] = {
            i = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              elseif can_execute("UltiSnips#CanJumpBackwards") then
                t("<Plug>(cmpu-jump-backwards)")
              else
                fallback()
              end
            end,
            c = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
              else
                fallback()
              end
            end,
          },
          ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false }),
          ['<C-.>'] = {
            i = function()
              if cmp.visible() then
                cmp.abort()
              else
                cmp.complete()
              end
            end
          },
          ["<esc>"] = function(fallback)
            if cmp.visible() then
              cmp.abort()
            else
              fallback()
            end
          end,
          ["<A-h>"] = cmp.mapping.scroll_docs(-4),
          ["<A-l>"] = cmp.mapping.scroll_docs(4),
        },
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      local cmp = require('cmp')
      for i, source in ipairs(opts.sources) do
        source.group_index = source.group_index or i
      end
      cmp.setup(opts)
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
        }
      })
      cmp.setup.cmdline(':',
        {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({ { name = 'cmdline' }, { name = 'cmdline_history' }, { name = 'path' } }),
        })
    end,
  },

  -- Fast and feature-rich surround actions. For text that includes
  -- surrounding characters like brackets or quotes, this allows you
  -- to select the text inside, change or modify the surrounding characters,
  -- and more.
  {
    'echasnovski/mini.surround',
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require('lazy.core.config').spec.plugins['mini.surround']
      local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
      local mappings = {
        { opts.mappings.add,     desc = 'Add surrounding',    mode = { 'n', 'v' } },
        { opts.mappings.delete,  desc = 'Delete surrounding' },
        { opts.mappings.replace, desc = 'Replace surrounding' },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = 'ys',     -- Add surrounding in Normal and Visual modes
        delete = 'ds',  -- Delete surrounding
        replace = 'cs', -- Replace surrounding
      },
    },
  },
  -- auto pairs
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        '<leader>up',
        function()
          local Util = require('lazy.core.util')
          vim.g.minipairs_disable = not vim.g.minipairs_disable
          if vim.g.minipairs_disable then
            Util.warn('Disabled auto pairs', { title = 'Option' })
          else
            Util.info('Enabled auto pairs', { title = 'Option' })
          end
        end,
        desc = 'Toggle auto pairs',
      },
    },
  },

  -- Comment Toggle
  {
    'numToStr/Comment.nvim',
    lazy = false,
    opts = {},
  },

  -- Better text-objects
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      -- register all text objects with which-key
      require("lazyvim.util").on_load("which-key.nvim", function()
        ---@type table<string, string|table>
        local i = {
          [" "] = "Whitespace",
          ['"'] = 'Balanced "',
          ["'"] = "Balanced '",
          ["`"] = "Balanced `",
          ["("] = "Balanced (",
          [")"] = "Balanced ) including white-space",
          [">"] = "Balanced > including white-space",
          ["<lt>"] = "Balanced <",
          ["]"] = "Balanced ] including white-space",
          ["["] = "Balanced [",
          ["}"] = "Balanced } including white-space",
          ["{"] = "Balanced {",
          ["?"] = "User Prompt",
          _ = "Underscore",
          a = "Argument",
          b = "Balanced ), ], }",
          c = "Class",
          f = "Function",
          o = "Block, conditional, loop",
          q = "Quote `, \", '",
          t = "Tag",
        }
        local a = vim.deepcopy(i)
        for k, v in pairs(a) do
          a[k] = v:gsub(" including.*", "")
        end

        local ic = vim.deepcopy(i)
        local ac = vim.deepcopy(a)
        for key, name in pairs({ n = "Next", l = "Last" }) do
          i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
          a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
        end
        require("which-key").register({
          mode = { "o", "x" },
          i = i,
          a = a,
        })
      end)
    end,
  },
}
