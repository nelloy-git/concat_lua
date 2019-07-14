  __require_data = {loaded = {}, module = {}, result = {}}
  function require(name)
    if (not __require_data.loaded[name]) then
      __require_data.result[name] = __require_data.module[name]()
      __require_data.loaded[name] = true
    end
    return __require_data.result[name]
  end
__require_data.module["compiletime_modules.wc3_object"] = function()
    local EditObjects = {}
    local ReadFile = require("compiletime_modules.file_reader")
    function EditObjects.createObject(id, base_id)
      local obj = {id = id, base_id = base_id, changes = {}}
      return obj
    end
    function EditObjects.writeObject(obj, file)
      local changes_count = ReadFile.getChangesCount(file)
      file = ReadFile.setChangesCount(changes_count+1, file)
      file = file..obj.id..obj.base_id..ReadFile.int2lend(#obj.changes)
      print("Created object with id: "..obj.base_id.." (", ReadFile.to_hex(obj.id, 5), ")")
      return file
    end
    return EditObjects
end
__require_data.module["compiletime_modules.file_reader"] = function()
    local ObjEdit = {}
    function ObjEdit.read(path)
      local f = assert(io.open(path, "rb"))
      local t = f:read("*all")
      f:close()
      return t
    end
    function ObjEdit.to_hex(str, bytes_per_line)
      local res = ""
      for i = 1, str:len() do
        local c = str:sub(i, i)
        res = res.." "..string.format("%02x", c:byte())
        if (i%bytes_per_line == 0) then
          res = res.."\n"
        end
      end
      return res
    end
    function ObjEdit.int2lend(val)
      local bytes = ""
      for i = 0, 3 do
        bytes = bytes..string.char(val >> 8*i&255)
      end
      return bytes
    end
    function ObjEdit.lend2int(bytes)
      local res = 0
      for i = 0, 3 do
        res = res << 8
        res = res+bytes:sub(#bytes-i, #bytes-i):byte()
      end
      return res
    end
    function ObjEdit.getChangesCount(file)
      return ObjEdit.lend2int(file:sub(9, 12))
    end
    function ObjEdit.setChangesCount(count, file)
      local count_bytes = ObjEdit.int2lend(count)
      file = file:sub(1, 8)..count_bytes..file:sub(13)
      return file
    end
    return ObjEdit
end
__require_data.module["compiletime_modules.entrance"] = function()
    local FileReader = require("compiletime_modules.file_reader")
    local ObjEdit = require("compiletime_modules.wc3_object")
    local w3u_file = FileReader.read(__src_dir.."\\war3map.w3u")
    local obj = ObjEdit.createObject("A001", "hfoo")
    w3u_file = ObjEdit.writeObject(obj, w3u_file)
    print(FileReader.to_hex(w3u_file, 16))
    return nil
end
  local glTimer = nil
  function showText_callback(user_data)
    DisplayTextToPlayer(user_data.player, 0, 0, user_data.text)
  end
  gg_trg_Melee_Initialization = nil
  function InitGlobals()

  end
  function Trig_Melee_Initialization_Actions()
    MeleeStartingVisibility()
    MeleeStartingHeroLimit()
    MeleeGrantHeroItems()
    MeleeStartingResources()
    MeleeClearExcessUnits()
    MeleeStartingUnits()
    MeleeStartingAI()
    MeleeInitVictoryDefeat()
    glTimer.init(0.1)
    glTimer.addAction(3, showText_callback, {player = Player(0), text = "Delayed text"})
  end
  function InitTrig_Melee_Initialization()
    gg_trg_Melee_Initialization = CreateTrigger()
    TriggerAddAction(gg_trg_Melee_Initialization, Trig_Melee_Initialization_Actions)
  end
  function InitCustomTriggers()
    InitTrig_Melee_Initialization()
  end
  function RunInitializationTriggers()
    ConditionalTriggerExecute(gg_trg_Melee_Initialization)
  end
  function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
  end
  function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
  end
  function main()
    SetCameraBounds(-3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0-GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0+GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0-GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0-GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0+GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("LordaeronSummerDay")
    SetAmbientNightSound("LordaeronSummerNight")
    SetMapMusic("Music", true, 0)
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
    RunInitializationTriggers()
  end
  function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(1)
    SetTeams(1)
    SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
    DefineStartLocation(0, -1953.6, -3131.3)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
  end