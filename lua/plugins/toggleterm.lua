return {
  'akinsho/toggleterm.nvim',
  version = '*',
  lazy = false,
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = '<c-\\>',
    insert_mappings = true,
    start_in_insert = true,
    terminal_mappings = true,
  },
  init = function()
    local Terminal = require('toggleterm.terminal').Terminal
    local gitui = Terminal:new({
      cmd = 'gitui',
      dir = 'git_dir',
      direction = 'float',
      float_opts = {
        border = 'double',
      },
      on_open = function(term)
        vim.cmd('startinsert!')
        local opt = { noremap = true, silent = true }
        -- q / <leader>tg 关闭 terminal
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<CMD>close<CR>', opt)
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', '<A-g>', '<CMD>close<CR>', opt)
        -- ESC ���取消，留给gitui
        if vim.fn.mapcheck('<Esc>', 't') ~= '' then
          vim.api.nvim_del_keymap('t', '<Esc>')
        end
      end,
      on_close = function(_)
        -- 添加回来
        local opt = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', opt)
      end,
    })
    local terms = {}

    function _G.term_toggle(style)
      local number = vim.v.count
      if terms[number] == nil then
        terms[number] = Terminal:new({})
      end
      terms[number].direction = style
      terms[number].id = number
      terms[number]:toggle()

      local venv = require('venv-selector').get_active_venv()
      local os_name = vim.loop.os_uname().sysname
      if venv ~= nil then
        local cmd
        if string.find(os_name, 'Windows') then
          cmd = venv .. 'Scripts\\activate.ps1'
          vim.cmd(number .. "TermExec cmd='" .. cmd .. "'")
        else
          cmd = 'source ' .. venv .. '/bin/activate;'
          vim.cmd(number .. [[TermExec cmd=']] .. cmd .. "'")
        end
      end
    end

    function _G.gitui_toggle()
      gitui:toggle()
    end

    vim.keymap.set({ 'n' }, 'tg', '<CMD>lua gitui_toggle()<CR>', { desc = 'Toggle GitUI' })
    vim.keymap.set({ 'n' }, 'tt', '<CMD>lua term_toggle([[horizontal]])<CR>', { desc = 'Toggle Terimal Bottom' })
    vim.keymap.set({ 'n' }, 'tf', '<CMD>lua term_toggle([[float]])<CR>', { desc = 'Toggle Terimal float' })
    vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', { desc = 'Quit Terminal' })
  end,
}
