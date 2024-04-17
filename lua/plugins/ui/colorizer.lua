local Keys = require('keymaps')
local Lazyvim = require('lazyvim')
return {
  'norcalli/nvim-colorizer.lua',
  enabled = true,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
  keys = {
    {
      Keys.colorizer.toggle,
      function()
        local colorizer = require('colorizer')
        if colorizer.is_buffer_attached(0) then
          colorizer.detach_from_buffer(0)
          Lazyvim.warn('Disabled Colorizer', { title = 'Option' })
        else
          colorizer.attach_to_buffer(0)
          Lazyvim.info('Enabled Colorizer', { title = 'Option' })
        end
      end,
      desc = 'Toggle Colorizer',
    },
  },
}
