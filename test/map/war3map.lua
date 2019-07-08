udg__UnitType = 0
udg__Unit = nil
udg__CasterUnit = nil
udg__TargetUnit = nil
udg__Player = nil
udg__Point = nil
udg__UnitGroup = nil
udg__Integer = 0
udg__Real = 0.0
udg__Ability = nil
udg__AbilityCode = 0
udg_Sorceress_Dest_Equip = __jarray(0)
udg_Sorceress_Dest_Spell = __jarray(0)
udg__PlayerGroup = nil
udg_Challenge_Hex_RabbitUnit = nil
udg_Challenge_Hex_WolfUnit = nil
udg_Challenge_Hex_HutUnit = {}
udg_Challenge_Hex_Boolean = false
udg__Item = nil
udg_Challenge_Hex_EggsDelivered = 0
udg_Player_HeroUnit = {}
udg_Player_HeroType = __jarray(0)
udg_HeroDeath_Timer = {}
udg_HeroDeath_Boolean = __jarray(false)
udg_Player_HeroWisp = {}
udg_PlayerColor_String = __jarray("")
udg_Player_Name = __jarray("")
udg__String = ""
udg_ItemDrop_Hashtable = nil
gg_rct_Miniboss_00a = nil
gg_rct_Gate_00 = nil
gg_rct_Challenge_00_Area = nil
gg_rct_Challenge_00_Entrance = nil
gg_rct_Challenge_00_Exit = nil
gg_rct_Challenge_00_Fail = nil
gg_rct_Challenge_00_Arena = nil
gg_rct_Miniboss_00b = nil
gg_rct_NPC_00 = nil
gg_rct_Gate_01 = nil
gg_rct_Butcher_Zone = nil
gg_snd_Wolf1 = nil
gg_snd_GameStart = nil
gg_snd_GoodJob = nil
gg_snd_QuestCompleted = nil
gg_snd_QuestFailed = nil
gg_snd_QuestNew = nil
gg_snd_Rescue = nil
gg_snd_Warning = nil
gg_snd_ClockwerkGoblinDeath1 = nil
gg_snd_ButcherIntro = nil
gg_trg_General_Init = nil
gg_trg_HP_Enemy_Dies = nil
gg_trg_HS_Spawn_Selectors = nil
gg_trg_HS_Select_Heroes = nil
gg_trg_HS_Spawn_Heroes = nil
gg_trg_HD_Spawn_Wisp = nil
gg_trg_HD_Wisp_Timer = nil
gg_trg_CS_Init = nil
gg_trg_CS_Detector_Dies = nil
gg_trg_CS_Spawn_Zombie = nil
gg_trg_CS_Spawn_Murgul = nil
gg_trg_TES_INIT = nil
gg_trg_Ranger_Focus = nil
gg_trg_Battle_Frenzy = nil
gg_trg_Combustion = nil
gg_trg_Equip_Destruction_Spell = nil
gg_trg_Spell_Book_Learn = nil
gg_trg_Change_List = nil
gg_trg_Ammo_Equip = nil
gg_trg_Ammo_Level = nil
gg_trg_Shadow_Strike = nil
gg_trg_Holy_Light = nil
gg_trg_Resurrection = nil
gg_trg_Hex_INIT = nil
gg_trg_Hex_Entrance = nil
gg_trg_Hex_Fail = nil
gg_trg_Hex_Egg_Get = nil
gg_trg_Hex_Egg_Deliver = nil
gg_trg_Hex_Update = nil
gg_trg_SecretHero = nil
gg_trg_Debug = nil
gg_trg_NPC_00_Greet = nil
gg_trg_NPC_00_Sell = nil
gg_trg_Miniboss_00a_Start = nil
gg_trg_Gate_00 = nil
gg_trg_Gate_01 = nil
gg_unit_u003_0044 = nil
gg_unit_u003_0043 = nil
gg_unit_u003_0039 = nil
gg_unit_u003_0040 = nil
gg_unit_u003_0041 = nil
gg_unit_u003_0042 = nil
gg_unit_u006_0002 = nil
gg_dest_ATg4_0000 = nil
gg_dest_Ytlc_0660 = nil
gg_dest_DTg3_0657 = nil
gg_dest_Ytlc_0658 = nil
gg_dest_Ytlc_0659 = nil
gg_dest_DTg1_0090 = nil
gg_dest_DTg2_0091 = nil
function InitGlobals()
    local i = 0
    udg__UnitGroup = CreateGroup()
    udg__Integer = 0
    udg__Real = 0.0
    udg__PlayerGroup = CreateForce()
    udg_Challenge_Hex_Boolean = false
    udg_Challenge_Hex_EggsDelivered = 0
    i = 0
    while (true) do
        if ((i > 4)) then break end
        udg_HeroDeath_Timer[i] = CreateTimer()
        i = i + 1
    end
    i = 0
    while (true) do
        if ((i > 4)) then break end
        udg_HeroDeath_Boolean[i] = false
        i = i + 1
    end
    i = 0
    while (true) do
        if ((i > 4)) then break end
        udg_PlayerColor_String[i] = ""
        i = i + 1
    end
    i = 0
    while (true) do
        if ((i > 4)) then break end
        udg_Player_Name[i] = ""
        i = i + 1
    end
    udg__String = ""
end

function InitSounds()
    gg_snd_Wolf1 = CreateSound("Units\\Critters\\Wolf\\Wolf1.wav", false, false, true, 10, 10, "HeroAcksEAX")
    SetSoundParamsFromLabel(gg_snd_Wolf1, "WolfWhat")
    SetSoundDuration(gg_snd_Wolf1, 2316)
    SetSoundChannel(gg_snd_Wolf1, 8)
    gg_snd_GameStart = CreateSound("Sound\\Interface\\ArrangedTeamInvitation.wav", false, false, false, 10, 10, "DefaultEAXON")
    SetSoundParamsFromLabel(gg_snd_GameStart, "ArrangedTeamInvitation")
    SetSoundDuration(gg_snd_GameStart, 2914)
    gg_snd_GoodJob = CreateSound("Sound\\Interface\\GoodJob.wav", false, false, false, 10, 10, "")
    SetSoundParamsFromLabel(gg_snd_GoodJob, "GoodJob")
    SetSoundDuration(gg_snd_GoodJob, 2548)
    gg_snd_QuestCompleted = CreateSound("Sound\\Interface\\QuestCompleted.wav", false, false, false, 10, 10, "")
    SetSoundParamsFromLabel(gg_snd_QuestCompleted, "QuestCompleted")
    SetSoundDuration(gg_snd_QuestCompleted, 5154)
    gg_snd_QuestFailed = CreateSound("Sound\\Interface\\QuestFailed.wav", false, false, false, 10, 10, "")
    SetSoundParamsFromLabel(gg_snd_QuestFailed, "QuestFailed")
    SetSoundDuration(gg_snd_QuestFailed, 4690)
    gg_snd_QuestNew = CreateSound("Sound\\Interface\\QuestNew.wav", false, false, false, 10, 10, "")
    SetSoundParamsFromLabel(gg_snd_QuestNew, "QuestNew")
    SetSoundDuration(gg_snd_QuestNew, 3750)
    gg_snd_Rescue = CreateSound("Sound\\Interface\\Rescue.wav", false, false, false, 10, 10, "")
    SetSoundParamsFromLabel(gg_snd_Rescue, "Rescue")
    SetSoundDuration(gg_snd_Rescue, 3796)
    gg_snd_Warning = CreateSound("Sound\\Interface\\Warning.wav", false, false, false, 10, 10, "")
    SetSoundParamsFromLabel(gg_snd_Warning, "Warning")
    SetSoundDuration(gg_snd_Warning, 1903)
    gg_snd_ClockwerkGoblinDeath1 = CreateSound("Units\\Creeps\\HeroTinkerRobot\\ClockwerkGoblinDeath1.wav", false, true, true, 10, 10, "DefaultEAXON")
    SetSoundParamsFromLabel(gg_snd_ClockwerkGoblinDeath1, "ClockwerkGoblinDeath")
    SetSoundDuration(gg_snd_ClockwerkGoblinDeath1, 951)
    gg_snd_ButcherIntro = CreateSound("Units\\Undead\\Abomination\\AbominationYesAttack3.wav", false, true, true, 10, 10, "DefaultEAXON")
    SetSoundParamsFromLabel(gg_snd_ButcherIntro, "AbominationYesAttack")
    SetSoundDuration(gg_snd_ButcherIntro, 1363)
end

function CreateAllDestructables()
    local d
    local t
    local life
    gg_dest_ATg4_0000 = CreateDestructable(FourCC("ATg4"), -14112.0, -14624.0, 180.000, 1.000, 0)
    gg_dest_DTg1_0090 = CreateDestructable(FourCC("DTg1"), 0.0, -17728.0, 270.000, 0.900, 0)
    gg_dest_DTg2_0091 = CreateDestructable(FourCC("DTg2"), 6304.0, -13152.0, 270.000, 1.000, 0)
    gg_dest_DTg3_0657 = CreateDestructable(FourCC("DTg3"), -13824.0, -18688.0, 0.000, 0.900, 0)
    gg_dest_Ytlc_0659 = CreateDestructable(FourCC("Ytlc"), -13696.0, -18880.0, 270.000, 1.000, 0)
    gg_dest_Ytlc_0658 = CreateDestructable(FourCC("Ytlc"), -13696.0, -18496.0, 270.000, 1.000, 0)
    gg_dest_Ytlc_0660 = CreateDestructable(FourCC("Ytlc"), -13696.0, -18688.0, 270.000, 1.000, 0)
end

function CreateBuildingsForPlayer12()
    local p = Player(12)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("n007"), -15360.0, -15872.0, 270.000)
    u = CreateUnit(p, FourCC("u000"), 3328.0, -16128.0, 270.000)
    u = CreateUnit(p, FourCC("u000"), -18176.0, -15616.0, 270.000)
    u = CreateUnit(p, FourCC("u000"), -15104.0, -18688.0, 270.000)
    u = CreateUnit(p, FourCC("u000"), -15360.0, -15104.0, 270.000)
    u = CreateUnit(p, FourCC("u000"), -14592.0, -15872.0, 270.000)
    u = CreateUnit(p, FourCC("u000"), -18176.0, -11904.0, 270.000)
    u = CreateUnit(p, FourCC("u002"), -11648.0, -18176.0, 270.000)
    u = CreateUnit(p, FourCC("u002"), -11648.0, -19200.0, 270.000)
    u = CreateUnit(p, FourCC("u002"), -8960.0, -18176.0, 270.000)
    u = CreateUnit(p, FourCC("u002"), -8960.0, -19136.0, 270.000)
    u = CreateUnit(p, FourCC("u002"), -10112.0, -18688.0, 270.000)
    u = CreateUnit(p, FourCC("u000"), -13568.0, -14080.0, 270.000)
    u = CreateUnit(p, FourCC("u000"), -3328.0, -16128.0, 270.000)
    u = CreateUnit(p, FourCC("u000"), 0.0, -13056.0, 270.000)
    u = CreateUnit(p, FourCC("u000"), 4864.0, -13056.0, 270.000)
    u = CreateUnit(p, FourCC("n007"), 7040.0, -13824.0, 270.000)
    u = CreateUnit(p, FourCC("n007"), 6656.0, -14208.0, 270.000)
