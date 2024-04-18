return {
  'folke/trouble.nvim',
  branch = 'dev',
  cond = false,
  cmd = { 'TroubleToggle', 'Trouble' },
  opts = { use_diagnostic_signs = true },
  keys = {
    {
      '<LEADER>xx',
      '<CMD>TroubleToggle document_diagnostics<CR>',
      desc = 'Document Diagnostics (Trouble)',
    },
    {
      '<LEADER>xX',
      '<CMD>TroubleToggle workspace_diagnostics<CR>',
      desc = 'Workspace Diagnostics (Trouble)',
    },
    {
      '<LEADER>xl',
      '<CMD>TroubleToggle loclist<CR>',
      desc = 'Location List (Trouble)',
    },
    {
      '<LEADER>xq',
      '<CMD>TroubleToggle quickfix<CR>',
      desc = 'Quickfix List (Trouble)',
    },
    {
      '[q',
      function()
        if require('trouble').is_open() then
          require('trouble').previous({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = 'Previous trouble/quickfix item',
    },
    {
      ']q',
      function()
        if require('trouble').is_open() then
          require('trouble').next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = 'Next trouble/quickfix item',
    },
  },
}
