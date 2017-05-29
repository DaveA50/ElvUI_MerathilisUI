local MER, E, L, V, P, G = unpack(select(2, ...))
local MERS = E:GetModule("muiSkins")

-- Cache global variables
-- Lua functions
local _G = _G
local ipairs, unpack = ipairs, unpack
-- WoW API / Variables
local IsAddOnLoaded = IsAddOnLoaded

local DecorAddons = {
	{"ActionBarProfiles", L["ActonBarProfiles"], "abp"},
	{"BigWigs", L["BigWigs"], "bw"},
	{"WeakAuras", L["WeakAuras"], "wa"},
	{"XIV_Databar", L["XIV_Databar"], "xiv"},
	{"PremadeGroupsFilter", L["PremadeGroupsFilter"], "pgf"},
}

local SupportedProfiles = {
	{"AddOnSkins", "AddOnSkins"},
	{"BigWigs", "BigWigs"},
	{"Details", "Details"},
	{"ElvUI_BenikUI", "BenikUI"},
	{"ElvUI_SLE", "Shadow&Light"},
	{"Kui_Nameplates_Core", "KuiNamePlates"},
	{"Masque", "Masque"},
	{"Skada", "Skada"},
	{"SorhaQuestLog", "SorhaQuestLog"},
	{"XIV_Databar", "XIV_Databar"},
}

local profileString = format('|cfffff400%s |r', L["MerathilisUI successfully created and applied profile(s) for:"])

