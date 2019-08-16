gg_trg_Melee_Initialization = nil
gg_rg_000 = __jarray(0)
gg_rg_001 = __jarray(0)
gg_rg_002 = __jarray(0)
function InitGlobals()
end

function InitRandomGroups()
    local curset
    RandomDistReset()
    RandomDistAddItem(0, 34)
    RandomDistAddItem(1, 33)
    RandomDistAddItem(2, 33)
    curset = RandomDistChoose()
    if (curset == 0) then
        gg_rg_000[0] = FourCC("nanb")
        gg_rg_000[1] = FourCC("ngme")
        gg_rg_000[2] = FourCC("ratf")
    elseif (curset == 1) then
        gg_rg_000[0] = ChooseRandomCreep(-1)
        gg_rg_000[1] = ChooseRandomNPBuilding()
        gg_rg_000[2] = ChooseRandomItemEx(ITEM_TYPE_ANY, -1)
    elseif (curset == 2) then
        gg_rg_000[0] = ChooseRandomCreep(10)
        gg_rg_000[1] = -1
        gg_rg_000[2] = ChooseRandomItemEx(ITEM_TYPE_ARTIFACT, 5)
    else
        gg_rg_000[0] = -1
        gg_rg_000[1] = -1
        gg_rg_000[2] = -1
    end
    RandomDistReset()
    RandomDistAddItem(0, 75)
    RandomDistAddItem(-1, 25)
    curset = RandomDistChoose()
    if (curset == 0) then
        gg_rg_001[0] = FourCC("nplb")
    else
        gg_rg_001[0] = -1
    end
    RandomDistReset()
    RandomDistAddItem(0, 100)
    curset = RandomDistChoose()
    if (curset == 0) then
        gg_rg_002[0] = FourCC("nbda")
        gg_rg_002[1] = FourCC("ckng")
    else
        gg_rg_002[0] = -1
        gg_rg_002[1] = -1
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
        RandomDistReset()
        RandomDistAddItem(ChooseRandomItemEx(ITEM_TYPE_POWERUP, 4), 50)
        RandomDistAddItem(-1, 50)
        itemID = RandomDistChoose()
        if (trigUnit ~= nil) then
            UnitDropItem(trigUnit, itemID)
        else
            WidgetDropItem(trigWidget, itemID)
        end
        RandomDistReset()
        RandomDistAddItem(gg_rg_000[2], 40)
        RandomDistAddItem(gg_rg_002[1], 60)
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

function ItemTable000001_DropItems()
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
        RandomDistAddItem(ChooseRandomItemEx(ITEM_TYPE_ANY, -1), 1)
        RandomDistAddItem(ChooseRandomItemEx(ITEM_TYPE_PERMANENT, -1), 2)
        RandomDistAddItem(ChooseRandomItemEx(ITEM_TYPE_CHARGED, -1), 3)
        RandomDistAddItem(ChooseRandomItemEx(ITEM_TYPE_POWERUP, -1), 4)
        RandomDistAddItem(ChooseRandomItemEx(ITEM_TYPE_ARTIFACT, -1), 5)
        RandomDistAddItem(ChooseRandomItemEx(ITEM_TYPE_PURCHASABLE, -1), 6)
        RandomDistAddItem(ChooseRandomItemEx(ITEM_TYPE_CAMPAIGN, -1), 7)
        RandomDistAddItem(ChooseRandomItemEx(ITEM_TYPE_MISCELLANEOUS, -1), 8)
        RandomDistAddItem(-1, 64)
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
    SetCameraBounds(-3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("IceCrownDay")
    SetAmbientNightSound("IceCrownNight")
    SetMapMusic("Music", true, 0)
    InitRandomGroups()
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
    DefineStartLocation(0, 0.0, 0.0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
end

