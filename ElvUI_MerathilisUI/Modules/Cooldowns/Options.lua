local MER, E, L, V, P, G = unpack(select(2, ...))
local CF = MER:GetModule("CooldownFlash")

--Cache global variables
--Lua functions
local tinsert = table.insert
--WoW API / Variables
-- GLOBALS:

local function Cooldowns()
	local ACH = E.Libs.ACH

	E.Options.args.mui.args.modules.args.cooldowns = {
		type = "group",
		name = L["Cooldowns"],
		args = {
			cooldownFlash = {
				order = 1,
				type = "group",
				name = L["Cooldown Flash"],
				guiInline = true,
				get = function(info) return E.db.mui.cooldownFlash[ info[#info] ] end,
				set = function(info, value) E.db.mui.cooldownFlash[ info[#info] ] = value; E:StaticPopup_Show("PRIVATE_RL"); end,
				args = {
					header = ACH:Header(MER:cOption(L["Cooldown Flash"]), 1),
					credits = {
						order = 2,
						type = "group",
						name = MER:cOption(L["Credits"]),
						guiInline = true,
						args = {
							tukui = ACH:Description("Doom_CooldownPulse - by Woffle of Dark Iron[US]"),
						},
					},
					toggle = {
						order = 3,
						type = "toggle",
						name = L["Enable"],
						desc = CF.modName,
						get = function() return E.db.mui.cooldownFlash.enable ~= false or false end,
						set = function(info, v) E.db.mui.cooldownFlash.enable = v if v then CF:EnableCooldownFlash() else CF:DisableCooldownFlash() end end,
					},
					iconSize = {
						order = 4,
						name = L["Icon Size"],
						type = "range",
						min = 30, max = 125, step = 1,
						set = function(info, value) E.db.mui.cooldownFlash[ info[#info] ] = value; CF.DCP:SetSize(value, value) end,
						hidden = function() return not E.db.mui.cooldownFlash.enable end,
					},
					fadeInTime = {
						order = 5,
						name = L["Fadein duration"],
						type = "range",
						min = 0.5, max = 2.5, step = 0.1,
						hidden = function() return not E.db.mui.cooldownFlash.enable end,
					},
					fadeOutTime = {
						order = 6,
						name = L["Fadeout duration"],
						type = "range",
						min = 0.5, max = 2.5, step = 0.1,
						hidden = function() return not E.db.mui.cooldownFlash.enable end,
					},
					maxAlpha = {
						order = 7,
						name = L["Transparency"],
						type = "range",
						min = 0.25, max = 1, step = 0.05,
						isPercent = true,
						hidden = function() return not E.db.mui.cooldownFlash.enable end,
					},
					holdTime = {
						order = 8,
						name = L["Duration time"],
						type = "range",
						min = 0.3, max = 2.5, step = 0.1,
						hidden = function() return not E.db.mui.cooldownFlash.enable end,
					},
					animScale = {
						order = 9,
						name = L["Animation size"],
						type = "range",
						min = 0.5, max = 2, step = 0.1,
						hidden = function() return not E.db.mui.cooldownFlash.enable end,
					},
					showSpellName = {
						order = 10,
						name = L["Display spell name"],
						type = "toggle",
						hidden = function() return not E.db.mui.cooldownFlash.enable end,
					},
					enablePet = {
						order = 11,
						name = L["Watch on pet spell"],
						type = "toggle",
						get = function(info) return E.db.mui.cooldownFlash[ info[#info] ] end,
						set = function(info, value) E.db.mui.cooldownFlash[ info[#info] ] = value; if value then CF.DCP:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") else CF.DCP:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED") end end,
						hidden = function() return not E.db.mui.cooldownFlash.enable end,
					},
					test = {
						order = 12,
						name = L["Test"],
						type = "execute",
						func = function() CF:TestMode() end,
						hidden = function() return not E.db.mui.cooldownFlash.enable end,
					},
				},
			},
			raid = {
				order = 2,
				type = "group",
				name = L["RaidCD"],
				guiInline = true,
				get = function(info) return E.db.mui.raidCD[ info[#info] ] end,
				set = function(info, value) E.db.mui.raidCD[ info[#info] ] = value; E:StaticPopup_Show("PRIVATE_RL"); end,
				args = {
					header = ACH:Header(MER:cOption(L["RaidCD"]), 0),
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
					},
					spacer = {
						order = 2,
						type = "description",
						name = "",
					},
					width = {
						order = 3,
						type = "range",
						name = L["Width"],
						min = 5, max = 500, step = 1,
					},
					height = {
						order = 4,
						type = "range",
						name = L["Height"],
						min = 5, max = 200, step = 1,
					},
					upwards = {
						order = 6,
						type = "toggle",
						name = L["Sort Upwards"],
					},
					expiration = {
						order = 7,
						type = "toggle",
						name = L["Sort by Expiration Time"],
					},
					show_self = {
						order = 8,
						type = "toggle",
						name = L["Show Self Cooldown"],
					},
					show_icon = {
						order = 9,
						type = "toggle",
						name = L["Show Icons"],
					},
					spacer1 = {
						order = 10,
						type = "description",
						name = "",
						width = "full",
					},
					show_inparty = {
						order = 11,
						type = "toggle",
						name = L["Show In Party"],
					},
					show_inraid = {
						order = 12,
						type = "toggle",
						name = L["Show In Raid"],
					},
					show_inarena = {
						order = 13,
						type = "toggle",
						name = L["Show In Arena"],
					},
					text = {
						order = 20,
						type = "group",
						name = L["Font"],
						guiInline = true,
						get = function(info) return E.db.mui.raidCD.text[ info[#info] ] end,
						set = function(info, value) E.db.mui.raidCD.text[ info[#info] ] = value; E:StaticPopup_Show("PRIVATE_RL"); end,
						args = {
							font = {
								order = 1,
								type = "select", dialogControl = "LSM30_Font",
								name = L["Font"],
								values = AceGUIWidgetLSMlists.font,
							},
							fontSize = {
								order = 2,
								name = L["FONT_SIZE"],
								type = "range",
								min = 6, max = 30, step = 1,
							},
							fontOutline = {
								order = 3,
								type = "select",
								name = L["Font Outline"],
								values = {
									["NONE"] = NONE,
									["OUTLINE"] = "OUTLINE",
									["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
									["THICKOUTLINE"] = "THICKOUTLINE",
								},
							},
						},
					},
				},
			},
		},
	}
end
tinsert(MER.Config, Cooldowns)