end

function CreateUnitsForPlayer12()
    local p = Player(12)
    local u
    local unitID
    local t
    local life
    gg_unit_u006_0002 = CreateUnit(p, FourCC("u006"), 7060.8, -14236.8, 95.490)
    u = CreateUnit(p, FourCC("n008"), -15220.1, -15738.5, 232.688)
    u = CreateUnit(p, FourCC("n008"), -15323.9, -15668.4, 232.688)
    u = CreateUnit(p, FourCC("n008"), -15120.1, -15823.9, 232.688)
    u = CreateUnit(p, FourCC("n008"), -17717.5, -9852.6, 161.476)
    u = CreateUnit(p, FourCC("n008"), -17792.7, -9945.5, 147.280)
    u = CreateUnit(p, FourCC("n008"), -17857.6, -10036.6, 133.384)
    u = CreateUnit(p, FourCC("n008"), -18639.1, -9841.6, 17.202)
    u = CreateUnit(p, FourCC("n008"), -18560.7, -9935.5, 31.697)
    u = CreateUnit(p, FourCC("n008"), -18510.4, -10039.6, 45.652)
    u = CreateUnit(p, FourCC("u001"), -17173.4, -11302.7, 144.859)
    u = CreateUnit(p, FourCC("u001"), -17281.9, -11216.2, 169.766)
    u = CreateUnit(p, FourCC("u001"), -19023.9, -11183.6, 144.068)
    u = CreateUnit(p, FourCC("u001"), -19195.7, -11296.4, 226.358)
    u = CreateUnit(p, FourCC("u005"), -18178.2, -9728.7, 270.000)
    u = CreateUnit(p, FourCC("u001"), -14206.5, -17160.6, 172.974)
    u = CreateUnit(p, FourCC("u001"), -16635.4, -14733.6, 267.130)
    u = CreateUnit(p, FourCC("u001"), -16648.4, -14634.2, 266.262)
    u = CreateUnit(p, FourCC("u001"), -16632.9, -14830.3, 214.537)
    u = CreateUnit(p, FourCC("u001"), -14085.5, -17166.5, 72.666)
    u = CreateUnit(p, FourCC("u001"), -14341.9, -17168.6, 61.152)
    u = CreateUnit(p, FourCC("n008"), -17962.3, -11925.3, 243.261)
    u = CreateUnit(p, FourCC("n008"), -18381.9, -11931.1, 296.813)
    u = CreateUnit(p, FourCC("u001"), -18179.6, -12150.4, 271.872)
    u = CreateUnit(p, FourCC("n009"), -13315.4, -18542.4, 206.950)
    u = CreateUnit(p, FourCC("n009"), -13292.8, -18815.0, 206.950)
    u = CreateUnit(p, FourCC("n009"), -11789.2, -17719.7, 206.950)
    u = CreateUnit(p, FourCC("n009"), -11845.6, -19608.8, 206.950)
    u = CreateUnit(p, FourCC("n009"), -9412.8, -17708.1, 32.136)
    u = CreateUnit(p, FourCC("n009"), -9442.9, -17911.0, 296.266)
    u = CreateUnit(p, FourCC("n003"), -9552.2, -17756.6, 79.291)
    u = CreateUnit(p, FourCC("n003"), -9567.6, -17899.6, 12.173)
    u = CreateUnit(p, FourCC("n003"), -9634.5, -17819.9, 215.020)
    u = CreateUnit(p, FourCC("n009"), -9360.0, -19467.5, 32.136)
    u = CreateUnit(p, FourCC("n009"), -9390.0, -19670.3, 296.266)
    u = CreateUnit(p, FourCC("n003"), -9499.3, -19515.9, 79.291)
    u = CreateUnit(p, FourCC("n003"), -9514.8, -19659.0, 12.173)
    u = CreateUnit(p, FourCC("n003"), -9581.7, -19579.2, 215.020)
    u = CreateUnit(p, FourCC("n009"), -8848.1, -18580.3, 32.136)
    u = CreateUnit(p, FourCC("n009"), -8878.2, -18783.2, 296.266)
    u = CreateUnit(p, FourCC("n003"), -8987.5, -18628.8, 79.291)
    u = CreateUnit(p, FourCC("n003"), -9002.9, -18771.8, 12.173)
    u = CreateUnit(p, FourCC("n003"), -9069.8, -18692.1, 215.020)
    u = CreateUnit(p, FourCC("n00A"), -7506.7, -18680.1, 194.565)
    u = CreateUnit(p, FourCC("n008"), -13775.5, -14022.8, 196.420)
    u = CreateUnit(p, FourCC("n008"), -13786.2, -13879.7, 269.327)
    u = CreateUnit(p, FourCC("n008"), -13384.2, -13908.8, 291.916)
    u = CreateUnit(p, FourCC("n008"), -13384.7, -13998.7, 124.523)
    u = CreateUnit(p, FourCC("u001"), -13390.9, -14175.0, 106.054)
    u = CreateUnit(p, FourCC("u001"), -13772.2, -14184.8, 356.078)
    u = CreateUnit(p, FourCC("uobs"), -16568.1, 1360.7, 209.735)
    u = CreateUnit(p, FourCC("uobs"), -17240.3, 1347.8, 293.289)
    u = CreateUnit(p, FourCC("uabo"), -16568.1, 1250.6, 171.150)
    u = CreateUnit(p, FourCC("uabo"), -17208.3, 1213.4, 258.780)
    u = CreateUnit(p, FourCC("u001"), 3461.3, -14319.3, 306.770)
    u = CreateUnit(p, FourCC("u001"), 3182.3, -14329.3, 224.897)
    u = CreateUnit(p, FourCC("n008"), 3320.5, -14174.6, 344.937)
    u = CreateUnit(p, FourCC("n001"), 3393.4, -14430.3, 300.540)
    u = CreateUnit(p, FourCC("n001"), 3301.6, -14434.4, 221.601)
    u = CreateUnit(p, FourCC("n001"), 3225.8, -14455.0, 281.149)
    u = CreateUnit(p, FourCC("u001"), -3183.6, -14329.2, 306.770)
    u = CreateUnit(p, FourCC("u001"), -3462.5, -14339.2, 224.897)
    u = CreateUnit(p, FourCC("n008"), -3324.3, -14184.4, 344.937)
    u = CreateUnit(p, FourCC("n001"), -3251.4, -14440.2, 300.540)
    u = CreateUnit(p, FourCC("n001"), -3343.2, -14444.2, 221.601)
    u = CreateUnit(p, FourCC("n001"), -3419.0, -14464.9, 281.149)
    u = CreateUnit(p, FourCC("n00B"), 492.1, -13141.2, 347.673)
    u = CreateUnit(p, FourCC("n00B"), 497.5, -13022.7, 13.580)
    u = CreateUnit(p, FourCC("n00B"), 486.2, -12838.4, 240.048)
    u = CreateUnit(p, FourCC("n00B"), -610.5, -12926.7, 229.962)
    u = CreateUnit(p, FourCC("n00B"), -597.0, -13093.2, 72.391)
    u = CreateUnit(p, FourCC("n00B"), -586.5, -13279.4, 35.058)
    u = CreateUnit(p, FourCC("n00B"), 441.0, -13272.2, 42.222)
    u = CreateUnit(p, FourCC("n00B"), -566.8, -12863.7, 354.463)
    u = CreateUnit(p, FourCC("n00D"), 752.7, -13069.2, 7.724)
    u = CreateUnit(p, FourCC("n00D"), -814.8, -13094.9, 158.450)
end

function CreateNeutralPassiveBuildings()
    local p = Player(PLAYER_NEUTRAL_PASSIVE)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("n006"), -18176.0, -5888.0, 270.000)
    u = CreateUnit(p, FourCC("n004"), -17984.0, -6592.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -17888.0, -1248.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -18208.0, -1376.0, 270.000)
    gg_unit_u003_0039 = CreateUnit(p, FourCC("u003"), -17920.0, -4096.0, 270.000)
    gg_unit_u003_0040 = CreateUnit(p, FourCC("u003"), -18432.0, -3584.0, 270.000)
    gg_unit_u003_0041 = CreateUnit(p, FourCC("u003"), -16384.0, -2560.0, 270.000)
    gg_unit_u003_0042 = CreateUnit(p, FourCC("u003"), -18432.0, -2048.0, 270.000)
    gg_unit_u003_0043 = CreateUnit(p, FourCC("u003"), -16384.0, -1024.0, 270.000)
    gg_unit_u003_0044 = CreateUnit(p, FourCC("u003"), -16832.0, -320.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -18720.0, -2080.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -18592.0, -1760.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -16288.0, -2208.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -16544.0, -1824.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -16352.0, -608.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -16416.0, -352.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -17248.0, -416.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -17504.0, -672.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -17440.0, -2528.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -17056.0, -1760.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -18400.0, -3104.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -18720.0, -3296.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -17568.0, -3552.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -17824.0, -3552.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -17504.0, -3360.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -17184.0, -3488.0, 270.000)
    u = CreateUnit(p, FourCC("u004"), -17312.0, -2080.0, 270.000)
    u = CreateUnit(p, FourCC("n002"), -13568.0, -12608.0, 270.000)
end

function CreatePlayerBuildings()
    CreateBuildingsForPlayer12()
end

function CreatePlayerUnits()
    CreateUnitsForPlayer12()
end

function CreateAllUnits()
    CreateNeutralPassiveBuildings()
    CreatePlayerBuildings()
    CreatePlayerUnits()
end

function CreateRegions()
    local we
    gg_rct_Miniboss_00a = Rect(-18816.0, -10496.0, -17536.0, -10112.0)
    gg_rct_Gate_00 = Rect(-14528.0, -15040.0, -14016.0, -14528.0)
    gg_rct_Challenge_00_Area = Rect(-18944.0, -4608.0, -15872.0, 0.0)
    we = AddWeatherEffect(gg_rct_Challenge_00_Area, FourCC("RAhr"))
    EnableWeatherEffect(we, true)
    gg_rct_Challenge_00_Entrance = Rect(-18304.0, -6016.0, -18048.0, -5760.0)
    gg_rct_Challenge_00_Exit = Rect(-17280.0, 640.0, -16512.0, 1408.0)
    gg_rct_Challenge_00_Fail = Rect(-18304.0, -6976.0, -18048.0, -6720.0)
    gg_rct_Challenge_00_Arena = Rect(-16640.0, -6400.0, -15616.0, -5376.0)
    gg_rct_Miniboss_00b = Rect(-8704.0, -18944.0, -7168.0, -18432.0)
    we = AddWeatherEffect(gg_rct_Miniboss_00b, FourCC("FDgl"))
    EnableWeatherEffect(we, true)
    gg_rct_NPC_00 = Rect(-13824.0, -8704.0, -13312.0, -8192.0)
    gg_rct_Gate_01 = Rect(-13952.0, -18976.0, -13632.0, -18400.0)
    gg_rct_Butcher_Zone = Rect(6176.0, -14304.0, 7136.0, -13344.0)
    we = AddWeatherEffect(gg_rct_Butcher_Zone, FourCC("FDrl"))
    EnableWeatherEffect(we, true)
