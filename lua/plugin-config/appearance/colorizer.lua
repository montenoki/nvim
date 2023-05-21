local uConfig = require('uConfig')
if uConfig.lite_mode then
    return
else
    require('colorizer').setup()
end
