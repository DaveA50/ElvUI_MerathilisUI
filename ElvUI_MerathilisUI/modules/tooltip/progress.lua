local MER, E, L, V, P, G = unpack(select(2, ...))
local PR = MER:NewModule("Progress")
local TT  = E:GetModule('Tooltip')
PR.modName = L["Progress"]

-- Cache global variables
-- Lua functions
local _G = _G
local ipairs, pairs, select, tonumber = ipairs, pairs, select, tonumber
local sub = string.sub
-- WoW Amodule / Variables
local AchievementFrame_DisplayComparison = AchievementFrame_DisplayComparison
local C_CreatureInfo_GetFactionInfo = C_CreatureInfo.GetFactionInfo
local CanInspect = CanInspect
local ClearAchievementComparisonUnit = ClearAchievementComparisonUnit
local GetComparisonStatistic = GetComparisonStatistic
local GetStatistic = GetStatistic
local GetTime = GetTime
local InCombatLockdown = InCombatLockdown
local IsAddOnLoaded = IsAddOnLoaded
local SetAchievementComparisonUnit = SetAchievementComparisonUnit
local UnitExists = UnitExists
local UnitGUID = UnitGUID
local UnitFactionGroup = UnitFactionGroup
local UnitRace = UnitRace
local UnitLevel = UnitLevel
local hooksecurefunc = hooksecurefunc
-- GLOBALS:

PR.RP = {
	-- sort key
	["tiers"] = { "Uldir", "BattleOfDazaralor", "CrucibleOfStorms" },
	["levels"] = { "Mythic", "Heroic", "Normal", "LFR" },
	-- stat id
	["Raid"] = {
		["Uldir"] = {
			["Mythic"] = {
				12789, 12793, 12797, 12801, 12805, 12811, 12816, 12820,
			},
			["Heroic"] = {
				12788, 12792, 12796, 12800, 12804, 12810, 12815, 12819,
			},
			["Normal"] = {
				12787, 12791, 12795, 12799, 12803, 12809, 12814, 12818,
			},
			["LFR"] = {
				12786, 12790, 12794, 12798, 12802, 12808, 12813, 12817,
			},
		},
		["BattleOfDazaralor"] = {
			["Alliance"] = {
				["Mythic"] = {
					13331, 13353, 13348, 13362, 13366, 13370, 13374, 13378, 13382,
				},
				["Heroic"] = {
					13330, 13351, 13347, 13361, 13365, 13369, 13373, 13377, 13381,
				},
				["Normal"] = {
					13329, 13350, 13346, 13359, 13364, 13368, 13372, 13376, 13380,
				},
				["LFR"] = {
					13328, 13349, 13344, 13358, 13363, 13367, 13371, 13375, 13379,
				},
			},
			["Horde"] = {
				["Mythic"] = {
					13331, 13336, 13357, 13374, 13378, 13382, 13362, 13366, 13370,
				},
				["Heroic"] = {
					13330, 13334, 13356, 13373, 13377, 13381, 13361, 13365, 13369,
				},
				["Normal"] = {
					13329, 13333, 13355, 13372, 13376, 13380, 13359, 13364, 13368,
				},
				["LFR"] = {
					13328, 13332, 13354, 13371, 13375, 13379, 13358, 13363, 13367,
				},
			},
		},
		["CrucibleOfStorms"] = {
			["Mythic"] = {
				13407, 13413,
			},
			["Heroic"] = {
				13406, 13412,
			},
			["Normal"] = {
				13405, 13411,
			},
			["LFR"] = {
				13404, 13408,
			},
		},
	},
}

local playerGUID = UnitGUID("player")
local playerFaction = UnitFactionGroup("player")
local progressCache = {}

local function GetLevelColorString(level, short)
	local color = "ff8000"

	if level == "Mythic" then
		color = "a335ee"
	elseif level == "Heroic" then
		color = "0070dd"
	elseif level == "Normal" then
		color = "1eff00"
	end

	if short then
		return "|cff"..color..sub(level, 1, 1).."|r"
	else
		return "|cff"..color..L[level].."|r"
	end
end