end

function Trig_General_Init_Actions()
    LockGameSpeedBJ()
    SetTimeOfDay(0.00)
    UseTimeOfDayBJ(false)
    ModifyGateBJ(bj_GATEOPERATION_OPEN, gg_dest_DTg1_0090)
    ModifyGateBJ(bj_GATEOPERATION_OPEN, gg_dest_DTg2_0091)
    SetPlayerFlagBJ(PLAYER_STATE_GIVES_BOUNTY, true, Player(12))
    ConditionalTriggerExecute(gg_trg_CS_Init)
    ConditionalTriggerExecute(gg_trg_Hex_INIT)
    udg_PlayerColor_String[1] = "|cffff0000"
    udg_PlayerColor_String[2] = "|cff0000ff"
    udg_PlayerColor_String[3] = "|cff00ffff"
    udg_PlayerColor_String[4] = "|cff6f2583"
    bj_forLoopAIndex = 1
    bj_forLoopAIndexEnd = 4
    while (true) do
        if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
        udg__Player = ConvertedPlayer(GetForLoopIndexA())
        udg_Player_Name[GetForLoopIndexA()] = (udg_PlayerColor_String[GetForLoopIndexA()] .. (GetPlayerName(udg__Player) .. "|r"))
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
end

function InitTrig_General_Init()
    gg_trg_General_Init = CreateTrigger()
    TriggerAddAction(gg_trg_General_Init, Trig_General_Init_Actions)
end

function Trig_HP_Enemy_Dies_Conditions()
    if (not (GetUnitTypeId(GetTriggerUnit()) ~= FourCC("e002"))) then
        return false
    end
    return true
end

function Trig_HP_Enemy_Dies_Actions()
    udg__Unit = GetTriggerUnit()
    udg__Integer = GetUnitLevel(udg__Unit)
    bj_forLoopAIndex = 1
    bj_forLoopAIndexEnd = 4
    while (true) do
        if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
        AddHeroXPSwapped((udg__Integer * 5), udg_Player_HeroUnit[GetForLoopIndexA()], true)
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
end

function InitTrig_HP_Enemy_Dies()
    gg_trg_HP_Enemy_Dies = CreateTrigger()
    TriggerRegisterPlayerUnitEventSimple(gg_trg_HP_Enemy_Dies, Player(12), EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_HP_Enemy_Dies, Condition(Trig_HP_Enemy_Dies_Conditions))
    TriggerAddAction(gg_trg_HP_Enemy_Dies, Trig_HP_Enemy_Dies_Actions)
end

function Trig_HS_Spawn_Selectors_Func002Func003C()
    if (not (GetPlayerController(udg__Player) == MAP_CONTROL_USER)) then
        return false
    end
    if (not (GetPlayerSlotState(udg__Player) == PLAYER_SLOT_STATE_PLAYING)) then
        return false
    end
    return true
end

function Trig_HS_Spawn_Selectors_Actions()
    EnableSelect(false, false)
    bj_forLoopAIndex = 1
    bj_forLoopAIndexEnd = 4
    while (true) do
        if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
        udg__Player = ConvertedPlayer(GetForLoopIndexA())
        udg__Point = GetPlayerStartLocationLoc(udg__Player)
        if (Trig_HS_Spawn_Selectors_Func002Func003C()) then
            CreateNUnitsAtLoc(1, FourCC("n000"), udg__Player, udg__Point, bj_UNIT_FACING)
            udg__Unit = GetLastCreatedUnit()
            SelectUnitForPlayerSingle(udg__Unit, udg__Player)
        else
        end
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
end

function InitTrig_HS_Spawn_Selectors()
    gg_trg_HS_Spawn_Selectors = CreateTrigger()
    TriggerRegisterTimerEventSingle(gg_trg_HS_Spawn_Selectors, 0.10)
    TriggerAddAction(gg_trg_HS_Spawn_Selectors, Trig_HS_Spawn_Selectors_Actions)
end

function Trig_HS_Select_Heroes_Conditions()
    if (not (IsUnitType(GetSoldUnit(), UNIT_TYPE_HERO) == true)) then
        return false
    end
    return true
end

function Trig_HS_Select_Heroes_Func013C()
    if (not (IsUnitGroupEmptyBJ(udg__UnitGroup) == true)) then
        return false
    end
    return true
end

function Trig_HS_Select_Heroes_Actions()
    udg__CasterUnit = GetSellingUnit()
    udg__TargetUnit = GetSoldUnit()
    udg__UnitType = GetUnitTypeId(udg__TargetUnit)
    udg__Player = GetOwningPlayer(udg__TargetUnit)
    udg__Integer = GetConvertedPlayerId(udg__Player)
    udg_Player_HeroType[udg__Integer] = udg__UnitType
    DisplayTextToForce(GetPlayersAll(), (udg_Player_Name[udg__Integer] .. (" has chosen to be a |c00ffcc00" .. (GetUnitName(udg__TargetUnit) .. "|r."))))
    DisplayTextToForce(GetPlayersAll(), udg__String)
    RemoveUnit(udg__CasterUnit)
    RemoveUnit(udg__TargetUnit)
    udg__UnitGroup = GetUnitsOfTypeIdAll(FourCC("n000"))
    GroupRemoveUnitSimple(udg__CasterUnit, udg__UnitGroup)
    if (Trig_HS_Select_Heroes_Func013C()) then
        ConditionalTriggerExecute(gg_trg_HS_Spawn_Heroes)
    else
    end
end

function InitTrig_HS_Select_Heroes()
    gg_trg_HS_Select_Heroes = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_HS_Select_Heroes, EVENT_PLAYER_UNIT_SELL)
    TriggerAddCondition(gg_trg_HS_Select_Heroes, Condition(Trig_HS_Select_Heroes_Conditions))
    TriggerAddAction(gg_trg_HS_Select_Heroes, Trig_HS_Select_Heroes_Actions)
end

function Trig_HS_Spawn_Heroes_Func005Func001C()
    if (not (udg_Player_HeroType[GetForLoopIndexA()] ~= 0)) then
        return false
    end
    return true
end

function Trig_HS_Spawn_Heroes_Actions()
    ClearTextMessagesBJ(GetPlayersAll())
    PlaySoundBJ(gg_snd_Rescue)
    EnableSelect(true, true)
    DisplayTextToForce(GetPlayersAll(), udg__String)
    bj_forLoopAIndex = 1
    bj_forLoopAIndexEnd = 4
    while (true) do
        if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
        if (Trig_HS_Spawn_Heroes_Func005Func001C()) then
            udg__Player = ConvertedPlayer(GetForLoopIndexA())
            udg__Point = GetPlayerStartLocationLoc(udg__Player)
            CreateNUnitsAtLoc(1, udg_Player_HeroType[GetForLoopIndexA()], udg__Player, udg__Point, bj_UNIT_FACING)
            udg_Player_HeroUnit[GetForLoopIndexA()] = GetLastCreatedUnit()
            udg__Unit = GetLastCreatedUnit()
            BlzSetHeroProperName(udg__Unit, GetPlayerName(udg__Player))
            SetCameraTargetControllerNoZForPlayer(udg__Player, udg__Unit, 0, 0, false)
            SelectUnitForPlayerSingle(udg__Unit, udg__Player)
            AdjustPlayerStateBJ(30, udg__Player, PLAYER_STATE_RESOURCE_LUMBER)
        else
        end
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
end

function InitTrig_HS_Spawn_Heroes()
    gg_trg_HS_Spawn_Heroes = CreateTrigger()
    TriggerAddAction(gg_trg_HS_Spawn_Heroes, Trig_HS_Spawn_Heroes_Actions)
end

function Trig_HD_Spawn_Wisp_Conditions()
    if (not (IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == true)) then
        return false
    end
    return true
end

function Trig_HD_Spawn_Wisp_Actions()
    udg__Unit = GetDyingUnit()
    udg__Player = GetOwningPlayer(udg__Unit)
    udg__Point = GetUnitLoc(udg__Unit)
    udg__Integer = GetConvertedPlayerId(udg__Player)
    udg_HeroDeath_Boolean[udg__Integer] = true
    DisplayTextToForce(GetPlayersAll(), (udg_Player_Name[udg__Integer] .. " has fallen in battle!"))
    CreateNUnitsAtLoc(1, FourCC("e000"), udg__Player, udg__Point, bj_UNIT_FACING)
    udg__Unit = GetLastCreatedUnit()
    udg_Player_HeroWisp[udg__Integer] = GetLastCreatedUnit()
    BlzSetUnitName(udg__Unit, (GetPlayerName(udg__Player) .. "'s Spirit"))
    SetCameraTargetControllerNoZForPlayer(udg__Player, udg__Unit, 0, 0, false)
    StartTimerBJ(udg_HeroDeath_Timer[udg__Integer], false, 1.00)
end

function InitTrig_HD_Spawn_Wisp()
    gg_trg_HD_Spawn_Wisp = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_HD_Spawn_Wisp, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_HD_Spawn_Wisp, Condition(Trig_HD_Spawn_Wisp_Conditions))
    TriggerAddAction(gg_trg_HD_Spawn_Wisp, Trig_HD_Spawn_Wisp_Actions)
end

function Trig_HD_Wisp_Timer_Func001Func001Func002C()
    if (not (GetPlayerState(udg__Player, PLAYER_STATE_RESOURCE_LUMBER) > 0)) then
        return false
    end
    return true
end

function Trig_HD_Wisp_Timer_Func001Func001C()
    if (not (TimerGetRemaining(udg_HeroDeath_Timer[GetForLoopIndexA()]) <= 0.00)) then
        return false
    end
    if (not (udg_HeroDeath_Boolean[GetForLoopIndexA()] == true)) then
        return false
    end
    return true
end

