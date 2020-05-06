--=========
-- Include
--=========

local Class = require(Lib.Class)

--=======
-- Class
--=======

local Time = Class.new('Time')
---@class Time
local public = Time.public
---@class TimeClass
local static = Time.static
---@type TimeClass
local override = Time.override
local private = {}

--=========
-- Static
--=========

function override.init()
    private.start_time = os.time()
end

---@return number
function static.get()
    if private.start_time < 0 then
        static.init()
    end
    return os.time() - private.start_time
end

--=========
-- Private
--=========

private.start_time = -1

return static