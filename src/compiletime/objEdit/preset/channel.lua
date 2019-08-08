---@type ChannelWeAbility
local ChannelAbil = require('compiletime.objEdit.objects.ability.weChannel')
---@type WeUtils
local WeUtils = require('compiletime.objEdit.weUtils')

---@class ChannelWePreset
local ChannelWePreset = {}

---@param id string
---@param target_type string | 'none' | 'unit' | 'point' | 'point_or_unit'
---@param is_visible boolean
---@param is_area boolean
---@param is_material boolean
---@param is_universal boolean
---@param is_group boolean
---@return ChannelWeAbility|nil
function ChannelWePreset.new(id, order_id, lvls, target_type, is_visible, is_area, is_material, is_universal, is_group)
    if is_compiletime then
        ---@type ChannelWeAbility
        local abil = ChannelAbil.new(id)

        local options = 0
        if is_visible then options = options + ChannelAbil.visible end
        if is_area then options = options + ChannelAbil.areaTarget end
        if is_material then options = options + ChannelAbil.matereal end
        if is_universal then options = options + ChannelAbil.universal end
        if is_group then options = options + ChannelAbil.group end

        abil:setArtCaster('')
        abil:setArtEffect('')
        abil:setArtSpecial('')
        abil:setArtTarget('')
        abil:setLevels(lvls)
        for i = 1, lvls do
            abil:setOptions(options, i)
            abil:setTargetType(target_type, i)
            abil:setDisableOtherAbilities(false, i)
            abil:setFollowThroughTime(0., i)
            abil:setBaseOrderID(order_id, i)
        end

        return abil
    else
        ---@type Utils
        local utils = require('utils.utils')
        print('Can generate ability only in compiletime.')
        print(utils.getErrorPos())
        return nil
    end
end

return ChannelWePreset