function Trig_HD_Wisp_Timer_Actions()
    bj_forLoopAIndex = 1
    bj_forLoopAIndexEnd = 4
    while (true) do
        if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
        if (Trig_HD_Wisp_Timer_Func001Func001C()) then
            udg__Player = ConvertedPlayer(GetForLoopIndexA())
            if (Trig_HD_Wisp_Timer_Func001Func001Func002C()) then
                AdjustPlayerStateBJ(-1, udg__Player, PLAYER_STATE_RESOURCE_LUMBER)
                StartTimerBJ(udg_HeroDeath_Timer[GetForLoopIndexA()], false, 1.00)
            else
                udg_HeroDeath_Boolean[GetForLoopIndexA()] = false
                KillUnit(udg_Player_HeroWisp[GetForLoopIndexA()])
                DisplayTextToForce(GetPlayersAll(), (udg_Player_Name[GetForLoopIndexA()] .. "'s Soul is gone..."))
                CustomDefeatBJ(udg__Player, "TRIGSTR_378")
            end
        else
        end
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
end

function InitTrig_HD_Wisp_Timer()
    gg_trg_HD_Wisp_Timer = CreateTrigger()
    TriggerRegisterTimerExpireEventBJ(gg_trg_HD_Wisp_Timer, udg_HeroDeath_Timer[1])
    TriggerRegisterTimerExpireEventBJ(gg_trg_HD_Wisp_Timer, udg_HeroDeath_Timer[2])
    TriggerRegisterTimerExpireEventBJ(gg_trg_HD_Wisp_Timer, udg_HeroDeath_Timer[3])
    TriggerRegisterTimerExpireEventBJ(gg_trg_HD_Wisp_Timer, udg_HeroDeath_Timer[4])
    TriggerAddAction(gg_trg_HD_Wisp_Timer, Trig_HD_Wisp_Timer_Actions)
end

function Trig_CS_Init_Func002Func002C()
    if (not (GetUnitAbilityLevelSwapped(FourCC("A003"), udg__Unit) ~= 0)) then
        return false
    end
    return true
end

function Trig_CS_Init_Func002A()
    udg__Unit = GetEnumUnit()
    if (Trig_CS_Init_Func002Func002C()) then
        udg__Point = GetUnitLoc(udg__Unit)
        CreateNUnitsAtLoc(1, FourCC("e001"), Player(12), udg__Point, bj_UNIT_FACING)
    else
    end
end

function Trig_CS_Init_Actions()
    udg__UnitGroup = GetUnitsOfPlayerAll(Player(12))
    ForGroupBJ(udg__UnitGroup, Trig_CS_Init_Func002A)
end

function InitTrig_CS_Init()
    gg_trg_CS_Init = CreateTrigger()
    TriggerAddAction(gg_trg_CS_Init, Trig_CS_Init_Actions)
end

function Trig_CS_Detector_Dies_Conditions()
    if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC("e001"))) then
        return false
    end
    return true
end

function Trig_CS_Detector_Dies_Func004Func002C()
    if (not (GetUnitAbilityLevelSwapped(FourCC("A003"), udg__Unit) ~= 0)) then
        return false
    end
    return true
end

function Trig_CS_Detector_Dies_Func004A()
    udg__Unit = GetEnumUnit()
    if (Trig_CS_Detector_Dies_Func004Func002C()) then
        UnitAddAbilityBJ(FourCC("S000"), udg__Unit)
    else
    end
end

function Trig_CS_Detector_Dies_Actions()
    udg__Unit = GetDyingUnit()
    udg__Point = GetUnitLoc(udg__Unit)
    udg__UnitGroup = GetUnitsInRangeOfLocAll(450.00, udg__Point)
    ForGroupBJ(udg__UnitGroup, Trig_CS_Detector_Dies_Func004A)
end

function InitTrig_CS_Detector_Dies()
    gg_trg_CS_Detector_Dies = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_CS_Detector_Dies, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_CS_Detector_Dies, Condition(Trig_CS_Detector_Dies_Conditions))
    TriggerAddAction(gg_trg_CS_Detector_Dies, Trig_CS_Detector_Dies_Actions)
end

function Trig_CS_Spawn_Zombie_Conditions()
    if (not (GetSpellAbilityId() == FourCC("A002"))) then
        return false
    end
    return true
end

function Trig_CS_Spawn_Zombie_Func010Func003C()
    if (not (IsPlayerEnemy(udg__Player, Player(12)) ~= true)) then
        return false
    end
    return true
end

function Trig_CS_Spawn_Zombie_Func010A()
    udg__Unit = GetEnumUnit()
    udg__Player = GetOwningPlayer(udg__Unit)
    if (Trig_CS_Spawn_Zombie_Func010Func003C()) then
        GroupRemoveUnitSimple(udg__Unit, udg__UnitGroup)
    else
    end
end

function Trig_CS_Spawn_Zombie_Func011C()
    if (not (IsUnitGroupEmptyBJ(udg__UnitGroup) == true)) then
        return false
    end
    return true
end

function Trig_CS_Spawn_Zombie_Actions()
    udg__CasterUnit = GetSpellAbilityUnit()
    udg__Point = GetUnitLoc(udg__CasterUnit)
    udg__Player = GetOwningPlayer(udg__CasterUnit)
    CreateNUnitsAtLoc(1, FourCC("n001"), udg__Player, udg__Point, bj_UNIT_FACING)
    udg__Unit = GetLastCreatedUnit()
    udg__Point = GetUnitLoc(udg__Unit)
    AddSpecialEffectLocBJ(udg__Point, "Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl")
    DestroyEffectBJ(GetLastCreatedEffectBJ())
    udg__UnitGroup = GetUnitsInRangeOfLocAll(900.00, udg__Point)
    ForGroupBJ(udg__UnitGroup, Trig_CS_Spawn_Zombie_Func010A)
    if (Trig_CS_Spawn_Zombie_Func011C()) then
        CreateNUnitsAtLoc(1, FourCC("e001"), Player(12), udg__Point, bj_UNIT_FACING)
        UnitRemoveAbilityBJ(FourCC("S000"), udg__CasterUnit)
    else
    end
end

function InitTrig_CS_Spawn_Zombie()
    gg_trg_CS_Spawn_Zombie = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_CS_Spawn_Zombie, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_CS_Spawn_Zombie, Condition(Trig_CS_Spawn_Zombie_Conditions))
    TriggerAddAction(gg_trg_CS_Spawn_Zombie, Trig_CS_Spawn_Zombie_Actions)
end

function Trig_CS_Spawn_Murgul_Conditions()
    if (not (GetSpellAbilityId() == FourCC("A00S"))) then
        return false
    end
    return true
end

function Trig_CS_Spawn_Murgul_Func010Func003C()
    if (not (IsPlayerEnemy(udg__Player, Player(12)) ~= true)) then
        return false
    end
    return true
end

function Trig_CS_Spawn_Murgul_Func010A()
    udg__Unit = GetEnumUnit()
    udg__Player = GetOwningPlayer(udg__Unit)
    if (Trig_CS_Spawn_Murgul_Func010Func003C()) then
        GroupRemoveUnitSimple(udg__Unit, udg__UnitGroup)
    else
    end
end

function Trig_CS_Spawn_Murgul_Func011C()
    if (not (IsUnitGroupEmptyBJ(udg__UnitGroup) == true)) then
        return false
    end
    return true
end

function Trig_CS_Spawn_Murgul_Actions()
    udg__CasterUnit = GetSpellAbilityUnit()
    udg__Point = GetUnitLoc(udg__CasterUnit)
    udg__Player = GetOwningPlayer(udg__CasterUnit)
    CreateNUnitsAtLoc(1, FourCC("n003"), udg__Player, udg__Point, bj_UNIT_FACING)
    udg__Unit = GetLastCreatedUnit()
    udg__Point = GetUnitLoc(udg__Unit)
    AddSpecialEffectLocBJ(udg__Point, "Abilities\\Spells\\Undead\\RaiseSkeletonWarrior\\RaiseSkeleton.mdl")
    DestroyEffectBJ(GetLastCreatedEffectBJ())
    udg__UnitGroup = GetUnitsInRangeOfLocAll(900.00, udg__Point)
    ForGroupBJ(udg__UnitGroup, Trig_CS_Spawn_Murgul_Func010A)
    if (Trig_CS_Spawn_Murgul_Func011C()) then
        CreateNUnitsAtLoc(1, FourCC("e001"), Player(12), udg__Point, bj_UNIT_FACING)
        UnitRemoveAbilityBJ(FourCC("S000"), udg__CasterUnit)
    else
    end
end

function InitTrig_CS_Spawn_Murgul()
    gg_trg_CS_Spawn_Murgul = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_CS_Spawn_Murgul, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_CS_Spawn_Murgul, Condition(Trig_CS_Spawn_Murgul_Conditions))
    TriggerAddAction(gg_trg_CS_Spawn_Murgul, Trig_CS_Spawn_Murgul_Actions)
end

function Trig_TES_INIT_Actions()
    udg_Sorceress_Dest_Equip[0] = FourCC("A00T")
    udg_Sorceress_Dest_Equip[1] = FourCC("A00U")
    udg_Sorceress_Dest_Equip[2] = FourCC("A00V")
    udg_Sorceress_Dest_Spell[0] = FourCC("A00X")
    udg_Sorceress_Dest_Spell[1] = FourCC("A00W")
    udg_Sorceress_Dest_Spell[2] = FourCC("A00Y")
end

function InitTrig_TES_INIT()
    gg_trg_TES_INIT = CreateTrigger()
    TriggerAddAction(gg_trg_TES_INIT, Trig_TES_INIT_Actions)
end

function Trig_Ranger_Focus_Conditions()
    if (not (GetUnitAbilityLevelSwapped(FourCC("A01R"), GetAttacker()) ~= 0)) then
        return false
    end
    return true
end

function Trig_Ranger_Focus_Func008Func001Func001C()
    if (not (GetUnitAbilityLevelSwapped(FourCC("A01T"), udg__CasterUnit) < ((udg__Integer + 1) * 15))) then
        return false
    end
    return true
end

function Trig_Ranger_Focus_Func008C()
    if (not (UnitHasBuffBJ(udg__CasterUnit, FourCC("B007")) == false)) then
        return false
    end
    return true
end

function Trig_Ranger_Focus_Actions()
    udg__CasterUnit = GetAttacker()
    udg__Point = GetUnitLoc(udg__CasterUnit)
    udg__Player = GetOwningPlayer(udg__CasterUnit)
    udg__Integer = GetUnitAbilityLevelSwapped(FourCC("A01R"), udg__CasterUnit)
    CreateNUnitsAtLoc(1, FourCC("e002"), udg__Player, udg__Point, bj_UNIT_FACING)
    udg__Unit = GetLastCreatedUnit()
    UnitAddAbilityBJ(FourCC("A01S"), udg__Unit)
    if (Trig_Ranger_Focus_Func008C()) then
        SetUnitAbilityLevelSwapped(FourCC("A01T"), udg__CasterUnit, 1)
    else
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = (udg__Integer + 1)
        while (true) do
            if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
            if (Trig_Ranger_Focus_Func008Func001Func001C()) then
                IncUnitAbilityLevelSwapped(FourCC("A01T"), udg__CasterUnit)
            else
            end
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
    end
    udg__Integer = GetUnitAbilityLevelSwapped(FourCC("A01T"), udg__CasterUnit)
    DisplayTextToForce(GetPlayersAll(), I2S(udg__Integer))
    SetUnitAbilityLevelSwapped(FourCC("A01S"), udg__Unit, udg__Integer)
    IssueTargetOrderBJ(udg__Unit, "unholyfrenzy", udg__CasterUnit)
    UnitApplyTimedLifeBJ(0.10, FourCC("BTLF"), udg__Unit)
