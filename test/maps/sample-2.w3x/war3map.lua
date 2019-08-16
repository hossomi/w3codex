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

function InitUpgrades_Player0()
    SetPlayerTechMaxAllowed(Player(0), FourCC("Rhme"), 2)
    SetPlayerTechResearched(Player(0), FourCC("Rhme"), 1)
    SetPlayerTechResearched(Player(0), FourCC("Rhra"), 3)
end

function InitUpgrades_Player1()
    SetPlayerTechMaxAllowed(Player(1), FourCC("Rhme"), 1)
    SetPlayerTechResearched(Player(1), FourCC("Rhra"), 3)
end

function InitUpgrades_Player2()
    SetPlayerTechMaxAllowed(Player(2), FourCC("Rhme"), 1)
    SetPlayerTechResearched(Player(2), FourCC("Rhra"), 3)
end

function InitUpgrades()
    InitUpgrades_Player0()
    InitUpgrades_Player1()
    InitUpgrades_Player2()
end

function InitTechTree_Player0()
    SetPlayerAbilityAvailable(Player(0), FourCC("AHav"), false)
    SetPlayerAbilityAvailable(Player(0), FourCC("AHbn"), false)
    SetPlayerTechMaxAllowed(Player(0), FourCC("hpea"), 0)
    SetPlayerTechMaxAllowed(Player(0), FourCC("hkni"), 0)
end

function InitTechTree_Player1()
    SetPlayerAbilityAvailable(Player(1), FourCC("AHav"), false)
    SetPlayerAbilityAvailable(Player(1), FourCC("AHbn"), false)
    SetPlayerTechMaxAllowed(Player(1), FourCC("hfoo"), 0)
    SetPlayerTechMaxAllowed(Player(1), FourCC("hkni"), 0)
end

function InitTechTree_Player2()
    SetPlayerAbilityAvailable(Player(2), FourCC("AHav"), false)
    SetPlayerAbilityAvailable(Player(2), FourCC("AHbn"), false)
    SetPlayerTechMaxAllowed(Player(2), FourCC("hfoo"), 0)
    SetPlayerTechMaxAllowed(Player(2), FourCC("hkni"), 0)
end

function InitTechTree()
    InitTechTree_Player0()
    InitTechTree_Player1()
    InitTechTree_Player2()
end

function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    ForcePlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(1), 1)
    ForcePlayerStartLocation(Player(1), 1)
    SetPlayerColor(Player(1), ConvertPlayerColor(1))
    SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(1), true)
    SetPlayerController(Player(1), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(2), 2)
    ForcePlayerStartLocation(Player(2), 2)
    SetPlayerColor(Player(2), ConvertPlayerColor(2))
    SetPlayerRacePreference(Player(2), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(2), true)
    SetPlayerController(Player(2), MAP_CONTROL_USER)
end

function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
    SetPlayerTeam(Player(1), 0)
    SetPlayerTeam(Player(2), 0)
end

function InitAllyPriorities()
    SetStartLocPrioCount(0, 1)
    SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_LOW)
    SetStartLocPrioCount(1, 2)
    SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_LOW)
    SetStartLocPrio(1, 1, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(2, 2)
    SetStartLocPrio(2, 0, 0, MAP_LOC_PRIO_LOW)
    SetStartLocPrio(2, 1, 1, MAP_LOC_PRIO_HIGH)
end

function main()
    SetCameraBounds(-3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -7680.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 7168.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 7168.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -7680.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("SunkenRuinsDay")
    SetAmbientNightSound("SunkenRuinsNight")
    SetMapMusic("Music", true, 0)
    InitUpgrades()
    InitTechTree()
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
    RunInitializationTriggers()
end

function config()
    SetMapName("TRIGSTR_005")
    SetMapDescription("TRIGSTR_007")
    SetPlayers(3)
    SetTeams(3)
    SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    DefineStartLocation(0, 0.0, 0.0)
    DefineStartLocation(1, -1024.0, 960.0)
    DefineStartLocation(2, 1024.0, -1024.0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    SetPlayerSlotAvailable(Player(1), MAP_CONTROL_USER)
    SetPlayerSlotAvailable(Player(2), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
    InitAllyPriorities()
end

