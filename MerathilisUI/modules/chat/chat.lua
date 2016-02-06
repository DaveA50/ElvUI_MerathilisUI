local E, L, V, P, G, _ = unpack(ElvUI);
local MER = E:GetModule('MerathilisUI')
local MERC = E:NewModule('muiChat')
local CH = E:GetModule('Chat')

-- Cache global variables
local _G = _G
local gsub = string.gsub
local GetRealmName = GetRealmName
local ChatFrame_AddMessageEventFilter = ChatFrame_AddMessageEventFilter

function MERC:RemoveCurrentRealmName(self, msg, author, ...)
	local realmName = gsub(GetRealmName(), " ", "")
	
	if msg and msg:find("-" .. realmName) then
		return false, gsub(msg, "%-"..realmName, ""), author, ...
	end
end

_G.ERR_FRIEND_ONLINE_SS = "|Hplayer:%s|h[%s]|h "..L["has come |cff298F00online|r."]
_G.ERR_FRIEND_OFFLINE_S = "[%s] "..L["has gone |cffff0000offline|r."]

function MERC:LoadChat()
	-- Remove the Realm Name from system messages
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", MERC.RemoveCurrentRealmName)
end
hooksecurefunc(CH, "Initialize", MERC.LoadChat)

E:RegisterModule(MERC:GetName())