end

function InitTrig_Ranger_Focus()
    gg_trg_Ranger_Focus = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ranger_Focus, EVENT_PLAYER_UNIT_ATTACKED)
    TriggerAddCondition(gg_trg_Ranger_Focus, Condition(Trig_Ranger_Focus_Conditions))
    TriggerAddAction(gg_trg_Ranger_Focus, Trig_Ranger_Focus_Actions)
end

function Trig_Battle_Frenzy_Conditions()
    if (not (GetUnitTypeId(GetTriggerUnit()) ~= FourCC("e002"))) then
        return false
    end
    if (not (GetUnitAbilityLevelSwapped(FourCC("A00D"), GetKillingUnitBJ()) ~= 0)) then
        return false
    end
    return true
end

function Trig_Battle_Frenzy_Func010Func002C()
    if (not (IsUnitAlly(udg__TargetUnit, udg__Player) == true)) then
        return false
    end
    return true
end

function Trig_Battle_Frenzy_Func010A()
    udg__TargetUnit = GetEnumUnit()
    if (Trig_Battle_Frenzy_Func010Func002C()) then
        CreateNUnitsAtLoc(1, FourCC("e002"), udg__Player, udg__Point, bj_UNIT_FACING)
        udg__Unit = GetLastCreatedUnit()
        UnitAddAbilityBJ(FourCC("A01D"), udg__Unit)
        SetUnitAbilityLevelSwapped(FourCC("A01D"), udg__Unit, udg__Integer)
        IssueTargetOrderBJ(udg__Unit, "unholyfrenzy", udg__TargetUnit)
        UnitApplyTimedLifeBJ(0.10, FourCC("BTLF"), udg__Unit)
    else
    end
end

function Trig_Battle_Frenzy_Actions()
    udg__CasterUnit = GetKillingUnitBJ()
    udg__Integer = GetUnitAbilityLevelSwapped(FourCC("A01D"), udg__CasterUnit)
    udg__Point = GetUnitLoc(udg__CasterUnit)
    udg__Player = GetOwningPlayer(udg__CasterUnit)
    udg__UnitGroup = GetUnitsInRangeOfLocAll(300.00, udg__Point)
    AddSpecialEffectLocBJ(udg__Point, "Abilities\\Spells\\Human\\SunderingBlades\\SunderingBlades.mdl")
    DestroyEffectBJ(GetLastCreatedEffectBJ())
    ForGroupBJ(udg__UnitGroup, Trig_Battle_Frenzy_Func010A)
end

function InitTrig_Battle_Frenzy()
    gg_trg_Battle_Frenzy = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Battle_Frenzy, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Battle_Frenzy, Condition(Trig_Battle_Frenzy_Conditions))
    TriggerAddAction(gg_trg_Battle_Frenzy, Trig_Battle_Frenzy_Actions)
end

function Trig_Combustion_Conditions()
    if (not (GetSpellAbilityId() == FourCC("A00X"))) then
        return false
    end
    return true
end

function Trig_Combustion_Func007Func002C()
    if (not (IsUnitEnemy(udg__TargetUnit, udg__Player) == true)) then
        return false
    end
    return true
end

function Trig_Combustion_Func007A()
    udg__TargetUnit = GetEnumUnit()
    if (Trig_Combustion_Func007Func002C()) then
        UnitDamageTargetBJ(udg__CasterUnit, udg__TargetUnit, udg__Real, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC)
    else
    end
end

function Trig_Combustion_Actions()
    udg__CasterUnit = GetSpellAbilityUnit()
    udg__Integer = GetUnitAbilityLevelSwapped(GetSpellAbilityId(), udg__CasterUnit)
    udg__Real = (25.00 + (75.00 * I2R(udg__Integer)))
    udg__Player = GetOwningPlayer(udg__CasterUnit)
    udg__Point = GetSpellTargetLoc()
    udg__UnitGroup = GetUnitsInRangeOfLocAll(200.00, udg__Point)
    ForGroupBJ(udg__UnitGroup, Trig_Combustion_Func007A)
    AddSpecialEffectLocBJ(udg__Point, "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl")
    DestroyEffectBJ(GetLastCreatedEffectBJ())
end

function InitTrig_Combustion()
    gg_trg_Combustion = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Combustion, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Combustion, Condition(Trig_Combustion_Conditions))
    TriggerAddAction(gg_trg_Combustion, Trig_Combustion_Actions)
end

function Trig_Equip_Destruction_Spell_Func005C()
    if (GetSpellAbilityId() == FourCC("A00T")) then
        return true
    end
    if (GetSpellAbilityId() == FourCC("A00U")) then
        return true
    end
    if (GetSpellAbilityId() == FourCC("A00V")) then
        return true
    end
    return false
end

function Trig_Equip_Destruction_Spell_Conditions()
    if (not Trig_Equip_Destruction_Spell_Func005C()) then
        return false
    end
    return true
end

function Trig_Equip_Destruction_Spell_Func004Func001C()
    if (not (udg__AbilityCode == udg_Sorceress_Dest_Equip[GetForLoopIndexA()])) then
        return false
    end
    return true
end

function Trig_Equip_Destruction_Spell_Actions()
    udg__Unit = GetTriggerUnit()
    udg__AbilityCode = GetSpellAbilityId()
    udg__Integer = GetUnitAbilityLevelSwapped(udg__AbilityCode, udg__Unit)
    bj_forLoopAIndex = 0
    bj_forLoopAIndexEnd = 4
    while (true) do
        if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
        if (Trig_Equip_Destruction_Spell_Func004Func001C()) then
            UnitAddAbilityBJ(udg_Sorceress_Dest_Spell[GetForLoopIndexA()], udg__Unit)
            SetUnitAbilityLevelSwapped(udg_Sorceress_Dest_Spell[GetForLoopIndexA()], udg__Unit, udg__Integer)
        else
            UnitRemoveAbilityBJ(udg_Sorceress_Dest_Spell[GetForLoopIndexA()], udg__Unit)
        end
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
end

function InitTrig_Equip_Destruction_Spell()
    gg_trg_Equip_Destruction_Spell = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Equip_Destruction_Spell, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Equip_Destruction_Spell, Condition(Trig_Equip_Destruction_Spell_Conditions))
    TriggerAddAction(gg_trg_Equip_Destruction_Spell, Trig_Equip_Destruction_Spell_Actions)
end

function Trig_Spell_Book_Learn_Func006C()
    if (GetLearnedSkillBJ() == FourCC("A00K")) then
        return true
    end
    if (GetLearnedSkillBJ() == FourCC("A00P")) then
        return true
    end
    if (GetLearnedSkillBJ() == FourCC("A00Q")) then
        return true
    end
    if (GetLearnedSkillBJ() == FourCC("A00R")) then
        return true
    end
    return false
end

function Trig_Spell_Book_Learn_Conditions()
    if (not Trig_Spell_Book_Learn_Func006C()) then
        return false
    end
    return true
end

function Trig_Spell_Book_Learn_Actions()
    udg__Unit = GetLearningUnit()
    BlzUnitHideAbility(udg__Unit, FourCC("A00K"), true)
    BlzUnitHideAbility(udg__Unit, FourCC("A00P"), true)
    BlzUnitHideAbility(udg__Unit, FourCC("A00Q"), true)
    BlzUnitHideAbility(udg__Unit, FourCC("A00R"), true)
end

function InitTrig_Spell_Book_Learn()
    gg_trg_Spell_Book_Learn = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Spell_Book_Learn, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Spell_Book_Learn, Condition(Trig_Spell_Book_Learn_Conditions))
    TriggerAddAction(gg_trg_Spell_Book_Learn, Trig_Spell_Book_Learn_Actions)
end

function Trig_Change_List_Func001C()
    if (GetSpellAbilityId() == FourCC("A00L")) then
        return true
    end
    if (GetSpellAbilityId() == FourCC("A00O")) then
        return true
    end
    if (GetSpellAbilityId() == FourCC("A00M")) then
        return true
    end
    if (GetSpellAbilityId() == FourCC("A00N")) then
        return true
    end
    return false
end

function Trig_Change_List_Conditions()
    if (not Trig_Change_List_Func001C()) then
        return false
    end
    return true
end

function Trig_Change_List_Func002C()
    if (not (GetSpellAbilityId() == FourCC("A00L"))) then
        return false
    end
    return true
end

function Trig_Change_List_Func003C()
    if (not (GetSpellAbilityId() == FourCC("A00O"))) then
        return false
    end
    return true
end

function Trig_Change_List_Func004C()
    if (not (GetSpellAbilityId() == FourCC("A00M"))) then
        return false
    end
    return true
end

function Trig_Change_List_Func005C()
    if (not (GetSpellAbilityId() == FourCC("A00N"))) then
        return false
    end
    return true
end

function Trig_Change_List_Actions()
    if (Trig_Change_List_Func002C()) then
        SetUnitAbilityLevelSwapped(FourCC("A00J"), GetTriggerUnit(), 2)
    else
    end
    if (Trig_Change_List_Func003C()) then
        SetUnitAbilityLevelSwapped(FourCC("A00J"), GetTriggerUnit(), 3)
    else
    end
    if (Trig_Change_List_Func004C()) then
        SetUnitAbilityLevelSwapped(FourCC("A00J"), GetTriggerUnit(), 4)
    else
    end
    if (Trig_Change_List_Func005C()) then
        SetUnitAbilityLevelSwapped(FourCC("A00J"), GetTriggerUnit(), 5)
    else
    end
end

function InitTrig_Change_List()
    gg_trg_Change_List = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Change_List, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Change_List, Condition(Trig_Change_List_Conditions))
    TriggerAddAction(gg_trg_Change_List, Trig_Change_List_Actions)
end

function Trig_Ammo_Equip_Func009C()
    if (GetSpellAbilityId() == FourCC("A01A")) then
        return true
    end
    if (GetSpellAbilityId() == FourCC("A01B")) then
        return true
    end
    return false
end

function Trig_Ammo_Equip_Conditions()
    if (not Trig_Ammo_Equip_Func009C()) then
        return false
    end
    return true
end

function Trig_Ammo_Equip_Func007C()
    if (not (udg__AbilityCode == FourCC("A01A"))) then
        return false
    end
    return true
end

function Trig_Ammo_Equip_Func008C()
    if (not (udg__AbilityCode == FourCC("A01B"))) then
        return false
    end
    return true
