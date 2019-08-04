gg_trg_Melee_Initialization = nil
gg_rg_000 = __jarray(0)
gg_rg_001 = __jarray(0)
function InitGlobals()
end

function InitRandomGroups()
    local curset
    RandomDistReset()
    RandomDistAddItem(0, 50)
    RandomDistAddItem(1, 50)
    curset = RandomDistChoose()
    if (curset == 0) then
        gg_rg_000[0] = FourCC("nanb")
        gg_rg_000[1] = FourCC("ratf")
        gg_rg_000[2] = FourCC("ngme")
    elseif (curset == 1) then
        gg_rg_000[0] = FourCC("nbda")
        gg_rg_000[1] = -1
        gg_rg_000[2] = FourCC("ntav")
    else
        gg_rg_000[0] = -1
        gg_rg_000[1] = -1
        gg_rg_000[2] = -1
    end
    RandomDistReset()
    RandomDistAddItem(0, 100)
    curset = RandomDistChoose()
    if (curset == 0) then
        gg_rg_001[0] = ChooseRandomCreep(13)
        gg_rg_001[1] = ChooseRandomNPBuilding()
        gg_rg_001[2] = ChooseRandomItemEx(ITEM_TYPE_CHARGED, 8)
    else
        gg_rg_001[0] = -1
        gg_rg_001[1] = -1
        gg_rg_001[2] = -1
    end
end

function ItemTable000000_DropItems()
    local trigWidget = nil
    local trigUnit = nil
    local itemID = 0
    local canDrop = true
    trigWidget = bj_lastDyingWidget
    if (trigWidget == nil) then
        trigUnit = GetTriggerUnit()
    end
    if (trigUnit ~= nil) then
        canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() ~= nil) then
            canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        end
    end
    if (canDrop) then
        RandomDistReset()
        RandomDistAddItem(FourCC("ratf"), 50)
        RandomDistAddItem(FourCC("ckng"), 50)
        itemID = RandomDistChoose()
        if (trigUnit ~= nil) then
            UnitDropItem(trigUnit, itemID)
        else
            WidgetDropItem(trigWidget, itemID)
        end
    end
    bj_lastDyingWidget = nil
    DestroyTrigger(GetTriggeringTrigger())
end

function CreateAllItems()
    local itemID
    itemID = gg_rg_000[1]
    if (itemID ~= -1) then
        CreateItem(itemID, -2.8, -508.2)
    end
end

function CreateNeutralHostile()
    local p = Player(PLAYER_NEUTRAL_AGGRESSIVE)
    local u
    local unitID
    local t
    local life
    unitID = gg_rg_000[0]
    if (unitID ~= -1) then
        u = CreateUnit(p, unitID, 511.6, 3.8, 176.510)
    end
    u = CreateUnit(p, FourCC("ntkf"), -3.5, 517.1, 180.000)
    t = CreateTrigger()
    TriggerRegisterUnitEvent(t, u, EVENT_UNIT_DEATH)
    TriggerRegisterUnitEvent(t, u, EVENT_UNIT_CHANGE_OWNER)
    TriggerAddAction(t, ItemTable000000_DropItems)
end

function CreateNeutralPassiveBuildings()
    local p = Player(PLAYER_NEUTRAL_PASSIVE)
    local u
    local unitID
    local t
    local life
    unitID = gg_rg_000[2]
    if (unitID ~= -1) then
        u = CreateUnit(p, unitID, -512.0, 0.0, 270.000)
    end
end

function CreatePlayerBuildings()
end

function CreatePlayerUnits()
end

function CreateAllUnits()
    CreateNeutralPassiveBuildings()
    CreatePlayerBuildings()
    CreateNeutralHostile()
    CreatePlayerUnits()
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
    SetPlayerTechMaxAllowed(Player(0), FourCC("Rhme"), 1)
end

function InitUpgrades_Player1()
    SetPlayerTechMaxAllowed(Player(1), FourCC("Rhme"), 1)
end

function InitUpgrades()
    InitUpgrades_Player0()
    InitUpgrades_Player1()
end

function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(1), 1)
    SetPlayerColor(Player(1), ConvertPlayerColor(1))
    SetPlayerRacePreference(Player(1), RACE_PREF_ORC)
    SetPlayerRaceSelectable(Player(1), true)
    SetPlayerController(Player(1), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(23), 2)
    ForcePlayerStartLocation(Player(23), 2)
    SetPlayerColor(Player(23), ConvertPlayerColor(23))
    SetPlayerRacePreference(Player(23), RACE_PREF_NIGHTELF)
    SetPlayerRaceSelectable(Player(23), true)
    SetPlayerController(Player(23), MAP_CONTROL_NEUTRAL)
end

function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
    SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(1), 0)
    SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(23), 0)
    SetPlayerState(Player(23), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(23), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(23), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    SetPlayerAllianceStateVisionBJ(Player(0), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(1), Player(23), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(0), true)
    SetPlayerAllianceStateVisionBJ(Player(23), Player(1), true)
    SetPlayerAllianceStateControlBJ(Player(0), Player(1), true)
    SetPlayerAllianceStateControlBJ(Player(0), Player(23), true)
    SetPlayerAllianceStateControlBJ(Player(1), Player(0), true)
    SetPlayerAllianceStateControlBJ(Player(1), Player(23), true)
    SetPlayerAllianceStateControlBJ(Player(23), Player(0), true)
    SetPlayerAllianceStateControlBJ(Player(23), Player(1), true)
    SetPlayerAllianceStateFullControlBJ(Player(0), Player(1), true)
    SetPlayerAllianceStateFullControlBJ(Player(0), Player(23), true)
    SetPlayerAllianceStateFullControlBJ(Player(1), Player(0), true)
    SetPlayerAllianceStateFullControlBJ(Player(1), Player(23), true)
    SetPlayerAllianceStateFullControlBJ(Player(23), Player(0), true)
    SetPlayerAllianceStateFullControlBJ(Player(23), Player(1), true)
end

function InitAllyPriorities()
    SetStartLocPrioCount(0, 1)
    SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(1, 1)
    SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
end

function main()
    SetCameraBounds(-1280.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -1536.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 1280.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 1024.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -1280.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 1024.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 1280.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -1536.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("IceCrownDay")
    SetAmbientNightSound("IceCrownNight")
    SetMapMusic("Music", true, 0)
    InitUpgrades()
    InitRandomGroups()
    CreateAllItems()
    CreateAllUnits()
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
    RunInitializationTriggers()
end

function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(3)
    SetTeams(3)
    SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    DefineStartLocation(0, 0.0, 0.0)
    DefineStartLocation(1, 0.0, 0.0)
    DefineStartLocation(2, 0.0, 0.0)
    InitCustomPlayerSlots()
    InitCustomTeams()
    InitAllyPriorities()
end

