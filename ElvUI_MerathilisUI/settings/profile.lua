local E, L, V, P, G = unpack(ElvUI);

----------------------------------------------------------------------------------------
--	Core options
----------------------------------------------------------------------------------------
P['mui'] = {
	['installed'] = nil,
	
	['general'] = {
		['LoginMsg'] = true, -- Enable welcome message in chat
		['GameMenu'] = true, -- Enable the Styles GameMenu
		['SplashScreen'] = true, -- Enable the SplashScreen on LogIn
		['AFK'] = true, -- Enable the pimped AFK Screen
		['FlightMode'] = true, -- Enable the FlightMode
	},

	['misc'] = {
		['MailInputbox'] = true, -- Resize the MailInputbox
		['Tooltip'] = true, -- Add Icon for Spells/Items/Achievement to the Tooltip and show the Achievement Progress
		['moveBlizz'] = true, -- Make Blizzards Frame movable
		['tradeTabs'] = true, -- Add tabs for Professions on the Tradeskillframe
		['gmotd'] = true, -- Show a GMOTD frame
		['vignette'] = true, -- Shows Rars/Treasures
	},

	['datatexts'] = {
		['rightChatTabDatatextPanel'] = true,
		['panels'] = {
			['ChatTab_Datatext_Panel'] = {
				['left'] = 'Call to Arms',
				['middle'] = 'Coords',
				['right'] = 'Bags',
			},
		},
	},

	['systemDT'] = {
		['maxAddons'] = 25, -- Sets how many Addons to show
		['showFPS'] = true, -- Show Frames per seconds
		['showMS'] = true, -- Show Ping
		['latency'] = "home", -- Set the latency type ("home", "world")
		['showMemory'] = false, -- Show Memory usage
		['announceFreed'] = true -- Enable the Garbage Message in Chat
	},

	["unitframes"] = {
		["groupinfo"] = true,
		["unit"] = {
			["player"] = {
				["rested"] = {
					["xoffset"] = 0,
					["yoffset"] = 0,
					["size"] = 16,
					["texture"] = "DEFAULT",
				},
			},
		},
	},

	["locPanel"] = {
		["enable"] = false,
		["autowidth"] = false,
		["width"] = 245,
		["height"] = 21,
		["linkcoords"] = true,
		["template"] = "Transparent",
		["font"] = "Merathilis Roboto-Black",
		["fontSize"] = 11,
		["fontOutline"] = "OUTLINE",
		["throttle"] = 0.2,
		["format"] = "%.0f",
		["zoneText"] = true,
		["colorType"] = "REACTION",
		["colorType_Coords"] = "DEFAULT",
		["customColor"] = {r = 1, g = 1, b = 1 },
		["customColor_Coords"] = {r = 1, g = 1, b = 1 },
		["combathide"] = false,
		["portals"] = {
			["enable"] = true,
			["HSplace"] = true,
			["customWidth"] = false,
			["customWidthValue"] = 200,
			["justify"] = "LEFT",
			["cdFormat"] = "DEFAULT",
		},
	},

	-- db
	["dbCleaned"] = false
}
