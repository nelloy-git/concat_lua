local Frame = {
    __type = "FrameClass",
}

local Frame_meta = {
    __type = "Frame",
    __index = Frame
}

function Frame.new()
    local frame = {
        __frame_obj = BlzCreateFrameByType(frame_type, name, )
    }
end

return Frame