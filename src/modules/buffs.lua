local Debug = require('utils.debugMsg')

local BuffKeeper = {
    callback_timer = nil
}

function BuffKeeper.init(callback_timer)
    if BuffKeeper.callback_timer ~= nil then
        Debug.print('BuffKeeper initialized more then one time.')
        return
    end
    BuffKeeper.callback_timer = callback_timer
end

return BuffKeeper