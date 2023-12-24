local Icons = require('icons')
local keybinds = require('keymaps')
local function t(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), 'm', true)
end
local function can_execute(arg)
  return vim.fn[arg]() == 1
end
return {
  -- auto completion
  {
    'hrsh7th/nvim-cmp',
    version = false, -- last release is way too old
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'dmitmel/cmp-cmdline-history',
      'SirVer/ultisnips',
      'quangnguyen30192/cmp-nvim-ultisnips',
      'montenoki/vim-snippets',
      {
        'zbirenbaum/copilot-cmp',
        enabled = vim.g.copilot and true or false,
        dependencies = 'copilot.lua',
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require('copilot_cmp')
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          require('util').lsp.on_attach(function(client)
            if client.name == 'copilot' then
              copilot_cmp._on_insert_enter({})
            end
          end)
        end,
      },
    },
    opts = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
      local cmp = require('cmp')
      local defaults = require('cmp.config.default')()
      local sources = {
        { name = 'ultisnips', priority = 100 },
        { name = 'nvim_lsp',  priority = 90 },
        {
          name = 'buffer',
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
          priority = 70,
        },
        { name = 'path', priority = 40 },
      }
      if vim.g.copilot then
        table.insert(sources, { name = 'copilot', priority = 50 })
      end
      return {
        completion = {
          completeopt = 'menu,menuone,noselect',
        },
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            vim.fn['UltiSnips#Anon'](args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources(sources),
        formatting = {
          format = function(_, item)
            local icons = Icons.cmp
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = { ghost_text = { hl_group = 'CmpGhostText' } },
        sorting = defaults.sorting,
        mapping = {
          -- TODO[2023/12/19]: fix: noice config - Calculator display.
          ['<TAB>'] = {
            i = function(fallback)
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              elseif can_execute('UltiSnips#CanJumpForwards') then
                t('<Plug>(cmpu-jump-forwards)')
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
          ['<S-TAB>'] = {
            i = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              elseif can_execute('UltiSnips#CanJumpBackwards') then
                t('<Plug>(cmpu-jump-backwards)')
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
            end,
          },
          ['<ESC>'] = function(fallback)
            if cmp.visible() then
              cmp.abort()
            else
              fallback()
            end
          end,
          [keybinds.scroll_up] = cmp.mapping.scroll_docs(-4),
          [keybinds.scroll_down] = cmp.mapping.scroll_docs(4),
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
          { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } },
        },
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'cmdline_history', priority = 100 },
          { name = 'cmdline',         priority = 90 },
          { name = 'path',            priority = 80 },
        }),
      })
    end,
  },

  -- AI completion
  {
    'zbirenbaum/copilot.lua',
    enabled = vim.g.copilot and true or false,
    cmd = 'Copilot',
    build = ':Copilot auth',
    opts = {
      suggestion = { enabled = true },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}
