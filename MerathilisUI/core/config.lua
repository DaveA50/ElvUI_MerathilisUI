local E, L, V, P, G = unpack(ElvUI);
local MER = E:GetModule('MerathilisUI');

if E.db.mui == nil then E.db.mui = {} end
local tinsert = table.insert

local function AddOptions()
	E.Options.args.mui = {
		order = 9001,
		type = 'group',
		name = MER.Title,
		args = {
			name = {
				order = 1,
				type = 'header',
				name = MER.Title..MER:cOption(MER.Version)..L['by Merathilis (EU-Shattrath)'],
			},
			logo = {
				order = 2,
				type = 'description',
				name = L['MerathilisUI is an external ElvUI mod. Mostly it changes the Look of your UI. It is high recommended that you download |cff00c0faElvUI BenikUI|r to get the whole Style.'] ..'\n\n'..MER:cOption(L['Credits:'])..L[' Benik, Blazeflack, Darth Predator, Azilroka, Rockxana, Elv and all other AddOn Authors who inspired me.'],
				fontSize = 'medium',
				image = function() return 'Interface\\AddOns\\MerathilisUI\\media\\textures\\merathilis_logo.tga', 200, 100 end,
				imageCoords = {0,0.99,0.01,0.99},
			},			
			install = {
				order = 3,
				type = 'execute',
				name = L['Install'],
				desc = L['Run the installation process.'],
				func = function() MER:SetupUI(); E:ToggleConfig(); end,
			},
			spacer1 = {
				order = 4,
				type = 'header',
				name = '',
			},
			general = {
				order = 5,
				type = 'group',
				name = L['General'],
				guiInline = true,
				args = {
					LoginMsg = {
						order = 1,
						type = 'toggle',
						name = L['Login Message'],
						desc = L['Enable/Disable the Login Message in Chat'],
						get = function(info) return E.db.muiGeneral[ info[#info] ] end,
						set = function(info, value) E.db.muiGeneral[ info[#info] ] = value; end,	
					},
					SplashScreen = {
						order = 2,
						type = 'toggle',
						name = L['SplashScreen'],
						desc = L['Enable/Disable the Splash Screen on Login.'],
						get = function(info) return E.db.muiGeneral[ info[#info] ] end,
						set = function(info, value) E.db.muiGeneral[ info[#info] ] = value; end,
					},
					AFK = {
						order = 3,
						type = 'toggle',
						name = L['AFK'],
						desc = L['Enable/Disable the MUI AFK Screen'],
						get = function(info) return E.db.muiGeneral[ info[#info] ] end,
						set = function(info, value) E.db.muiGeneral[ info[#info] ] = value; E:StaticPopup_Show('PRIVATE_RL'); end,
					},
					GameMenu = {
						order = 4,
						type = 'toggle',
						name = L['GameMenu'],
						desc = L['Enable/Disable the MerathilisUI Style from the Blizzard GameMenu.'],
						get = function(info) return E.db.muiGeneral[ info[#info] ] end,
						set = function(info, value) E.db.muiGeneral[ info[#info] ] = value; E:StaticPopup_Show('PRIVATE_RL'); end,	
					},
					Bags = {
						order = 5,
						type = 'toggle',
						name = L['Bags'],
						desc = L['Enable/Disable the forcing of the Bag/Bank Frame position.'],
						get = function(info) return E.db.muiGeneral[ info[#info] ] end,
						set = function(info, value) E.db.muiGeneral[ info[#info] ] = value; E:StaticPopup_Show('PRIVATE_RL'); end,
					},
				},
			},
			config = {
				order = 20,
				type = 'group',
				name = L['Options'],
				childGroups = 'tab',
				args = {}
			},
		},
	}
end
tinsert(E.MerConfig, AddOptions)

local function muiMisc()
	E.Options.args.mui.args.misc = {
		order = 9,
		type = 'group',
		name = L['Misc'],
		guiInline = true,
		args = {
			TooltipIcon = {
				order = 1,
				type = 'toggle',
				name = L['Tooltip Icon'],
				desc = L['Adds an Icon for Items/Spells/Achievement on the Tooltip'],
				get = function(info) return E.db.muiMisc[ info[#info] ] end,
				set = function(info, value) E.db.muiMisc[ info[#info] ] = value; end,
			},
			HideAlertFrame = {
				order = 2,
				type = 'toggle',
				name = L['Garrison Alert Frame'],
				desc = L['Hides the Garrison Alert Frame while in combat.'],
				get = function(info) return E.db.muiMisc[ info[#info] ] end,
				set = function(info, value) E.db.muiMisc[ info[#info] ] = value; E:StaticPopup_Show('PRIVATE_RL'); end,
			},
			MailInputbox = {
				order = 3,
				type = 'toggle',
				name = L['Mail Inputbox Resize'],
				desc = L['Resize the Mail Inputbox and move the shipping cost to the Bottom'],
				get = function(info) return E.db.muiMisc[ info[#info] ] end,
				set = function(info, value) E.db.muiMisc[ info[#info] ] = value; E:StaticPopup_Show('PRIVATE_RL'); end,
			},
			FriendAlert = {
				order = 4,
				type = 'toggle',
				name = L['Battle.net Alert'],
				desc = L['Shows a Chat notification if a Battle.net Friend switch Games or goes offline.'],
				get = function(info) return E.db.muiMisc[ info[#info] ] end,
				set = function(info, value) E.db.muiMisc[ info[#info] ] = value; E:StaticPopup_Show('PRIVATE_RL'); end,
			},
			moveBlizz = {
				order = 5,
				type = 'toggle',
				name = L['moveBlizz'],
				desc = L['Make some Blizzard Frames movable.'],
				get = function(info) return E.db.muiMisc[ info[#info] ] end,
				set = function(info, value) E.db.muiMisc[ info[#info] ] = value; E:StaticPopup_Show('PRIVATE_RL'); end,
			},
			enchantScroll = {
				order = 6,
				type = 'toggle',
				name = L['Enchant on Scroll'],
				desc = L['Place a button in the Enchant Trade Window, allow you to automatically place a enchant on a scroll.'],
				get = function(info) return E.db.muiMisc[ info[#info] ] end,
				set = function(info, value) E.db.muiMisc[ info[#info] ] = value; E:StaticPopup_Show('PRIVATE_RL'); end,
			},
		},
	}
end
tinsert(E.MerConfig, muiMisc)