end

function Trig_Ammo_Equip_Actions()
    udg__AbilityCode = GetSpellAbilityId()
    udg__Unit = GetTriggerUnit()
    udg__Integer = GetUnitAbilityLevelSwapped(udg__AbilityCode, udg__Unit)
    PlaySoundOnUnitBJ(gg_snd_ClockwerkGoblinDeath1, 100, udg__Unit)
    UnitRemoveAbilityBJ(FourCC("A017"), udg__Unit)
    UnitRemoveAbilityBJ(FourCC("A018"), udg__Unit)
    if (Trig_Ammo_Equip_Func007C()) then
        UnitAddAbilityBJ(FourCC("A017"), udg__Unit)
        SetUnitAbilityLevelSwapped(FourCC("A017"), udg__Unit, udg__Integer)
    else
    end
    if (Trig_Ammo_Equip_Func008C()) then
        UnitAddAbilityBJ(FourCC("A018"), udg__Unit)
        SetUnitAbilityLevelSwapped(FourCC("A018"), udg__Unit, udg__Integer)
    else
    end
end

function InitTrig_Ammo_Equip()
    gg_trg_Ammo_Equip = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ammo_Equip, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Ammo_Equip, Condition(Trig_Ammo_Equip_Conditions))
    TriggerAddAction(gg_trg_Ammo_Equip, Trig_Ammo_Equip_Actions)
end

function Trig_Ammo_Level_Conditions()
    if (not (GetLearnedSkillBJ() == FourCC("A019"))) then
        return false
    end
    return true
end

function Trig_Ammo_Level_Actions()
    udg__Unit = GetTriggerUnit()
    udg__Integer = GetUnitAbilityLevelSwapped(FourCC("A019"), udg__Unit)
    SetUnitAbilityLevelSwapped(FourCC("A017"), udg__Unit, udg__Integer)
    SetUnitAbilityLevelSwapped(FourCC("A01A"), udg__Unit, udg__Integer)
    SetUnitAbilityLevelSwapped(FourCC("A018"), udg__Unit, udg__Integer)
    SetUnitAbilityLevelSwapped(FourCC("A01B"), udg__Unit, udg__Integer)
end

function InitTrig_Ammo_Level()
    gg_trg_Ammo_Level = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Ammo_Level, EVENT_PLAYER_HERO_SKILL)
    TriggerAddCondition(gg_trg_Ammo_Level, Condition(Trig_Ammo_Level_Conditions))
    TriggerAddAction(gg_trg_Ammo_Level, Trig_Ammo_Level_Actions)
end

function Trig_Shadow_Strike_Conditions()
    if (not (GetSpellAbilityId() == FourCC("A01C"))) then
        return false
    end
    return true
end

function Trig_Shadow_Strike_Func009Func002C()
    if (not (IsUnitEnemy(udg__Unit, udg__Player) == true)) then
        return false
    end
    if (not (IsUnitType(udg__Unit, UNIT_TYPE_STRUCTURE) == false)) then
        return false
    end
    if (not (IsUnitHiddenBJ(udg__Unit) == false)) then
        return false
    end
    if (not (IsUnitPausedBJ(udg__Unit) == false)) then
        return false
    end
    if (not (IsUnitDeadBJ(udg__Unit) == false)) then
        return false
    end
    return true
end

function Trig_Shadow_Strike_Func009A()
    udg__Unit = GetEnumUnit()
    if (Trig_Shadow_Strike_Func009Func002C()) then
        UnitDamageTargetBJ(udg__CasterUnit, udg__Unit, (udg__Real * I2R(GetHeroStatBJ(bj_HEROSTAT_AGI, udg__CasterUnit, true))), ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL)
        UnitDamageTargetBJ(udg__CasterUnit, udg__Unit, (udg__Real * I2R(GetHeroStatBJ(bj_HEROSTAT_INT, udg__CasterUnit, true))), ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC)
    else
    end
end

function Trig_Shadow_Strike_Actions()
    udg__CasterUnit = GetSpellAbilityUnit()
    udg__Player = GetOwningPlayer(udg__CasterUnit)
    udg__Integer = GetUnitAbilityLevelSwapped(GetSpellAbilityId(), udg__CasterUnit)
    udg__Point = GetUnitLoc(udg__CasterUnit)
    AddSpecialEffectLocBJ(udg__Point, "war3mapImported\\Culling Slash.mdx")
    DestroyEffectBJ(GetLastCreatedEffectBJ())
    udg__UnitGroup = GetUnitsInRangeOfLocAll(200.00, udg__Point)
    udg__Real = (0.25 * I2R((udg__Integer + 1)))
    ForGroupBJ(udg__UnitGroup, Trig_Shadow_Strike_Func009A)
end

function InitTrig_Shadow_Strike()
    gg_trg_Shadow_Strike = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Shadow_Strike, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Shadow_Strike, Condition(Trig_Shadow_Strike_Conditions))
    TriggerAddAction(gg_trg_Shadow_Strike, Trig_Shadow_Strike_Actions)
end

function Trig_Holy_Light_Conditions()
    if (not (GetSpellAbilityId() == FourCC("A009"))) then
        return false
    end
    return true
end

function Trig_Holy_Light_Func006Func005C()
    if (not (IsUnitEnemy(udg__TargetUnit, udg__Player) == true)) then
        return false
    end
    return true
end

function Trig_Holy_Light_Func006A()
    udg__TargetUnit = GetEnumUnit()
    CreateNUnitsAtLoc(1, FourCC("e002"), udg__Player, udg__Point, bj_UNIT_FACING)
    udg__Unit = GetLastCreatedUnit()
    UnitApplyTimedLifeBJ(0.10, FourCC("BTLF"), udg__Unit)
    if (Trig_Holy_Light_Func006Func005C()) then
        UnitAddAbilityBJ(FourCC("A007"), udg__Unit)
        SetUnitAbilityLevelSwapped(FourCC("A007"), udg__Unit, udg__Integer)
        IssueTargetOrderBJ(udg__Unit, "curse", udg__TargetUnit)
    else
        UnitAddAbilityBJ(FourCC("A008"), udg__Unit)
        SetUnitAbilityLevelSwapped(FourCC("A008"), udg__Unit, udg__Integer)
        IssueTargetOrderBJ(udg__Unit, "innerfire", udg__TargetUnit)
    end
end

function Trig_Holy_Light_Actions()
    udg__CasterUnit = GetSpellAbilityUnit()
    udg__Integer = GetUnitAbilityLevelSwapped(GetSpellAbilityId(), udg__CasterUnit)
    udg__Player = GetOwningPlayer(udg__CasterUnit)
    udg__Point = GetSpellTargetLoc()
    udg__UnitGroup = GetUnitsInRangeOfLocAll(300.00, udg__Point)
    ForGroupBJ(udg__UnitGroup, Trig_Holy_Light_Func006A)
    AddSpecialEffectLocBJ(udg__Point, "Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
    DestroyEffectBJ(GetLastCreatedEffectBJ())
    bj_forLoopAIndex = 1
    bj_forLoopAIndexEnd = 8
    while (true) do
        if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
        udg__Point = GetSpellTargetLoc()
        udg__Point = PolarProjectionBJ(udg__Point, 200.00, (I2R(GetForLoopIndexA()) * 45.00))
        AddSpecialEffectLocBJ(udg__Point, "Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
end

function InitTrig_Holy_Light()
    gg_trg_Holy_Light = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Holy_Light, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Holy_Light, Condition(Trig_Holy_Light_Conditions))
    TriggerAddAction(gg_trg_Holy_Light, Trig_Holy_Light_Actions)
end

function Trig_Resurrection_Conditions()
    if (not (GetSpellAbilityId() == FourCC("A006"))) then
        return false
    end
    return true
end

function Trig_Resurrection_Actions()
    udg__CasterUnit = GetSpellAbilityUnit()
    udg__Integer = GetUnitAbilityLevelSwapped(GetSpellAbilityId(), udg__CasterUnit)
    udg__Real = (10.00 * I2R((udg__Integer + 1)))
    udg__TargetUnit = GetSpellTargetUnit()
    udg__Point = GetUnitLoc(udg__TargetUnit)
    udg__Player = GetOwningPlayer(udg__TargetUnit)
    udg__Integer = GetConvertedPlayerId(udg__Player)
    KillUnit(udg__TargetUnit)
    udg__Unit = udg_Player_HeroUnit[udg__Integer]
    udg_HeroDeath_Boolean[udg__Integer] = false
    ReviveHeroLoc(udg__Unit, udg__Point, true)
    SetCameraTargetControllerNoZForPlayer(udg__Player, udg_Player_HeroUnit[udg__Integer], 0, 0, false)
    SetUnitLifePercentBJ(udg__Unit, udg__Real)
    SetUnitManaPercentBJ(udg__Unit, 50.00)
end

function InitTrig_Resurrection()
    gg_trg_Resurrection = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Resurrection, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(gg_trg_Resurrection, Condition(Trig_Resurrection_Conditions))
    TriggerAddAction(gg_trg_Resurrection, Trig_Resurrection_Actions)
end

function Trig_Hex_INIT_Func002A()
    udg__Unit = GetEnumUnit()
    ShowUnitHide(udg__Unit)
end

function Trig_Hex_INIT_Actions()
    udg__UnitGroup = GetUnitsOfTypeIdAll(FourCC("u004"))
    ForGroupBJ(udg__UnitGroup, Trig_Hex_INIT_Func002A)
    CreateFogModifierRectBJ(true, Player(12), FOG_OF_WAR_VISIBLE, gg_rct_Challenge_00_Area)
    udg_Challenge_Hex_HutUnit[0] = gg_unit_u003_0039
    udg_Challenge_Hex_HutUnit[1] = gg_unit_u003_0040
    udg_Challenge_Hex_HutUnit[2] = gg_unit_u003_0041
    udg_Challenge_Hex_HutUnit[3] = gg_unit_u003_0042
    udg_Challenge_Hex_HutUnit[4] = gg_unit_u003_0043
    udg_Challenge_Hex_HutUnit[5] = gg_unit_u003_0044
end

function InitTrig_Hex_INIT()
    gg_trg_Hex_INIT = CreateTrigger()
    TriggerAddAction(gg_trg_Hex_INIT, Trig_Hex_INIT_Actions)
end

function Trig_Hex_Entrance_Conditions()
    if (not (IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == true)) then
        return false
    end
    if (not (udg_Challenge_Hex_Boolean == false)) then
        return false
    end
    return true
end

function Trig_Hex_Entrance_Func011002()
    RemoveItem(GetEnumItem())
end

function Trig_Hex_Entrance_Func018Func001C()
    if (not (udg__Integer == GetForLoopIndexA())) then
        return false
    end
    return true
end

function Trig_Hex_Entrance_Actions()
    PlaySoundBJ(gg_snd_QuestNew)
    udg_Challenge_Hex_Boolean = true
    udg__Unit = GetTriggerUnit()
    udg__Player = GetOwningPlayer(udg__Unit)
    PauseUnitBJ(true, udg__Unit)
    ShowUnitHide(udg__Unit)
    RemoveUnit(udg_Challenge_Hex_WolfUnit)
    udg_Challenge_Hex_EggsDelivered = 0
    EnumItemsInRectBJ(gg_rct_Challenge_00_Area, Trig_Hex_Entrance_Func011002)
    udg__UnitGroup = GetUnitsOfTypeIdAll(FourCC("u004"))
    bj_forLoopAIndex = 1
    bj_forLoopAIndexEnd = 10
    while (true) do
        if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
        udg__Point = GetUnitLoc(GroupPickRandomUnit(udg__UnitGroup))
        CreateItemLoc(FourCC("I000"), udg__Point)
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
    bj_forLoopAIndex = 1
    bj_forLoopAIndexEnd = 4
    while (true) do
        if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
        udg__Point = GetRandomLocInRect(gg_rct_Challenge_00_Arena)
        SetUnitPositionLoc(udg_Player_HeroUnit[GetForLoopIndexA()], udg__Point)
        udg__Point = GetRandomLocInRect(gg_rct_Challenge_00_Arena)
        CreateNUnitsAtLoc(1, FourCC("o001"), Player(12), udg__Point, bj_UNIT_FACING)
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
    udg__Integer = GetRandomInt(0, 5)
    bj_forLoopAIndex = 0
    bj_forLoopAIndexEnd = 5
    while (true) do
        if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
        if (Trig_Hex_Entrance_Func018Func001C()) then
            ShowUnitShow(udg_Challenge_Hex_HutUnit[GetForLoopIndexA()])
            udg__Point = GetUnitLoc(udg_Challenge_Hex_HutUnit[GetForLoopIndexA()])
            CreateNUnitsAtLoc(1, FourCC("n005"), udg__Player, udg__Point, bj_UNIT_FACING)
            udg_Challenge_Hex_RabbitUnit = GetLastCreatedUnit()
            SetCameraTargetControllerNoZForPlayer(udg__Player, udg_Challenge_Hex_RabbitUnit, 0, 0, false)
            SelectUnitForPlayerSingle(udg_Challenge_Hex_RabbitUnit, udg__Player)
            DisplayTextToForce(GetForceOfPlayer(udg__Player), "TRIGSTR_377")
            udg__Point = GetRectCenter(gg_rct_Challenge_00_Area)
            CreateNUnitsAtLoc(1, FourCC("o000"), Player(PLAYER_NEUTRAL_AGGRESSIVE), udg__Point, bj_UNIT_FACING)
            udg_Challenge_Hex_WolfUnit = GetLastCreatedUnit()
            SetUnitAcquireRangeBJ(udg_Challenge_Hex_WolfUnit, 1000000000.00)
            RemoveGuardPosition(udg_Challenge_Hex_WolfUnit)
        else
            ShowUnitHide(udg_Challenge_Hex_HutUnit[GetForLoopIndexA()])
        end
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
    udg__PlayerGroup = GetPlayersAll()
    ForceRemovePlayerSimple(udg__Player, udg__PlayerGroup)
    DisplayTextToForce(udg__PlayerGroup, (GetPlayerName(udg__Player) .. " has entered the |c00ffcc00Challenge of Hex|r. Survive until the challenge is completed."))
end

function InitTrig_Hex_Entrance()
    gg_trg_Hex_Entrance = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Hex_Entrance, gg_rct_Challenge_00_Entrance)
    TriggerAddCondition(gg_trg_Hex_Entrance, Condition(Trig_Hex_Entrance_Conditions))
    TriggerAddAction(gg_trg_Hex_Entrance, Trig_Hex_Entrance_Actions)
