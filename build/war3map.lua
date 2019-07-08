do
  function require(module)
    module = module:gsub("%.", "_")
    local func = _G[module.."_return"]
    if (func == nil) then
      return nil
    end
    return func()
  end
end
do
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
  function ObjEdit.parse(bytes)
    local parsed = {}
    parsed.diffs_count = bytes.sub(13, 16)
  end
  function modules_compiletime_return()
    return ObjEdit
  end
end
do
  local obj = require("modules.compiletime")
  function print_file(path)
    local a = 257
    local b = obj.int2lend(a)
    print(obj.to_hex(b, 16))
    b = obj.lend2int(b)
    print(b)
    return nil
  end
  local p = nil
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
end