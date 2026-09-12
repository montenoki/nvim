local ok,err=xpcall(function()
 require('lazy').load({plugins={'blink.cmp'}})
 local config=require('blink.cmp.config')
 assert(config.snippets.preset=='luasnip')
 assert(config.completion.trigger.show_in_snippet==false)
 assert(config.keymap['<Tab>'][1]=='select_next')
 local ls=require('luasnip')
 vim.cmd.enew()
 vim.bo.filetype='tex'
 config.snippets.expand([[\frac{${1}}{${2}}$0]])
 local outer=ls.session.current_nodes[vim.api.nvim_get_current_buf()].parent
 local placeholder=ls.session.current_nodes[vim.api.nvim_get_current_buf()].mark:pos_begin_raw(); vim.api.nvim_win_set_cursor(0,{placeholder[1]+1,placeholder[2]})
 assert(ls.session.current_nodes[vim.api.nvim_get_current_buf()].pos==1)
 config.snippets.expand([[\frac{${1}}{${2}}$0]])
 local inner=ls.session.current_nodes[vim.api.nvim_get_current_buf()].parent

 assert(inner~=outer)
 config.snippets.jump(1)
 assert(ls.session.current_nodes[vim.api.nvim_get_current_buf()]==inner.insert_nodes[2],'inner denominator')
 config.snippets.jump(-1)
 assert(ls.session.current_nodes[vim.api.nvim_get_current_buf()]==inner.insert_nodes[1],'inner backward')
 config.snippets.jump(1)
 config.snippets.jump(1)
 if ls.session.current_nodes[vim.api.nvim_get_current_buf()]~=outer.insert_nodes[2] then config.snippets.jump(1) end
 assert(ls.session.current_nodes[vim.api.nvim_get_current_buf()]==outer.insert_nodes[2],'return outer denominator')
print(vim.inspect(vim.api.nvim_buf_get_lines(0,0,-1,false)))
 assert(vim.api.nvim_get_current_line()==[[\frac{\frac{}{}}{}]])
 print('PASS: actual Blink LuaSnip integration, nested fractions, backward jump, return to outer placeholder')
end,debug.traceback)
if not ok then print(err) end
vim.cmd(ok and 'qa!' or 'cq!')