end

function Trig_Hex_Fail_Conditions()
    if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC("n005"))) then
        return false
    end
    return true
end

function Trig_Hex_Fail_Func008A()
    udg__Unit = GetEnumUnit()
    RemoveUnit(udg__Unit)
end

function Trig_Hex_Fail_Actions()
    PlaySoundBJ(gg_snd_QuestFailed)
    udg__Unit = GetTriggerUnit()
    udg__Player = GetOwningPlayer(udg__Unit)
    udg__Integer = GetConvertedPlayerId(udg__Player)
    udg__Point = GetRectCenter(gg_rct_Challenge_00_Fail)
    bj_forLoopAIndex = 1
    bj_forLoopAIndexEnd = 4
    while (true) do
        if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
        SetUnitPositionLoc(udg_Player_HeroUnit[GetForLoopIndexA()], udg__Point)
        bj_forLoopAIndex = bj_forLoopAIndex + 1
    end
    udg__UnitGroup = GetUnitsOfTypeIdAll(FourCC("o001"))
    ForGroupBJ(udg__UnitGroup, Trig_Hex_Fail_Func008A)
    PauseUnitBJ(false, udg_Player_HeroUnit[udg__Integer])
    ShowUnitShow(udg_Player_HeroUnit[udg__Integer])
    SetCameraTargetControllerNoZForPlayer(udg__Player, udg_Player_HeroUnit[udg__Integer], 0, 0, false)
    udg_Challenge_Hex_Boolean = false
end

function InitTrig_Hex_Fail()
    gg_trg_Hex_Fail = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Hex_Fail, EVENT_PLAYER_UNIT_DEATH)
    TriggerAddCondition(gg_trg_Hex_Fail, Condition(Trig_Hex_Fail_Conditions))
    TriggerAddAction(gg_trg_Hex_Fail, Trig_Hex_Fail_Actions)
end

function Trig_Hex_Egg_Get_Conditions()
    if (not (GetItemTypeId(GetManipulatedItem()) == FourCC("I000"))) then
        return false
    end
    return true
end

function Trig_Hex_Egg_Get_Actions()
    udg__Point = GetUnitLoc(udg_Challenge_Hex_RabbitUnit)
    PlaySoundBJ(gg_snd_Wolf1)
    IssuePointOrderLocBJ(udg_Challenge_Hex_WolfUnit, "attack", udg__Point)
end

function InitTrig_Hex_Egg_Get()
    gg_trg_Hex_Egg_Get = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Hex_Egg_Get, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddCondition(gg_trg_Hex_Egg_Get, Condition(Trig_Hex_Egg_Get_Conditions))
    TriggerAddAction(gg_trg_Hex_Egg_Get, Trig_Hex_Egg_Get_Actions)
end

function Trig_Hex_Egg_Deliver_Conditions()
    if (not (GetItemTypeId(GetManipulatedItem()) == FourCC("I000"))) then
        return false
    end
    return true
end

function Trig_Hex_Egg_Deliver_Func006Func002C()
    if (not (GetUnitTypeId(udg__TargetUnit) == FourCC("u003"))) then
        return false
    end
    return true
end

function Trig_Hex_Egg_Deliver_Func006A()
    udg__TargetUnit = GetEnumUnit()
    if (Trig_Hex_Egg_Deliver_Func006Func002C()) then
        udg__Point = GetUnitLoc(udg__TargetUnit)
        AddSpecialEffectLocBJ(udg__Point, "Abilities\\Spells\\Items\\ResourceItems\\ResourceEffectTarget.mdl")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        RemoveItem(udg__Item)
        udg_Challenge_Hex_EggsDelivered = (udg_Challenge_Hex_EggsDelivered + 1)
        ConditionalTriggerExecute(gg_trg_Hex_Update)
    else
    end
end

function Trig_Hex_Egg_Deliver_Actions()
    udg__Unit = GetManipulatingUnit()
    udg__Player = GetOwningPlayer(udg__Unit)
    udg__Item = GetManipulatedItem()
    udg__Point = GetUnitLoc(udg__Unit)
    udg__UnitGroup = GetUnitsInRangeOfLocAll(150.00, udg__Point)
    ForGroupBJ(udg__UnitGroup, Trig_Hex_Egg_Deliver_Func006A)
end

function InitTrig_Hex_Egg_Deliver()
    gg_trg_Hex_Egg_Deliver = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Hex_Egg_Deliver, EVENT_PLAYER_UNIT_USE_ITEM)
    TriggerAddCondition(gg_trg_Hex_Egg_Deliver, Condition(Trig_Hex_Egg_Deliver_Conditions))
    TriggerAddAction(gg_trg_Hex_Egg_Deliver, Trig_Hex_Egg_Deliver_Actions)
end

function Trig_Hex_Update_Func001Func006Func004Func005C()
    if (not (IsUnitType(udg__Unit, UNIT_TYPE_HERO) == true)) then
        return false
    end
    return true
end

function Trig_Hex_Update_Func001Func006Func004A()
    udg__Unit = GetEnumUnit()
    SetUnitPositionLoc(udg__Unit, udg__Point)
    PauseUnitBJ(false, udg__Unit)
    ShowUnitShow(udg__Unit)
    if (Trig_Hex_Update_Func001Func006Func004Func005C()) then
        SetCameraTargetControllerNoZForPlayer(udg__Player, udg__Unit, 0, 0, false)
    else
    end
end

function Trig_Hex_Update_Func001C()
    if (not (udg_Challenge_Hex_EggsDelivered == 10)) then
        return false
    end
    return true
end

function Trig_Hex_Update_Actions()
    if (Trig_Hex_Update_Func001C()) then
        PlaySoundBJ(gg_snd_QuestCompleted)
        RemoveUnit(udg_Challenge_Hex_RabbitUnit)
        RemoveUnit(udg_Challenge_Hex_WolfUnit)
        bj_forLoopAIndex = 1
        bj_forLoopAIndexEnd = 4
        while (true) do
            if (bj_forLoopAIndex > bj_forLoopAIndexEnd) then break end
            udg__Player = ConvertedPlayer(GetForLoopIndexA())
            udg__UnitGroup = GetUnitsOfPlayerAll(udg__Player)
            udg__Point = GetRandomLocInRect(gg_rct_Challenge_00_Exit)
            ForGroupBJ(udg__UnitGroup, Trig_Hex_Update_Func001Func006Func004A)
            bj_forLoopAIndex = bj_forLoopAIndex + 1
        end
    else
        DisplayTextToForce(GetForceOfPlayer(udg__Player), ("|c00ffcc00Eggs Delivered: |r" .. (I2S(udg_Challenge_Hex_EggsDelivered) .. "/10")))
        SetUnitMoveSpeed(udg_Challenge_Hex_WolfUnit, I2R((210 + (udg_Challenge_Hex_EggsDelivered * 10))))
    end
end

function InitTrig_Hex_Update()
    gg_trg_Hex_Update = CreateTrigger()
    TriggerAddAction(gg_trg_Hex_Update, Trig_Hex_Update_Actions)
end

function Trig_SecretHero_Func003A()
    RemoveUnit(GetEnumUnit())
end

