local MER, E, _, V, P, G = unpack(select(2, ...))
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale or 'enUS')
local MERC = MER:GetModule("muiChat")

--Cache global variables
--Lua functions
local tinsert = table.insert
--WoW API / Variable
-- GLOBALS:

local function ChatTable()
	E.Options.args.mui.args.modules.args.chat = {
		type = "group",
		name = MERC.modName,
		order = 11,
		get = function(info) return E.db.mui.chat[ info[#info] ] end,
		set = function(info, value) E.db.mui.chat[ info[#info] ] = value; E:StaticPopup_Show("PRIVATE_RL"); end,
		args = {
			header1 = {
				type = "header",
				name = MER:cOption(MERC.modName),
				order = 1
			},
			chatButton = {
				order = 2,
				type = "toggle",
				name = L["Chat Menu"],
				desc = L["Create a chat button to increase the chat size and chat menu button."],
			},
			iLevelLink = {
				order = 3,
				type = "toggle",
				name = L["Chat Item Level"],
				desc = L["Shows the slot and item level in the chat"],
			},
			hidePlayerBrackets = {
				order = 4,
				type = "toggle",
				name = L["Hide Player Brackets"],
				desc = L["Removes brackets around the person who posts a chat message."],
			},
			hideChat = {
				order = 5,
				type = "toggle",
				name = L["Hide Community Chat"],
				desc = L["Adds an overlay to the Community Chat. Useful for streamers."],
			},
			chatBar = {
				order = 6,
				type = "toggle",
				name = L["ChatBar"],
				desc = L["Shows a ChatBar with different quick buttons."],
			},
			emotes = {
				order = 7,
				type = "toggle",
				name = L["Emotes"],
			},
		},
	}
end

tinsert(MER.Config, ChatTable)
