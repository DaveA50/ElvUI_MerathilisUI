local MER, E, L, V, P, G = unpack(select(2, ...))
local MERC = MER:GetModule("muiChat")

-- Credits: siweia/NDui

-- Cache global variables
-- Lua functions
local _G = _G
local next, pairs, select, tonumber, unpack = next, pairs, select, tonumber, unpack
local split, gsub, gmatch, format, strfind, strmatch, sub = string.split, string.gsub, string.gmatch, string.format, string.find, string.match, string.sub
local tinsert = table.insert
-- WoW API / Variable
local ChatFrame_AddMessageEventFilter = ChatFrame_AddMessageEventFilter
local ChatFrame_MessageEventHandler = ChatFrame_MessageEventHandler
local CreateFrame = CreateFrame
local ConvertRGBtoColorString = ConvertRGBtoColorString
local GetAchievementInfo = GetAchievementInfo
local GetCurrencyLink = GetCurrencyLink
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local GetItemStats = GetItemStats
local GetQuestDifficultyColor = GetQuestDifficultyColor
local GetSpellInfo = GetSpellInfo
-- GLOBALS:

-- Show itemlevel on chat hyperlinks
local function GetHyperlink(Hyperlink, texture)
	if (not texture) then
		return Hyperlink
	else
		return '|T'..texture..':12:12:0:0:64:64:5:59:5:59|t'..Hyperlink
	end
end

local function SetChatLinkIcon(Hyperlink)
	local schema, id = strmatch(Hyperlink, '|H(%w+):(%d+):')
	local texture
	if (schema == 'item') then
		texture = select(10, GetItemInfo(tonumber(id)))
	elseif (schema == 'spell') then
		texture = select(3, GetSpellInfo(tonumber(id)))
	elseif (schema == 'achievement') then
		texture = select(10, GetAchievementInfo(tonumber(id)))
	end

	return GetHyperlink(Hyperlink, texture)
end

local function isItemHasLevel(link)
	local name, _, rarity, level, _, class, subclass, _, equipSlot, _, _, classID = GetItemInfo(link)
	if name and level and rarity > 1 and (classID == _G.LE_ITEM_CLASS_WEAPON or classID == _G.LE_ITEM_CLASS_ARMOR) then
		local itemLevel = MER:GetItemLevel(link)

		if (equipSlot and strfind(equipSlot, 'INVTYPE_')) then
			itemLevel = format('%s %s', itemLevel, _G[equipSlot] or equipSlot)
		elseif (class == ARMOR) then
			itemLevel = format('%s %s', itemLevel, class)
		elseif (subclass and strfind(subclass, RELICSLOT)) then
			itemLevel = format('%s %s', itemLevel, RELICSLOT)
		end

		return name, itemLevel
	end
end

local function isItemHasGem(link)
	local stats = GetItemStats(link)
	for index in pairs(stats) do
		if strfind(index, 'EMPTY_SOCKET_') then
			return '|TInterface\\ItemSocketingFrame\\UI-EmptySocket-Prismatic:0|t'
		end
	end
	return ''
end

local itemCache = {}
local function convertItemLevel(link)
	if itemCache[link] then return itemCache[link] end

	local itemLink = strmatch(link, '|Hitem:.-|h')
	if itemLink then
		local name, itemLevel = isItemHasLevel(itemLink)
		if name and itemLevel then
			link = gsub(link, '|h%[(.-)%]|h', '|h'..name..' ('..itemLevel..isItemHasGem(itemLink)..')|h')
			itemCache[link] = link
		end
	end
	return link
end

function MERC:UpdateChatItemLevel(_, msg, ...)
	msg = gsub(msg, '(|Hitem:%d+:.-|h.-|h)', convertItemLevel)
	msg = gsub(msg, '(|H%w+:%d+:.-|h.-|h)', SetChatLinkIcon)
	return false, msg, ...
end

-- Show item's real color for BN chat
local queuedMessages = {}

local function GetLinkColor(data)
	local type, arg1, arg2, arg3 = split(':', data)
	if(type == 'item') then
		local _, _, quality = GetItemInfo(arg1)
		if(quality) then
			local _, _, _, color = GetItemQualityColor(quality)
			return '|c' .. color
		else
			return nil, true
		end
	elseif(type == 'quest') then
		if(arg2) then
			return ConvertRGBtoColorString(GetQuestDifficultyColor(arg2))
		else
			return '|cffffd100'
		end
	elseif(type == 'currency') then
		local link = GetCurrencyLink(arg1)
		if(link) then
			return sub(link, 0, 10)
		else
			return '|cffffffff'
		end
	elseif(type == 'battlepet') then
		if(arg3 ~= -1) then
			local _, _, _, color = GetItemQualityColor(arg3)
			return '|c' .. color
		else
			return '|cffffd200'
		end
	elseif(type == 'garrfollower') then
		local _, _, _, color = GetItemQualityColor(arg2)
		return '|c' .. color
	elseif(type == 'spell') then
		return '|cff71d5ff'
	elseif(type == 'achievement' or type == 'garrmission') then
		return '|cffffff00'
	elseif(type == 'trade' or type == 'enchant') then
		return '|cffffd000'
	elseif(type == 'instancelock') then
		return '|cffff8000'
	elseif(type == 'glyph' or type == 'journal') then
		return '|cff66bbff'
	elseif(type == 'talent' or type == 'battlePetAbil' or type == 'garrfollowerability') then
		return '|cff4e96f7'
	elseif(type == 'levelup') then
		return '|cffff4e00'
	end
end

local function UpdateLinkColor(self, event, message, ...)
	for link, data in gmatch(message, '(|H(.-)|h.-|h)') do
		local color, queue = GetLinkColor(data)
		if(queue) then
			tinsert(queuedMessages, {self, event, message, ...})
			return true
		elseif(color) then
			local matchLink = '|H' .. data .. '|h.-|h'
			message = gsub(message, matchLink, color .. link .. '|r', 1)
		end
	end

	return false, message, ...
end

local f = CreateFrame('Frame')
f:RegisterEvent('GET_ITEM_INFO_RECEIVED')
f:SetScript('OnEvent', function()
	if(#queuedMessages > 0) then
		for index, data in next, queuedMessages do
			ChatFrame_MessageEventHandler(unpack(data))
			queuedMessages[index] = nil
		end
	end
end)

function MERC:ItemLinks()
	if E.db.mui.chat.filter.enable and E.db.mui.chat.filter.itemLevel then
		ChatFrame_AddMessageEventFilter('CHAT_MSG_LOOT', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_CHANNEL', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_SAY', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_YELL', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_WHISPER', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_WHISPER_INFORM', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_BN_WHISPER', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_RAID', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_RAID_LEADER', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_PARTY', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_PARTY_LEADER', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_GUILD', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_BATTLEGROUND', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_INSTANCE_CHAT', self.UpdateChatItemLevel)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_INSTANCE_CHAT_LEADER', self.UpdateChatItemLevel)

		ChatFrame_AddMessageEventFilter('CHAT_MSG_BN_WHISPER', UpdateLinkColor)
		ChatFrame_AddMessageEventFilter('CHAT_MSG_BN_WHISPER_INFORM', UpdateLinkColor)
	end
end