function Trig_SecretHero_Actions()
    udg__Point = GetUnitLoc(udg_Player_HeroUnit[1])
    udg__UnitGroup = GetUnitsOfPlayerAll(Player(0))
    ForGroupBJ(udg__UnitGroup, Trig_SecretHero_Func003A)
    CreateNUnitsAtLoc(1, FourCC("H00C"), Player(0), udg__Point, bj_UNIT_FACING)
    udg_Player_HeroUnit[1] = GetLastCreatedUnit()
    SetCameraTargetControllerNoZForPlayer(Player(0), udg_Player_HeroUnit[1], 0, 0, false)
end

function InitTrig_SecretHero()
    gg_trg_SecretHero = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_SecretHero, Player(0), "'timeismana", true)
    TriggerAddAction(gg_trg_SecretHero, Trig_SecretHero_Actions)
end

function Trig_Debug_Actions()
    SetPlayerStateBJ(Player(0), PLAYER_STATE_RESOURCE_GOLD, 9999)
    SetPlayerStateBJ(Player(1), PLAYER_STATE_RESOURCE_GOLD, 9999)
    SetPlayerStateBJ(Player(2), PLAYER_STATE_RESOURCE_GOLD, 9999)
    SetPlayerStateBJ(Player(3), PLAYER_STATE_RESOURCE_GOLD, 9999)
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
    CreateItemLoc(FourCC("tkno"), GetPlayerStartLocationLoc(Player(0)))
end

function InitTrig_Debug()
    gg_trg_Debug = CreateTrigger()
    TriggerRegisterPlayerChatEvent(gg_trg_Debug, Player(0), "debug", true)
    TriggerAddAction(gg_trg_Debug, Trig_Debug_Actions)
end

function Trig_NPC_00_Greet_Actions()
    DisableTrigger(GetTriggeringTrigger())
    ForceCinematicSubtitlesBJ(true)
end

function InitTrig_NPC_00_Greet()
    gg_trg_NPC_00_Greet = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_NPC_00_Greet, gg_rct_NPC_00)
    TriggerAddAction(gg_trg_NPC_00_Greet, Trig_NPC_00_Greet_Actions)
end

function Trig_NPC_00_Sell_Func004C()
    if (not (GetUnitStateSwap(UNIT_STATE_MANA, udg__Unit) >= 30.00)) then
        return false
    end
    return true
end

function Trig_NPC_00_Sell_Actions()
    udg__Point = GetUnitLoc(udg__Unit)
    SetUnitManaBJ(udg__Unit, (GetUnitStateSwap(UNIT_STATE_MANA, udg__Unit) + 2.00))
    if (Trig_NPC_00_Sell_Func004C()) then
        ForceCinematicSubtitlesBJ(true)
        UnitRemoveAbilityBJ(FourCC("Aneu"), udg__Unit)
        UnitRemoveAbilityBJ(FourCC("Apit"), udg__Unit)
        AddSpecialEffectLocBJ(udg__Point, "Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl")
        DestroyEffectBJ(GetLastCreatedEffectBJ())
        RemoveUnit(udg__Unit)
    else
    end
end

function InitTrig_NPC_00_Sell()
    gg_trg_NPC_00_Sell = CreateTrigger()
    TriggerAddAction(gg_trg_NPC_00_Sell, Trig_NPC_00_Sell_Actions)
end

function Trig_Miniboss_00a_Start_Actions()
    DisableTrigger(GetTriggeringTrigger())
    ForceCinematicSubtitlesBJ(true)
    TransmissionFromUnitWithNameBJ(GetPlayersAll(), gg_unit_u006_0002, "TRIGSTR_441", gg_snd_ButcherIntro, "TRIGSTR_442", bj_TIMETYPE_ADD, 0, false)
end

function InitTrig_Miniboss_00a_Start()
    gg_trg_Miniboss_00a_Start = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Miniboss_00a_Start, gg_rct_Butcher_Zone)
    TriggerAddAction(gg_trg_Miniboss_00a_Start, Trig_Miniboss_00a_Start_Actions)
end

function Trig_Gate_00_Actions()
    DisableTrigger(GetTriggeringTrigger())
    PlaySoundBJ(gg_snd_GoodJob)
    ModifyGateBJ(bj_GATEOPERATION_OPEN, gg_dest_ATg4_0000)
end

function InitTrig_Gate_00()
    gg_trg_Gate_00 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Gate_00, gg_rct_Gate_00)
    TriggerAddAction(gg_trg_Gate_00, Trig_Gate_00_Actions)
end

function Trig_Gate_01_Actions()
    DisableTrigger(GetTriggeringTrigger())
    PlaySoundBJ(gg_snd_GoodJob)
    ModifyGateBJ(bj_GATEOPERATION_OPEN, gg_dest_DTg3_0657)
    RemoveDestructable(gg_dest_Ytlc_0658)
    RemoveDestructable(gg_dest_Ytlc_0660)
    RemoveDestructable(gg_dest_Ytlc_0659)
end

function InitTrig_Gate_01()
    gg_trg_Gate_01 = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Gate_01, gg_rct_Gate_01)
    TriggerAddAction(gg_trg_Gate_01, Trig_Gate_01_Actions)
end

function InitCustomTriggers()
    InitTrig_General_Init()
    InitTrig_HP_Enemy_Dies()
    InitTrig_HS_Spawn_Selectors()
    InitTrig_HS_Select_Heroes()
    InitTrig_HS_Spawn_Heroes()
    InitTrig_HD_Spawn_Wisp()
    InitTrig_HD_Wisp_Timer()
    InitTrig_CS_Init()
    InitTrig_CS_Detector_Dies()
    InitTrig_CS_Spawn_Zombie()
    InitTrig_CS_Spawn_Murgul()
    InitTrig_TES_INIT()
    InitTrig_Ranger_Focus()
    InitTrig_Battle_Frenzy()
    InitTrig_Combustion()
    InitTrig_Equip_Destruction_Spell()
    InitTrig_Spell_Book_Learn()
    InitTrig_Change_List()
    InitTrig_Ammo_Equip()
    InitTrig_Ammo_Level()
    InitTrig_Shadow_Strike()
    InitTrig_Holy_Light()
    InitTrig_Resurrection()
    InitTrig_Hex_INIT()
    InitTrig_Hex_Entrance()
    InitTrig_Hex_Fail()
    InitTrig_Hex_Egg_Get()
    InitTrig_Hex_Egg_Deliver()
    InitTrig_Hex_Update()
    InitTrig_SecretHero()
    InitTrig_Debug()
    InitTrig_NPC_00_Greet()
    InitTrig_NPC_00_Sell()
    InitTrig_Miniboss_00a_Start()
    InitTrig_Gate_00()
    InitTrig_Gate_01()
end

function RunInitializationTriggers()
    ConditionalTriggerExecute(gg_trg_General_Init)
    ConditionalTriggerExecute(gg_trg_TES_INIT)
end

function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    ForcePlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), false)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(1), 1)
    ForcePlayerStartLocation(Player(1), 1)
    SetPlayerColor(Player(1), ConvertPlayerColor(1))
    SetPlayerRacePreference(Player(1), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(1), false)
    SetPlayerController(Player(1), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(2), 2)
    ForcePlayerStartLocation(Player(2), 2)
    SetPlayerColor(Player(2), ConvertPlayerColor(2))
    SetPlayerRacePreference(Player(2), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(2), false)
    SetPlayerController(Player(2), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(3), 3)
    ForcePlayerStartLocation(Player(3), 3)
    SetPlayerColor(Player(3), ConvertPlayerColor(3))
    SetPlayerRacePreference(Player(3), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(3), false)
    SetPlayerController(Player(3), MAP_CONTROL_USER)
    SetPlayerStartLocation(Player(12), 4)
    ForcePlayerStartLocation(Player(12), 4)
    SetPlayerColor(Player(12), ConvertPlayerColor(12))
    SetPlayerRacePreference(Player(12), RACE_PREF_UNDEAD)
    SetPlayerRaceSelectable(Player(12), false)
    SetPlayerController(Player(12), MAP_CONTROL_COMPUTER)
end

function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
    SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(1), 0)
    SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(2), 0)
    SetPlayerState(Player(2), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerTeam(Player(3), 0)
    SetPlayerState(Player(3), PLAYER_STATE_ALLIED_VICTORY, 1)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(0), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    SetPlayerAllianceStateAllyBJ(Player(1), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(2), Player(3), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(0), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(1), true)
    SetPlayerAllianceStateAllyBJ(Player(3), Player(2), true)
    SetPlayerTeam(Player(12), 1)
end

function InitAllyPriorities()
    SetStartLocPrioCount(0, 3)
    SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(0, 1, 2, MAP_LOC_PRIO_LOW)
    SetStartLocPrio(0, 2, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(1, 3)
    SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 1, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(1, 2, 3, MAP_LOC_PRIO_LOW)
    SetStartLocPrioCount(2, 3)
    SetStartLocPrio(2, 0, 0, MAP_LOC_PRIO_LOW)
    SetStartLocPrio(2, 1, 1, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(2, 2, 3, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(3, 3)
    SetStartLocPrio(3, 0, 0, MAP_LOC_PRIO_HIGH)
    SetStartLocPrio(3, 1, 1, MAP_LOC_PRIO_LOW)
    SetStartLocPrio(3, 2, 2, MAP_LOC_PRIO_HIGH)
    SetStartLocPrioCount(4, 3)
    SetStartLocPrio(4, 0, 1, MAP_LOC_PRIO_LOW)
    SetStartLocPrio(4, 1, 2, MAP_LOC_PRIO_LOW)
end

function main()
    SetCameraBounds(-19712.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -19968.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 19712.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 19456.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -19712.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 19456.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 19712.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -19968.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCUnderground\\DNCUndergroundTerrain\\DNCUndergroundTerrain.mdl", "Environment\\DNC\\DNCUnderground\\DNCUndergroundUnit\\DNCUndergroundUnit.mdl")
    SetTerrainFogEx(0, 0.0, 5000.0, 0.500, 0.125, 0.125, 0.251)
    SetWaterBaseColor(32, 64, 32, 255)
    NewSoundEnvironment("Dungeon")
    SetAmbientDaySound("DungeonDay")
    SetAmbientNightSound("DungeonNight")
    SetMapMusic("Music", true, 0)
    InitSounds()
    CreateRegions()
    CreateAllDestructables()
    CreateAllUnits()
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
    RunInitializationTriggers()
end

function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(5)
    SetTeams(5)
    SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    DefineStartLocation(0, 0.0, -18880.0)
    DefineStartLocation(1, 64.0, -18944.0)
    DefineStartLocation(2, 0.0, -19008.0)
    DefineStartLocation(3, -64.0, -18944.0)
    DefineStartLocation(4, 19008.0, -17792.0)
    InitCustomPlayerSlots()
    InitCustomTeams()
    InitAllyPriorities()
end

