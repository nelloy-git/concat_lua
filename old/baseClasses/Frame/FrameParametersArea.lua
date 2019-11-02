
---@class FrameParametersArea
local FrameParametersArea = {
    __type = 'FrameParametersAreaClass'
}

local FrameParametersArea_meta = {
    __type = 'FrameParametersArea',
    __index = FrameParametersArea,
}

local initialized = false
function FrameParametersArea.init()
    if initialized then return nil end

    local toc_file = "war3mapImported\\frameFiles\\Inventory\\Inventory.toc"
    if not BlzLoadTOCFile(toc_file) then
        error('Error while loading '..toc_file)
        return nil
    end
    
    initialized = true
end