local function SkinsTable()
	E.Options.args.mui.args.skins = {
		order = 15,
		type = "group",
		name = MERS.modName..MER.NewSign,
		args = {
			name = {
				order = 1,
				type = "header",
				name = MER:cOption(MERS.modName),
			},
		},
	}

	E.Options.args.mui.args.skins.args.addonskins = {
		order = 4,
		type = "group",
		guiInline = true,
		name = MER:cOption(L["AddOnSkins"]),
		get = function(info) return E.private.muiSkins.addonSkins[ info[#info] ] end,
		set = function(info, value) E.private.muiSkins.addonSkins[ info[#info] ] = value; E:StaticPopup_Show("PRIVATE_RL") end,
		args = {
			},
		}

	local addorder = 0
	for i, v in ipairs(DecorAddons) do
		local addonName, addonString, addonOption = unpack( v )
		E.Options.args.mui.args.skins.args.addonskins.args[addonOption] = {
			order = addorder + 1,
			type = "toggle",
			name = addonString,
			disabled = function() return not IsAddOnLoaded(addonName) end,
		}
	end

	E.Options.args.mui.args.skins.args.blizzard = {
		order = 5,
		type = "group",
		guiInline = true,
		name = MER:cOption(L["Blizzard"]),
		get = function(info) return E.private.muiSkins.blizzard[ info[#info] ] end,
		set = function(info, value) E.private.muiSkins.blizzard[ info[#info] ] = value; E:StaticPopup_Show("PRIVATE_RL") end,
		args = {
			info = {
				order = 1,
				type = "description",
				name = L["MER_SKINS_DESC"],
			},
			space1 = {
				order = 2,
				type = "description",
				name = "",
			},
			gotoskins = {
				order = 3,
				type = "execute",
				name = L["ElvUI Skins"],
				func = function() LibStub("AceConfigDialog-3.0-ElvUI"):SelectGroup("ElvUI", "skins") end,
			},
			space2 = {
				order = 4,
				type = "description",
				name = "",
			},
			encounterjournal = {
				order = 10,
				type = "toggle",
				name = L["Encounter Journal"],
				disabled = function () return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.encounterjournal end
			},
			spellbook = {
				order = 11,
				type = "toggle",
				name = L["Spellbook"],
				disabled = function() return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.spellbook end,
			},
			character = {
				order = 12,
				type = "toggle",
				name = L["Character Frame"],
				disabled = function() return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.character end,
			},
			gossip = {
				order = 13,
				type = "toggle",
				name = L["Gossip Frame"],
				disabled = function() return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.gossip end,
			},
			quest = {
				order = 14,
				type = "toggle",
				name = L["Quest Frames"],
				disabled = function() return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.quest end,
			},
			orderhall = {
				order = 15,
				type = "toggle",
				name = L["Orderhall"]..MER.NewSign,
				disabled = function() return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.orderhall end,
			},
			garrison = {
				order = 16,
				type = "toggle",
				name = GARRISON_LOCATION_TOOLTIP..MER.NewSign,
				disabled = function() return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.garrison end,
			},
			talent = {
				order = 17,
				type = "toggle",
				name = L["Talent Frame"],
				disabled = function() return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.talent end,
			},
			auctionhouse = {
				order = 18,
				type = "toggle",
				name = L["Auction Frame"]..MER.NewSign,
				disabled = function() return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.auctionhouse end,
			},
			friends = {
				order = 19,
				type = "toggle",
				name = L["Friends"]..MER.NewSign,
				disabled = function() return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.friends end,
			},
			contribution = {
				order = 20,
				type = "toggle",
				name = L["Contribution"]..MER.NewSign,
				disabled = function() return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.Contribution end,
			},
			contribution = {
				order = 21,
				type = "toggle",
				name = L["Artifact"]..MER.NewSign,
				disabled = function() return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.artifact end,
			},
			collections = {
				order = 22,
				type = "toggle",
				name = COLLECTIONS..MER.NewSign,
				disabled = function() return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.collections end,
			},
			calendar = {
				order = 23,
				type = "toggle",
				name = L["Calendar Frame"]..MER.NewSign,
				disabled = function() return not E.private.skins.blizzard.enable or not E.private.skins.blizzard.calendar end,
			},
		},
	}

	E.Options.args.mui.args.skins.args.profiles = {
		order = 6,
		type = "group",
		guiInline = true,
		name = MER:cOption(L["Profiles"]),
		args = {
		},
	}

	for i, v in ipairs(SupportedProfiles) do
		local addon, addonName = unpack(v)
		local optionOrder = 1
		E.Options.args.mui.args.skins.args.profiles.args[addon] = {
			order = optionOrder + 1,
			type = "execute",
			name = addonName,
			desc = L["This will create and apply profile for "]..addonName,
			func = function()
				if addon == 'BigWigs' then
					MER:LoadBigWigsProfile()
					E:StaticPopup_Show('PRIVATE_RL')
				elseif addon == 'ElvUI_BenikUI' then
					MER:LoadBenikUIProfile()
					E:StaticPopup_Show('PRIVATE_RL')
				elseif addon == 'ElvUI_SLE' then
					MER:LoadShadowandLightProfile()
					E:StaticPopup_Show('PRIVATE_RL')
				elseif addon == 'Kui_Nameplates_Core' then
					MER:LoadKuiNamePlatesCoreProfile()
					E:StaticPopup_Show('PRIVATE_RL')
				elseif addon == 'Masque' then
					MER:LoadMasqueProfile()
					E:StaticPopup_Show('PRIVATE_RL')
				elseif addon == 'SorhaQuestLog' then
					MER:LoadSorhaQuestLogProfile()
					E:StaticPopup_Show('PRIVATE_RL')
				elseif addon == 'Skada' then
					MER:LoadSkadaProfile()
					E:StaticPopup_Show('PRIVATE_RL')
				elseif addon == 'Details' then
					MER:LoadDetailsProfile()
					E:StaticPopup_Show('PRIVATE_RL')
				elseif addon == 'XIV_Databar' then
					MER:LoadXIVDatabarProfile()
					E:StaticPopup_Show('PRIVATE_RL')
				elseif addon == 'AddOnSkins' then
					MER:LoadAddOnSkinsProfile()
					E:StaticPopup_Show('PRIVATE_RL')
				end
				print(profileString..addonName)
			end,
			disabled = function() return not IsAddOnLoaded(addon) end,
		}
	end
end
tinsert(MER.Config, SkinsTable)