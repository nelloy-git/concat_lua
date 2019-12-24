local FrameUtils = {}

---@param fdf_object FdfObjectRuntime
---@return boolean
function FrameUtils.isSimpleFdf(fdf_object)
    if string.sub(fdf_object.base_name, 1, 6) == 'SIMPLE' then
        return true
    end
    return false
end

return FrameUtils