local MER, F, E, L, V, P, G = unpack(select(2, ...))

function MER:LoadDBMProfile()
	DBM:CreateProfile("MerathilisUI")

	DBM_AllSavedOptions = {
		["MerathilisUI"] = {
			["DontShowFarWarnings"] = true,
			["ChosenVoicePack"] = "None",
			["DontShowHudMap2"] = false,
			["AlwaysPlayVoice"] = false,
			["ShowSWarningsInChat"] = true,
			["RangeFrameRadarY"] = 50.0000534057617,
			["StatusEnabled"] = true,
			["DontRestoreIcons"] = false,
			["DontShowNameplateIcons"] = false,
			["CoreSavedRevision"] = 17424,
			["RangeFrameX"] = 50,
			["RangeFrameY"] = -50,
			["FilterInterruptNoteName"] = false,
			["EnableModels"] = true,
			["SpecialWarningFlashAlph3"] = 0.4,
			["ArrowPoint"] = "TOP",
			["SWarnNameInNote"] = true,
			["FakeBWVersion"] = false,
			["InfoFramePoint"] = "CENTER",
			["EventSoundMusicCombined"] = false,
			["SpecialWarningFlashCol2"] = {
				1, -- [1]
				0.5, -- [2]
				0, -- [3]
			},
			["WarningAlphabetical"] = true,
			["SpecialWarningPoint"] = "CENTER",
			["CheckGear"] = true,
			["SpecialWarningX"] = 0,
			["WorldBossAlert"] = false,
			["DontShowPT2"] = false,
			["DontShowSpecialWarnings"] = false,
			["ShowMinimapButton"] = false,
			["ShowGuildMessages"] = true,
			["ShowQueuePop"] = true,
			["SpecialWarningFlashCol4"] = {
				1, -- [1]
				0, -- [2]
				1, -- [3]
			},
			["DebugMode"] = false,
			["DontShowTargetAnnouncements"] = true,
			["ShowWarningsInChat"] = false,
			["SpecialWarningFontCol"] = {
				1, -- [1]
				0.7, -- [2]
				0, -- [3]
			},
			["WarningFontStyle"] = "None",
			["InfoFrameY"] = -84.0000686645508,
			["ChatFrame"] = "DEFAULT_CHAT_FRAME",
			["WarningIconRight"] = true,
			["UseSoundChannel"] = "Master",
			["RangeFrameRadarX"] = 424.000610351562,
			["ShowRespawn"] = true,
			["EventSoundWipe"] = "None",
			["AlwaysShowSpeedKillTimer2"] = false,
			["FilterDispel"] = true,
			["ShowGuildMessagesPlus"] = false,
			["LFDEnhance"] = true,
			["SpecialWarningFlashDura1"] = 0.4,
			["DontShowPTNoID"] = false,
			["HideGarrisonToasts"] = true,
			["RangeFramePoint"] = "CENTER",
			["SpecialWarningFontShadow"] = true,
			["EventMusicMythicFilter"] = true,
			["HideBossEmoteFrame2"] = true,
			["HideObjectivesFrame"] = true,
			["SpecialWarningFlashCol1"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
			},
			["DontShowPTText"] = false,
			["SpecialWarningFontSize2"] = 35,
			["SpecialWarningFlashCol5"] = {
				0.2, -- [1]
				1, -- [2]
				1, -- [3]
			},
			["SpecialWarningFlashAlph4"] = 0.4,
			["EventSoundDungeonBGM"] = "None",
			["CountdownVoice2"] = "Kolt",
			["AutoAcceptGuildInvite"] = false,
			["ArrowPosX"] = 0,
			["AITimer"] = true,
			["SpecialWarningFlashDura3"] = 1,
			["MovieFilter"] = "AfterFirst",
			["SpecialWarningSound4"] = "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg",
			["DisableSFX"] = false,
			["AutologBosses"] = false,
			["SpecialWarningFlashDura4"] = 0.7,
			["SpecialWarningFlashCol3"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
			},
			["WarningColors"] = {
				{
					["r"] = 0.411764705882353,
					["g"] = 0.8,
					["b"] = 0.941176470588235,
				}, -- [1]
				{
					["r"] = 0.949019607843137,
					["g"] = 0.949019607843137,
					["b"] = 0,
				}, -- [2]
				{
					["r"] = 1,
					["g"] = 0.501960784313726,
					["b"] = 0,
				}, -- [3]
				{
					["r"] = 1,
					["g"] = 0.101960784313725,
					["b"] = 0.101960784313725,
				}, -- [4]
			},
			["SWarningAlphabetical"] = true,
			["BlockNoteShare"] = false,
			["ModelSoundValue"] = "Short",
			["FilterSelfHud"] = true,
			["HelpMessageVersion"] = 3,
			["FilterInterrupt"] = true,
			["RangeFrameRadarPoint"] = "BOTTOM",
			["SpecialWarningY"] = 75,
			["AutoCorrectTimer"] = false,
			["DebugLevel"] = 1,
			["RangeFrameUpdates"] = "Average",
			["CountdownVoice3v2"] = "Pewsey",
			["ForumsMessageShown"] = false,
			["RaidWarningSound"] = "Sound\\Doodad\\BellTollNightElf.ogg",
			["CustomSounds"] = 0,
			["RoleSpecAlert"] = true,
			["SpecialWarningFlashRepeat3"] = true,
			["ShortTimerText"] = true,
			["WhisperStats"] = false,
			["VoiceOverSpecW2"] = "DefaultOnly",
			["LatencyThreshold"] = 250,
			["DontPlayPTCountdown"] = false,
			["SpecialWarningFlashAlph5"] = 0.5,
			["SpecialWarningDuration2"] = 1.5,
			["SpecialWarningSound"] = "Sound\\Spells\\PVPFlagTaken.ogg",
			["EventSoundMusic"] = "None",
			["WarningIconLeft"] = true,
			["RangeFrameSound1"] = "none",
			["AutoReplySound"] = true,
			["WarningFontSize"] = 20,
			["EventSoundVictory2"] = "None",
			["SpecialWarningFlashDura2"] = 0.4,
			["LastRevision"] = 0,
			["ShowAllVersions"] = true,
			["SettingsMessageShown"] = true,
			["DontShowInfoFrame"] = false,
			["PTCountThreshold"] = 5,
			["DontRestoreRange"] = false,
			["InfoFrameX"] = -292,
			["DontSetIcons"] = false,
			["BigBrotherAnnounceToRaid"] = false,
			["SpecialWarningSound2"] = "Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.ogg",
			["CountdownVoice"] = "Corsica",
			["MoviesSeen"] = {},
			["DontShowReminders"] = false,
			["SpecialWarningFlashRepeat2"] = false,
			["DisableStatusWhisper"] = false,
			["SpecialWarningFlashRepeat5"] = true,
			["AutoRespond"] = true,
			["EventDungMusicMythicFilter"] = true,
			["SpecialWarningFlashRepeat1"] = false,
			["RangeFrameFrames"] = "radar",
			["DontPlayCountdowns"] = false,
			["ShowBigBrotherOnCombatStart"] = false,
			["SpecialWarningIcon"] = true,
			["AdvancedAutologBosses"] = false,
			["SpecialWarningFlashAlph1"] = 0.3,
			["ShowDefeatMessage"] = false,
			["FilterTankSpec"] = true,
			["DontShowRangeFrame"] = false,
			["ArrowPosY"] = -150,
			["InfoFrameShowSelf"] = false,
			["WarningFontShadow"] = true,
			["SpecialWarningFlashDura5"] = 1,
			["SpecialWarningFlashRepeat4"] = false,
			["DontShowBossTimers"] = false,
			["SpecialWarningFontStyle"] = "OUTLINE",
			["SpecialWarningFont"] = "Interface\\AddOns\\ElvUI\\media\\fonts\\Expressway.ttf",
			["DontShowUserTimers"] = false,
			["DontShowBossAnnounces"] = false,
			["WorldBossNearAlert"] = false,
			["InfoFrameLines"] = 0,
			["SpecialWarningFlashAlph2"] = 0.3,
			["SpecialWarningFlashRepeatAmount"] = 2,
			["AutoAcceptFriendInvite"] = false,
			["WarningIconChat"] = false,
			["WarningX"] = 0,
			["HideGuildChallengeUpdates"] = true,
			["SpecialWarningSound5"] = "Sound\\Creature\\Loathstare\\Loa_Naxx_Aggro02.ogg",
			["DontSendYells"] = false,
			["ShowPizzaMessage"] = false,
			["RangeFrameSound2"] = "none",
			["HideTooltips"] = false,
			["WarningDuration2"] = 1.5,
			["SWarnClassColor"] = true,
			["Enabled"] = true,
			["WarningY"] = 260,
			["EventSoundEngage"] = "",
			["WarningPoint"] = "CENTER",
			["WarningFont"] = "Interface\\AddOns\\ElvUI\\media\\fonts\\Expressway.ttf",
			["RangeFrameLocked"] = false,
			["HideQuestTooltips"] = true,
			["LogOnlyRaidBosses"] = false,
			["StripServerName"] = true,
			["ShowEngageMessage"] = false,
			["SpecialWarningSound3"] = "Interface\\AddOns\\DBM-Core\\sounds\\AirHorn.ogg",
			["DontShowPTCountdownText"] = false,
			["RLReadyCheckSound"] = true,
			["AFKHealthWarning"] = false,
			["DisableGuildStatus"] = false,
			["ShowFlashFrame"] = true,
		},
	}

	DBT_AllPersistentOptions = {
		["MerathilisUI"] = {
			["DBM"] = {
				["StartColorPR"] = 1,
				["Scale"] = 1,
				["EnlargeBarsPercent"] = 0.125,
				["EndColorPB"] = 0.286274509803922,
				["EndColorPR"] = 0.501960784313726,
				["ExpandUpwardsLarge"] = true,
				["ExpandUpwards"] = true,
				["TimerPoint"] = "BOTTOM",
				["EndColorDG"] = 0,
				["HugeTimerPoint"] = "BOTTOM",
				["EndColorUIG"] = 0.92156862745098,
				["StartColorUIR"] = 1,
				["StartColorAG"] = 0.545098039215686,
				["EndColorDR"] = 1,
				["HugeBarXOffset"] = 0,
				["StartColorRR"] = 0.501960784313726,
				["StartColorUIG"] = 1,
				["HugeScale"] = 1,
				["BarYOffset"] = 8,
				["StartColorDG"] = 0.301960784313726,
				["StartColorAR"] = 0.376470588235294,
				["EndColorAER"] = 1,
				["StartColorIB"] = 1,
				["Font"] = "Interface\\AddOns\\ElvUI\\media\\fonts\\Expressway.ttf",
				["EndColorAEB"] = 0.247058823529412,
				["Height"] = 22,
				["BarXOffset"] = 0,
				["EndColorB"] = 0,
				["EndColorAR"] = 0.149019607843137,
				["EndColorUIB"] = 0.0117647058823529,
				["Decimal"] = 60,
				["EndColorIB"] = 1,
				["HugeWidth"] = 185,
				["TimerX"] = -324.499877929688,
				["EndColorIR"] = 0.0470588235294118,
				["EndColorRR"] = 0.109803921568627,
				["Texture"] = "Interface\\AddOns\\ElvUI_MerathilisUI\\media\\textures\\Flat.tga",
				["BarStyle"] = "NoAnim",
				["EnlargeBarTime"] = 11,
				["StartColorPG"] = 0.776470588235294,
				["FontFlag"] = "OUTLINE",
				["EndColorAB"] = 1,
				["Width"] = 200,
				["EndColorPG"] = 0.411764705882353,
				["EndColorIG"] = 0.87843137254902,
				["EndColorAEG"] = 0.0431372549019608,
				["StartColorAEB"] = 0.458823529411765,
				["HugeTimerY"] = 247.499816894531,
				["HugeTimerX"] = -434.000122070313,
				["TimerY"] = 14.0001039505005,
				["StartColorAB"] = 1,
				["EndColorDB"] = 1,
				["FontSize"] = 12,
				["StartColorR"] = 1,
				["HugeBarYOffset"] = 8,
				["EndColorRB"] = 0.301960784313726,
				["StartColorAEG"] = 0.466666666666667,
				["EndColorUIR"] = 1,
				["EndColorRG"] = 1,
				["StartColorUIB"] = 0.0627450980392157,
				["StartColorG"] = 0.701960784313726,
				["StartColorDR"] = 0.901960784313726,
				["EndColorG"] = 0,
				["EndColorR"] = 1,
				["StartColorRG"] = 1,
				["StartColorIR"] = 0.470588235294118,
				["StartColorAER"] = 1,
				["EndColorAG"] = 0.384313725490196,
				["StartColorB"] = 0,
				["StartColorDB"] = 1,
				["StartColorIG"] = 0.968627450980392,
				["StartColorPB"] = 0.419607843137255,
				["StartColorRB"] = 0.501960784313726,
			},
		},
	}

	DBM:ApplyProfile("MerathilisUI")
end

E.PopupDialogs["MUI_INSTALL_DBM_LAYOUT"] = {
	text = L["MUI_INSTALL_SETTINGS_LAYOUT_DBM"],
	OnAccept = function() MER:LoadDBMProfile(); ReloadUI() end,
	button1 = 'DBM Layout',
}
