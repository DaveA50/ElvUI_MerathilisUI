local E, L, V, P, G = unpack(ElvUI)
local MER = E:GetModule('MerathilisUI')

-- Code taken from Battle.net Friend Alert by Clinton Caldwell
if IsAddOnLoaded("BattleNetFriendAlert") then return; end

if E.db.muiMisc == nil then E.db.muiMisc = {} end -- prevent a nil Error.
if E.db.muiMisc.FriendAlert == false then return; end

local interval = 3
local friends = {}
local icons = {
	["Friend"] = "|TInterface\\FriendsFrame\\UI-Toast-FriendOnlineIcon:16:16:0:0:32:32:2:30:2:30|t",
	["App"] = "|TInterface\\CHATFRAME\\UI-ChatIcon-Battlenet:14|t",
	["WoW"] = "|TInterface\\CHATFRAME\\UI-ChatIcon-WoW:14|t",
	["D3"] = "|TInterface\\CHATFRAME\\UI-ChatIcon-D3:14|t",
	["WTCG"] = "|TInterface\\CHATFRAME\\UI-ChatIcon-WTCG:14|t",
	["Hero"] = "|TInterface\\CHATFRAME\\UI-ChatIcon-HotS:14|t",
	["S2"] = "|TInterface\\CHATFRAME\\UI-ChatIcon-SC2:14|t",
};

local function BNPlayerLink(presenceName, presenceID)
	return string.format("|HBNplayer:%s:%s|h[%s]|h", presenceName, presenceID, presenceName)
end

local function ScanFriends()
	if BNConnected() then
		for index = 1, BNGetNumFriends() do
			local presenceID, presenceName, _, _, characterName, _, game = BNGetFriendInfo(index)
			if game and friends[presenceID] and friends[presenceID]["game"] then
				if game ~= friends[presenceID]["game"] then
					if game == "App" then
						print(BATTLENET_FONT_COLOR_CODE .. icons["Friend"] .. string.format(L["%s stopped playing (%sIn Battle.net)."], BNPlayerLink(presenceName, presenceID), icons[game]) .. FONT_COLOR_CODE_CLOSE)
					else
						print(BATTLENET_FONT_COLOR_CODE .. icons["Friend"] .. string.format(L["%s is now playing (%s%s)."], BNPlayerLink(presenceName, presenceID), icons[game], characterName) .. FONT_COLOR_CODE_CLOSE)
						PlaySound("UI_BnetToast")
					end
				end
			end
			-- Record latest friend info
			friends[presenceID] = {["game"] = game}
		end
	end
	-- Scan again in interval seconds
	C_Timer.After(interval, ScanFriends)
end

local f = CreateFrame("Frame", "BNFAEventsFrame", E.UIParent)
f:SetScript("OnEvent", function() C_Timer.After(interval, ScanFriends); end)
f:RegisterEvent("PLAYER_LOGIN")
