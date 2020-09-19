local MER, E, L, V, P, G = unpack(select(2, ...))
local MI = MER:GetModule('mUIMisc')
local SA = MER:GetModule('MER_SpellAlert')

--Cache global variables
--Lua functions
local _G = _G
local tinsert = table.insert
--WoW API / Variables
local GUILD_MOTD_LABEL2 = GUILD_MOTD_LABEL2
-- GLOBALS:

local function Misc()
	local ACH = E.Libs.ACH

	E.Options.args.mui.args.modules.args.misc = {
		type = "group",
		name = L["Miscellaneous"],
		get = function(info) return E.db.mui.misc[ info[#info] ] end,
		set = function(info, value) E.db.mui.misc[ info[#info] ] = value; E:StaticPopup_Show("PRIVATE_RL"); end,
		args = {
			name = ACH:Header(MER:cOption(L["Miscellaneous"]), 1),
			MailInputbox = {
				order = 2,
				type = "toggle",
				name = L["Mail Inputbox Resize"],
				desc = L["Resize the Mail Inputbox and move the shipping cost to the Bottom"],
			},
			gmotd = {
				order = 3,
				type = "toggle",
				name = L.GUILD_MOTD_LABEL2,
				desc = L["Display the Guild Message of the Day in an extra window, if updated."],
			},
			cursor = {
				order = 6,
				type = "toggle",
				name = L["Flashing Cursor"],
			},
			funstuff = {
				order = 7,
				type = "toggle",
				name = L["Fun Stuff"],
			},
			wowheadlinks = {
				order = 8,
				type = "toggle",
				name = L["Wowhead Links"],
				desc = L["Adds Wowhead links to the Achievement- and WorldMap Frame"],
			},
			respec = {
				order = 9,
				type = "toggle",
				name = L["Codex Buttons"],
				desc = L["Adds two buttons on your Talent Frame, with Codex or Tome Items"],
			},
			lfgInfo = {
				order = 10,
				type = "toggle",
				name = L["LFG Member Info"],
				desc = L["Shows role informations in your tooltip in the lfg frame."],
			},
			spellAlert = {
				order = 11,
				type = "range",
				name = L["Spell Alert Scale"],
				min = 0.4, max = 1.5, step = 0.01,
				get = function(info) return E.db.mui.misc.spellAlert end,
				set = function(info, value) E.db.mui.misc.spellAlert = value; SA:Resize() end,
			},
			alerts = {
				order = 20,
				type = "group",
				name = MER:cOption(L["Alerts"]),
				guiInline = true,
				get = function(info) return E.db.mui.misc.alerts[ info[#info] ] end,
				set = function(info, value) E.db.mui.misc.alerts[ info[#info] ] = value; E:StaticPopup_Show("PRIVATE_RL"); end,
				args = {
					lfg = {
						order = 1,
						type = "toggle",
						name = L["Call to Arms"],
					},
					announce = {
						order = 2,
						type = "toggle",
						name = L["Announce"],
						desc = L["Skill gains"],
					},
					itemAlert = {
						order = 3,
						type = "toggle",
						name = L["Item Alerts"],
						desc = L["Announce in chat when someone placed an usefull item."],
					},
				},
			},
			quest = {
				order = 21,
				type = "group",
				name = MER:cOption(L["Quest"]),
				guiInline = true,
				get = function(info) return E.db.mui.misc.quest[ info[#info] ] end,
				set = function(info, value) E.db.mui.misc.quest[ info[#info] ] = value; E:StaticPopup_Show("PRIVATE_RL"); end,
				args = {
					selectQuestReward = {
						order = 1,
						type = "toggle",
						name = L["Highest Quest Reward"],
						desc = L["Automatically select the item with the highest reward."],
					},
					questAnnounce = {
						order = 2,
						type = "toggle",
						name = L["Quest Announcer"],
					},
				},
			},
			paragon = {
				order = 22,
				type = "group",
				name = MER:cOption(L["MISC_PARAGON_REPUTATION"]),
				guiInline = true,
				get = function(info) return E.db.mui.misc.paragon[ info[#info] ] end,
				set = function(info, value) E.db.mui.misc.paragon[ info[#info] ] = value; end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
					},
					textStyle = {
						order = 2,
						type = "select",
						name = L["Text Style"],
						disabled = function() return not E.db.mui.misc.paragon.enable end,
						values = {
							["PARAGON"] = L["MISC_PARAGON"],
							["CURRENT"] = L["Current"],
							["VALUE"] = L["Value"],
							["DEFICIT"] = L["Deficit"],
						},
					},
					paragonColor = {
						order = 3,
						name = L["COLOR"],
						type = "color",
						disabled = function() return not E.db.mui.misc.paragon.enable end,
						hasAlpha = false,
						get = function(info)
							local t = E.db.mui.misc.paragon[ info[#info] ]
							local d = P.mui.misc.paragon[info[#info]]
							return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a
						end,
						set = function(info, r, g, b, a)
							local t = E.db.mui.misc.paragon[ info[#info] ]
							t.r, t.g, t.b, t.a = r, g, b, a
						end,
					},
				},
			},
			macros = {
				order = 23,
				type = "group",
				name = MER:cOption(L["Macros"]),
				guiInline = true,
				args = {
					randomtoy = {
						order = 1,
						type = "input",
						name = L["Random Toy"],
						desc = L["Creates a random toy macro."],
						get = function() return "/randomtoy" end,
						set = function() return end,
					},
				},
			},
		},
	}
end
tinsert(MER.Config, Misc)
