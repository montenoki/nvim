local icons = require('config').icons
local keymaps = require('keymaps')

local function t(keys)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), 'm', true)
end
local function can_execute(arg)
  return vim.fn[arg]() == 1
end

return {
  'hrsh7th/nvim-cmp',
  version = false, -- last release is way too old
  event = { 'InsertEnter', 'CmdlineEnter' },
  cond = vim.g.vscode == nil,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-emoji',
    'f3fora/cmp-spell',
    'dmitmel/cmp-cmdline-history',
    'SirVer/ultisnips',
    'quangnguyen30192/cmp-nvim-ultisnips',
    'montenoki/vim-snippets',
  },
  opts = function()
    vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
    local cmp = require('cmp')
    local defaults = require('cmp.config.default')()
    local sources = {
      { name = 'ultisnips', priority = 100 },
      { name = 'nvim_lsp', priority = 90 },
      {
        name = 'buffer',
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
          -- keyword_pattern = [=[[^[:blank:]].*]=],
          keyword_pattern = [[\k\+]],
        },
        priority = 70,
      },
      { name = 'nvim_lsp_signature_help', priority = 60 },
      {
        name = 'spell',
        option = {
          keep_all_entries = false,
          enable_in_context = function()
            return true
          end,
        },
      },
      { name = 'path', priority = 40 },
      { name = 'emoji' },
    }
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
          if icons.kinds[item.kind] and vim.g.lite == nil then
            item.kind = cmp_icons[item.kind] .. item.kind
          end
          return item
        end,
      },
      experimental = { ghost_text = { hl_group = 'CmpGhostText' } },
      sorting = defaults.sorting,
      mapping = {
        [keymaps.cmp.next_jump] = {
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
        [keymaps.cmp.prev_jump] = {
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
        [keymaps.cmp.confirm] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = false,
        }),
        [keymaps.cmp.toggle] = {
          i = function()
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end,
        },
        [keymaps.cmp.esc] = function(fallback)
          if cmp.visible() then
            cmp.abort()
          else
            fallback()
          end
        end,
        [keymaps.floatWindow.scrollUp] = cmp.mapping.scroll_docs(-4),
        [keymaps.floatWindow.scrollDown] = cmp.mapping.scroll_docs(4),
      },
    }
  end,
  config = function(_, opts)
    local cmp = require('cmp')
    for i, source in ipairs(opts.sources) do
      source.group_index = source.group_index or i
    end
    cmp.setup(opts)
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'nvim_lsp_document_symbol' },
        {
          name = 'buffer',
          option = { keyword_pattern = [=[[^[:blank:]].*]=] },
        },
      },
    })
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'cmdline', priority = 100 },
        { name = 'path', priority = 50 },
        { name = 'cmdline_history', priority = 0 },
      }),
    })
  end,
}
