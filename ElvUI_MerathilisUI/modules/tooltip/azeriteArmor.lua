local MER, E, L, V, P, G = unpack(select(2, ...))
local MERTT = MER:GetModule("mUITooltip")

-- Cache global variables
-- Lua functions
local _G = _G
local ipairs, select = ipairs, select
local strfind, format = string.find, string.format
local tinsert, twipe = table.insert, table.wipe

-- WoW API / Variables
local GetSpellInfo = GetSpellInfo
local C_AzeriteEmpoweredItem_GetPowerInfo = C_AzeriteEmpoweredItem.GetPowerInfo
local C_AzeriteEmpoweredItem_IsAzeriteEmpoweredItemByID = C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID
local C_AzeriteEmpoweredItem_GetAllTierInfoByItemID = C_AzeriteEmpoweredItem.GetAllTierInfoByItemID
-- Global variables that we don"t cache, list them here for the mikk"s Find Globals script
-- GLOBALS:

-- Credit: AzeriteTooltip, by jokair9
function MERTT:AzeriteArmor()
	if not E.db.mui.tooltip.azerite then return end

	local tipList = {}
	local function scanTooltip(tooltip)
		for i = 9, tooltip:NumLines() do
			local line = _G[tooltip:GetName().."TextLeft"..i]
			local text = line:GetText()
			if text and strfind(text, "%-") then
				tinsert(tipList, i)
			end
		end
		return #tipList
	end

	local iconString = "|T%s:18:22:0:0:64:64:5:59:5:59"
	local function getIconString(icon, known)
		if known then
			return format(iconString..":255:255:255|t", icon)
		else
			return format(iconString..":130:130:130|t", icon)
		end
	end

	local powerData = {}
	local function convertPowerID(id)
		local spellID = powerData[id]
		if not spellID then
			local powerInfo = C_AzeriteEmpoweredItem_GetPowerInfo(id)
			if powerInfo and powerInfo.spellID then
				spellID = powerInfo.spellID
				powerData[id] = spellID
			end
		end
		return spellID
	end

	local function lookingForAzerite(tooltip, powerName)
		for i = 8, tooltip:NumLines() do
			local line = _G[tooltip:GetName().."TextLeft"..i]
			local text = line:GetText()
			if text and strfind(text, "%- "..powerName) then
				return true
			end
		end
	end

	local cache = {}
	local function updateAzeriteArmor(self)
		local link = select(2, self:GetItem())
		if not link then return end
		if not C_AzeriteEmpoweredItem_IsAzeriteEmpoweredItemByID(link) then return end
		local allTierInfo = cache[link]
		if not allTierInfo then
			allTierInfo = C_AzeriteEmpoweredItem_GetAllTierInfoByItemID(link)
			cache[link] = allTierInfo
		end
		if not allTierInfo then return end

		local count = scanTooltip(self)
		local index = 1
		for i = 1, #allTierInfo do
			local powerIDs = allTierInfo[i].azeritePowerIDs
			if powerIDs[1] == 13 then break end

			local tooltipText = ""
			for _, id in ipairs(powerIDs) do
				local spellID = convertPowerID(id)
				if not spellID then break end
				local name, _, icon = GetSpellInfo(spellID)
				local found = lookingForAzerite(self, name)
				if found then
					tooltipText = tooltipText.." "..getIconString(icon, true)
				else
					tooltipText = tooltipText.." "..getIconString(icon)
				end
			end

			if tooltipText ~= "" and count > 0 then
				local line = _G[self:GetName().."TextLeft"..tipList[index]]
				line:SetText(line:GetText().."\n "..tooltipText)
				count = count - 1
				index = index + 1
			end
		end

		twipe(tipList)
	end

	_G.GameTooltip:HookScript("OnTooltipSetItem", updateAzeriteArmor)
	_G.ItemRefTooltip:HookScript("OnTooltipSetItem", updateAzeriteArmor)
	_G.ShoppingTooltip1:HookScript("OnTooltipSetItem", updateAzeriteArmor)
end
