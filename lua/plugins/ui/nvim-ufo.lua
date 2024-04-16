local Ascii_icons = require('util.ascii_icons').ufo
local Keys = require('keymaps')

return {
  'kevinhwang91/nvim-ufo',
  cond= vim.g.vscode == nil,
  dependencies = {
    'kevinhwang91/promise-async',
    {
      'luukvbaal/statuscol.nvim',
      config = function()
        local builtin = require('statuscol.builtin')
        require('statuscol').setup({
          relculright = true,
          segments = {
            { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
            { text = { '%s' }, click = 'v:lua.ScSa' },
            { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
          },
        })
      end,
    },
  },
  config = function()
    local ufo = require('ufo')
    local icon = vim.g.lite == nil and '  %d ...' or Ascii_icons.suffix
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (icon):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, 'MoreMsg' })
      return newVirtText
    end

    local ftMap = {
      lua = 'treesitter',
      python = { 'treesitter', 'indent' },
      git = '',
    }

    ---@diagnostic disable-next-line: missing-fields
    ufo.setup({
      fold_virt_text_handler = handler,
      open_fold_hl_timeout = 150,
      close_fold_kinds = { 'imports', 'comment' },
      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winhighlight = 'Normal:Folded',
          winblend = 0,
        },
        mappings = {
          scrollU = Keys.float_window.scroll_up,
          scrollD = Keys.float_window.scroll_down,
        },
      },
      ---@diagnostic disable-next-line: unused-local
      provider_selector = function(_bufnr_, filetype, _buftype_)
        return ftMap[filetype]
      end,
    })

    vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open All Folds' })
    vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close All Folds' })
    vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds, { desc = 'Open Folds' })
    -- vim.keymap.set('n', 'zm', ufo.closeFoldWith, { desc = "Close Fold With" })
    vim.keymap.set('n', 'K', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = 'Peek Folded Lines' })
  end,
}