function PR:UpdateProgression(guid, faction)
	local db = E.db.mui.tooltip.progressInfo
	local statFunc = guid == playerGUID and GetStatistic or GetComparisonStatistic

	progressCache[guid] = progressCache[guid] or {}
	progressCache[guid].info =  progressCache[guid].info or {}
	progressCache[guid].timer = GetTime()

	if db.raid.enable then -- raid progress
		progressCache[guid].info.Raid = {}
		for _, tier in ipairs(self.RP.tiers) do -- arranged by tier
			if db.raid[tier] then
				progressCache[guid].info.Raid[tier] = {}
				local bosses = tier == "BattleOfDazaralor" and self.RP.Raid[tier][faction] or self.RP.Raid[tier]
				for _, level in ipairs(self.RP.levels) do -- sorted by level
					local highest = 0
					for _, statId in ipairs(bosses[level]) do
						local kills = tonumber(statFunc(statId),10)
						if kills and kills > 0 then
							highest = highest + 1
						end
					end
					if (highest > 0) then
						progressCache[guid].info.Raid[tier][level] = ("%d/%d"):format(highest, #bosses[level])
						if highest == #bosses[level] then
							break
						end
					end
				end
			end
		end
	end
end

function PR:SetProgressionInfo(guid, tt)
	local db = E.db.mui.tooltip.progressInfo
	if progressCache[guid] then
		local updated = false
		for i = 1, tt:NumLines() do
			local leftTip = _G["GameTooltipTextLeft"..i]
			local leftTipText = leftTip:GetText()
			local found = false
			if (leftTipText) then
				if db.raid.enable then -- raid progress
					for _, tier in ipairs(self.RP.tiers) do
						if db.raid[tier] then
							for _, level in ipairs(self.RP.levels) do
								if (leftTipText:find(L[tier]) and leftTipText:find(L[level])) then
									-- update found tooltip text line
									local rightTip = _G["GameTooltipTextRight"..i]
									leftTip:SetText(("%s %s:"):format(L[tier], GetLevelColorString(level, false)))
									rightTip:SetText(progressCache[guid].info.Raid[tier][level])
									updated = true
									found = true
									break
								end
							end
							if found then break end
						end
					end
				end
			end
		end
		if updated then return end
		-- add progression tooltip line
		if db.raid.enable then -- raid progress
			tt:AddLine(" ")
			tt:AddLine(L["Raid"])
			for _, tier in ipairs(self.RP.tiers) do -- Raid
				if db.raid[tier] then
					for _, level in ipairs(self.RP.levels) do
						if (progressCache[guid].info["Raid"][tier][level]) then
							tt:AddDoubleLine(("%s %s:"):format(L[tier], GetLevelColorString(level, false)), GetLevelColorString(level, true).." "..progressCache[guid].info.Raid[tier][level], nil, nil, nil, 1, 1, 1)
						end
					end
				end
			end
		end
	end
end

function TT:INSPECT_ACHIEVEMENT_READY(event, GUID)
	if (self.compareGUID ~= GUID) then return end

	local unit = "mouseover"
	if UnitExists(unit) then
		local race = select(3, UnitRace(unit))
		local faction = race and C_CreatureInfo_GetFactionInfo(race).groupTag
		if (faction) then
			PR:UpdateProgression(GUID, faction)
			_G.GameTooltip:SetUnit(unit)
		end
	end
	ClearAchievementComparisonUnit()
	self:UnregisterEvent("INSPECT_ACHIEVEMENT_READY")
end

function PR.AddInspectInfo(self, tt, unit, numTries, r, g, b)
	if InCombatLockdown() then return end
	if not E.db.mui.tooltip.progressInfo.enable then return end
	if not (unit and CanInspect(unit)) then return end
	local level = UnitLevel(unit)
	if not level or level < _G.MAX_PLAYER_LEVEL then return end
	local guid = UnitGUID(unit)

	if not progressCache[guid] or (GetTime() - progressCache[guid].timer) > 600 then
		if guid == playerGUID then
			PR:UpdateProgression(guid, playerFaction)
		else
			ClearAchievementComparisonUnit()
			if not self.loadedComparison and select(2, IsAddOnLoaded("Blizzard_AchievementUI")) then
				AchievementFrame_DisplayComparison(unit)
				HideUIPanel(_G.AchievementFrame)
				ClearAchievementComparisonUnit()
				self.loadedComparison = true
			end

			self.compareGUID = guid
			if SetAchievementComparisonUnit(unit) then
				self:RegisterEvent("INSPECT_ACHIEVEMENT_READY")
			end
			return
		end
	end
	PR:SetProgressionInfo(guid, tt)
end

function PR:Initialize()
	if E.private.tooltip.enable ~= true or E.db.mui.tooltip.progressInfo.enable ~= true then return end

	hooksecurefunc(TT, 'AddInspectInfo', PR.AddInspectInfo)
end

local function InitializeCallback()
	PR:Initialize()
end

MER:RegisterModule(PR:GetName(), InitializeCallback)
