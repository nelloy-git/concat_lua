--=========
-- Include
--=========


--=======
-- Class
--=======

---@type FrameTypeClass
local FrameType = newClass('FrameType')

---@class FrameType
local public = FrameType.public
---@class FrameTypeClass
local static = FrameType.static
---@type table
local override = FrameType.override
---@type table(FrameType, table)
local private = {}

--=========
-- Methods
--=========

---@param name string
---@param instance_data table | nil
---@return FrameType
function static.new(name, instance_data)
    local instance = instance_data or newInstanceData(FrameType)
    local priv = {
        name = name,
        use_create_by_type = false
    }
    private[instance] = priv

    return instance
end

function public:free()
   private[self] = nil
   freeInstanceData(self)
end

---@param parent framehandle
---@return framehandle
function public:createInstance(parent)
    local priv = private[self]
    if priv.use_create_by_type then
        return BlzCreateFrameByType(priv.name, priv.name, parent, '', 0)
    else
        return BlzCreateFrame(priv.name, parent, 0, 0)
    end
end

---@param name string
function private.new(name)
    local instance = newInstanceData(FrameType)
    local priv = {
        name = name,
        use_create_by_type = true
    }
    private[instance] = priv

    return instance
end

static.BACKDROP = private.new("BACKDROP")
static.BUTTON = private.new("BUTTON")
static.CHATDISPLAY = private.new("CHATDISPLAY")
static.CHECKBOX = private.new("CHECKBOX")
static.CONTROL = private.new("CONTROL")
static.DIALOG = private.new("DIALOG")
static.EDITBOX = private.new("EDITBOX")
static.FRAME = private.new("FRAME")
static.GLUEBUTTON = private.new("GLUEBUTTON")
static.GLUECHECKBOX = private.new("GLUECHECKBOX")
static.GLUEEDITBOX = private.new("GLUEEDITBOX")
static.GLUEPOPUPMENU = private.new("GLUEPOPUPMENU")
static.GLUETEXTBUTTON = private.new("GLUETEXTBUTTON")
static.HIGHLIGHT = private.new("HIGHLIGHT")
static.LISTBOX = private.new("LISTBOX")
static.MENU = private.new("MENU")
static.MODEL = private.new("MODEL")
static.POPUPMENU = private.new("POPUPMENU")
static.SCROLLBAR = private.new("SCROLLBAR")
static.SLASHCHATBOX = private.new("SLASHCHATBOX")
static.SLIDER = private.new("SLIDER")
static.TEXT = private.new("TEXT")
static.TEXTAREA = private.new("TEXTAREA")
static.TEXTBUTTON = private.new("TEXTBUTTON")
static.TIMERTEXT = private.new("TIMERTEXT")
static.SPRITE = private.new("SPRITE")

return FrameType