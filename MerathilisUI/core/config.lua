local E, L, V, P, G, _ = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local MER = E:GetModule('MerathilisUI');

if E.db.Merathilis == nil then E.db.Merathilis = {} end

local function merCore()
	E.Options.args.mer = {
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
				name = L['MerathilisUI is an external ElvUI mod. Mostly based on |cff00c0faElvUI BenikUI|r. '] ..'\n\n'..MER:cOption(L['Credits:'])..L[' Benik, Azilroka, Elv, Blazeflack'],
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
			spacer2 = {
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
						order = 3,
						type = 'toggle',
						name = L['Login Message'],
						get = function(info) return E.db.Merathilis[ info[#info] ] end,
						set = function(info, value) E.db.Merathilis[ info[#info] ] = value; end,	
					},
				},
			},

			config = {
				order = 20,
				type = 'group',
				name = L['Options'],
				childGroups = 'tab',
				args = {},
			},
		},
	}
end

table.insert(E.MerConfig, merCore)
