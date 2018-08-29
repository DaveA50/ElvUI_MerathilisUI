local MER, E, L, V, P, G = unpack(select(2, ...))
local RB = MER:GetModule("RaidBuffs")

--Cache global variables

--WoW API / Variables
local AGGRO_WARNING_IN_PARTY = AGGRO_WARNING_IN_PARTY
local CUSTOM, DEFAULT = CUSTOM, DEFAULT
--Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS:

local function RaidBuffs()
	E.Options.args.mui.args.raidBuffs = {
		type = "group",
		name = RB.modName,
		order = 31,
		get = function(info) return E.db.mui.raidBuffs[ info[#info] ] end,
		args = {
			name = {
				order = 1,
				type = "header",
				name = MER:cOption(RB.modName),
			},
			rbreminder = {
				order = 2,
				type = "group",
				name = MER:cOption(RB.modName),
				guiInline = true,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						desc = L["Shows a frame with flask/food/rune."],
						set = function(info, value) E.db.mui.raidBuffs.enable = value; RB:Visibility() end,
					},
					space1 = {
						order = 2,
						type = 'description',
						name = "",
						hidden = function() return not E.db.mui.raidBuffs.enable end,
					},
					visibility = {
						type = 'select',
						order = 3,
						name = L["Visibility"],
						disabled = function() return not E.db.mui.raidBuffs.enable end,
						hidden = function() return not E.db.mui.raidBuffs.enable end,
						set = function(info, value) E.db.mui.raidBuffs.visibility = value; RB:Visibility() end,
						values = {
							["DEFAULT"] = DEFAULT,
							["INPARTY"] = AGGRO_WARNING_IN_PARTY,
							["ALWAYS"] = L["Always Display"],
							["CUSTOM"] = CUSTOM,
						},
					},
					class = {
						order = 4,
						type = "toggle",
						name = L["Class Specific Buffs"],
						desc = L["Shows all the class specific raid buffs."],
						disabled = function() return not E.db.mui.raidBuffs.enable end,
						hidden = function() return not E.db.mui.raidBuffs.enable end,
						set = function(info, value) E.db.mui.raidBuffs.class = value; E:StaticPopup_Show("PRIVATE_RL"); end,
					},
					alpha = {
						order = 4,
						type = "range",
						name = L["Alpha"],
						desc = L["Change the alpha level of the icons."],
						min = 0, max = 1, step = 0.1,
						disabled = function() return not E.db.mui.raidBuffs.enable end,
						hidden = function() return not E.db.mui.raidBuffs.enable end,
						set = function(info, value) E.db.mui.raidBuffs.alpha = value; E:StaticPopup_Show("PRIVATE_RL"); end,
					},
					customVisibility = {
						order = 15,
						type = 'input',
						width = 'full',
						name = L["Visibility State"],
						disabled = function() return E.db.mui.raidBuffs.visibility ~= "CUSTOM" or not E.db.mui.raidBuffs.enable end,
						hidden = function() return not E.db.mui.raidBuffs.enable end,
						set = function(info, value) E.db.mui.raidBuffs.customVisibility = value; RB:Visibility() end,
					},
				},
			},
		},
	}
end
tinsert(MER.Config, RaidBuffs)