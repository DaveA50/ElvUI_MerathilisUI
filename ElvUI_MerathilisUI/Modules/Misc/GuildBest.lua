local MER, E, L, V, P, G = unpack(select(2, ...))
local MI = MER:GetModule('MER_Misc')
local MERS = MER:GetModule('MER_Skins')

--Cache global variables
--Lua functions
local _G = _G
local select, pairs, tonumber = select, pairs, tonumber
local wipe = table.wipe
local format, strsplit, strmatch = string.format, string.split, string.match
--WoW API / Variables
local CHALLENGE_MODE_POWER_LEVEL = CHALLENGE_MODE_POWER_LEVEL
local CHALLENGE_MODE_GUILD_BEST_LINE = CHALLENGE_MODE_GUILD_BEST_LINE
local CHALLENGE_MODE_GUILD_BEST_LINE_YOU = CHALLENGE_MODE_GUILD_BEST_LINE_YOU
local Ambiguate, GetContainerNumSlots, GetContainerItemInfo = Ambiguate, GetContainerNumSlots, GetContainerItemInfo
local C_ChallengeMode_GetMapUIInfo, C_ChallengeMode_GetGuildLeaders = C_ChallengeMode.GetMapUIInfo, C_ChallengeMode.GetGuildLeaders
local CreateFrame = CreateFrame
local IsAddOnLoaded = IsAddOnLoaded
local hooksecurefunc = hooksecurefunc
local GameTooltip = GameTooltip
--Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS: MERData

local hasAngryKeystones = IsAddOnLoaded("AngryKeystones")
local frame, resize

local function ShowTooltip(self)
	local leaderInfo = self.leaderInfo
	if not leaderInfo then return end

	GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
	local name = C_ChallengeMode_GetMapUIInfo(leaderInfo.mapChallengeModeID)
	GameTooltip:SetText(name, 1, 1, 1)
	GameTooltip:AddLine(format(CHALLENGE_MODE_POWER_LEVEL, leaderInfo.keystoneLevel))

	for i = 1, #leaderInfo.members do
		local classColorStr = MER.ClassColors[leaderInfo.members[i].classFileName].colorStr
		GameTooltip:AddLine(format(CHALLENGE_MODE_GUILD_BEST_LINE, classColorStr,leaderInfo.members[i].name));
	end
	GameTooltip:Show()
end

local function HideTooltip(self)
	GameTooltip:Hide()
end

local function CreateBoard()
	frame = CreateFrame('Frame', nil, _G.ChallengesFrame, "BackdropTemplate")
	frame:Point('BOTTOMRIGHT', -8, 75)
	frame:SetSize(170, 105)
	MERS:CreateBD(frame, .3)

	frame.Header = frame:CreateFontString(nil, "OVERLAY", 'GameFontNormalMed2')
	frame.Header:Point('TOPLEFT', frame, 17, -10)
	frame.Header:SetJustifyH('LEFT')
	frame.Header:SetText(_G.GUILD)

	frame.entries = {}
	for i = 1, 4 do
		local entry = CreateFrame('Frame', nil, frame)
		entry:Point('LEFT', 10, 0)
		entry:Point('RIGHT', -10, 0)
		entry:Height(18)
		entry.CharacterName = MER:CreateText(entry, 'OVERLAY', 11, 'OUTLINE', '', nil, 'LEFT', 6, 0)
		entry.CharacterName:Point('RIGHT', -30, 0)
		entry.CharacterName:SetJustifyH('LEFT')
		entry.Level = MER:CreateText(entry, 'OVERLAY', 11, 'OUTLINE', '', nil, nil, true)
		entry.Level:SetJustifyH('LEFT')
		entry.Level:ClearAllPoints()
		entry.Level:Point('LEFT', entry, 'RIGHT', -22, 0)
		entry:SetScript('OnEnter', ShowTooltip)
		entry:SetScript('OnLeave', HideTooltip)

		if i == 1 then
			entry:Point('TOP', frame, 0, -26)
		else
			entry:Point('TOP', frame.entries[i-1], 'BOTTOM')
		end

		frame.entries[i] = entry
	end

	if not hasAngryKeystones then
		_G.ChallengesFrame.WeeklyInfo.Child.Description:Point("CENTER", 0, 20)
	end
end

local function SetUpRecord(self, leaderInfo)
	self.leaderInfo = leaderInfo

	local str = CHALLENGE_MODE_GUILD_BEST_LINE
	if leaderInfo.isYou then
		str = CHALLENGE_MODE_GUILD_BEST_LINE_YOU
	end

	local classColorStr = MER.ClassColors[leaderInfo.classFileName].colorStr
	self.CharacterName:SetText(format(str, classColorStr, leaderInfo.name))
	self.Level:SetText(leaderInfo.keystoneLevel)
end

local function UpdateGuildBest(self)
	if not frame then CreateBoard() end

	if self.leadersAvailable then
		local leaders = C_ChallengeMode_GetGuildLeaders()
		if leaders and #leaders > 0 then
			for i = 1, #leaders do
				SetUpRecord(frame.entries[i], leaders[i])
			end
			frame:Show()
		else
			frame:Hide()
		end
	end

	if not resize and hasAngryKeystones then
		local schedule = select(5, self:GetChildren())
		frame:SetWidth(246)
		frame:ClearAllPoints()
		frame:SetPoint('BOTTOMLEFT', schedule, 'TOPLEFT', 0, 10)

		self.WeeklyInfo.Child.ThisWeekLabel:SetPoint("TOP", -135, -25)
		local affix = self.WeeklyInfo.Child.Affixes[1]
		if affix then
			affix:ClearAllPoints()
			affix:SetPoint('TOPLEFT', 20, -55)
		end

		resize = true
	end
end

local function ChallengesOnLoad(event, addon)
	if addon == 'Blizzard_ChallengesUI' then
		hooksecurefunc('ChallengesFrame_Update', UpdateGuildBest)

		MI:UnregisterEvent(event)
	end
end

function MI:GuildBest()
	if IsAddOnLoaded('RaiderIO') then return end

	MI:RegisterEvent('ADDON_LOADED', ChallengesOnLoad)
end
