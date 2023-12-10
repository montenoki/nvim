local uConfig = require('uConfig')
local colorizer = requirePlugin('colorizer')

if colorizer == nil or uConfig.enable.lite_mode or not uConfig.enable.colorizer then
    return
end
colorizer.setup()
