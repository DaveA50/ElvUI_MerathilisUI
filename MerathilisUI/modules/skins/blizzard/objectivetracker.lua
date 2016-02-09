local E, L, V, P, G = unpack(ElvUI);
local MER = E:GetModule('MerathilisUI');
local LSM = LibStub('LibSharedMedia-3.0');
local S = E:GetModule('Skins');

-- Cache global variables
-- GLOBALS: C_Scenario, BonusObjectiveTrackerProgressBar_PlayFlareAnim, hooksecurefunc, CreateFrame, IsAddOnLoaded, TRIVIAL_QUEST_DISPLAY, NORMAL_QUEST_DISPLAY, QUEST_TRACKER_MODULE
-- GLOBALS: OBJECTIVE_TRACKER_COLOR, QuestLogQuests_GetTitleButton, UIDropDownMenu_CreateInfo, UIDropDownMenu_AddButton, UIDROPDOWN_MENU_LEVEL, UIDROPDOWN_MENU_LEVEL
-- GLOBALS: BONUS_OBJECTIVE_TRACKER_MODULE, DEFAULT_OBJECTIVE_TRACKER_MODULE, SCENARIO_CONTENT_TRACKER_MODULE
local _G = _G
local select, table, unpack = select, table, unpack

local GetGossipActiveQuests = GetGossipActiveQuests
local GetGossipAvailableQuests = GetGossipAvailableQuests
local GetNumQuestLogEntries = GetNumQuestLogEntries
local GetNumQuestWatches = GetNumQuestWatches
local GetQuestLogTitle = GetQuestLogTitle
local GetQuestWatchInfo = GetQuestWatchInfo
local GossipResize = GossipResize
local ObjectiveTrackerBlocksFrame = ObjectiveTrackerBlocksFrame
local ScenarioStageBlock = ScenarioStageBlock
local ScenarioProvingGroundsBlock = ScenarioProvingGroundsBlock
local ScenarioProvingGroundsBlockAnim = ScenarioProvingGroundsBlockAnim

local classColor = RAID_CLASS_COLORS[E.myclass]
local width = 190
local dummy = function() return end
local flat = [[Interface\AddOns\MerathilisUI\media\textures\Flat]]

-- Objective Tracker Bar
local function skinObjectiveBar(self, block, line)
	local progressBar = line.ProgressBar
	local bar = progressBar.Bar
	local icon = bar.Icon
	local flare = progressBar.FullBarFlare1

	if not progressBar.styled then
		local label = bar.Label

		bar.BarBG:Hide()
		bar.BarFrame:Hide()
		bar.BarFrame2:Hide()
		bar.BarFrame3:Hide()
		bar.BarGlow:Kill()
		bar:SetSize(225, 18)

		bar:SetStatusBarTexture(E['media'].MuiFlat)
		bar:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
		bar:CreateBackdrop('Transparent')
		bar:SetFrameStrata('HIGH')

		flare:Hide()

		label:ClearAllPoints()
		label:SetPoint('CENTER')
		label:FontTemplate()

		BonusObjectiveTrackerProgressBar_PlayFlareAnim = dummy
		progressBar.styled = true
	end

	if icon then icon:Hide() end
	bar.IconBG:Hide()
end

-- Timer bars. Seems to work atm. must still take a look at it.
local function SkinTimerBar(self, block, line, duration, startTime)
	local tb = self.usedTimerBars[block] and self.usedTimerBars[block][line]

	if tb and tb:IsShown() and not tb.skinned then
		tb.Bar.BorderMid:Hide()
		tb.Bar:StripTextures()
		tb.Bar:CreateBackdrop('Transparent')
		tb.Bar:SetStatusBarTexture(E['media'].MuiFlat)
		tb.Bar:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
		tb.skinned = true
	end
end

-- Scenario buttons
local function SkinScenarioButtons()
	local block = ScenarioStageBlock
	local _, currentStage, numStages, flags = C_Scenario.GetInfo()
	local inChallengeMode = C_Scenario.IsChallengeMode()

	-- we have to independently resize the artwork
	-- because we're messing with the tracker width >_>
	-- pop-up artwork
	block.NormalBG:SetSize(width + 21, 75)

	-- pop-up final artwork
	block.FinalBG:ClearAllPoints()
	block.FinalBG:SetPoint("TOPLEFT", block.NormalBG, 6, -6)
	block.FinalBG:SetPoint("BOTTOMRIGHT", block.NormalBG, -6, 6)

	-- pop-up glow
	block.GlowTexture:SetSize(width+20, 75)
end

-- Proving grounds
local function SkinProvingGroundButtons()
	local block = ScenarioProvingGroundsBlock
	local sb = block.StatusBar
	local anim = ScenarioProvingGroundsBlockAnim

	block.MedalIcon:SetSize(42, 42)
	block.MedalIcon:ClearAllPoints()
	block.MedalIcon:SetPoint("TOPLEFT", block, 20, -10)

	block.WaveLabel:ClearAllPoints()
	block.WaveLabel:SetPoint("LEFT", block.MedalIcon, "RIGHT", 3, 0)

	block.BG:SetSize(width + 21, 75)

	block.GoldCurlies:ClearAllPoints()
	block.GoldCurlies:SetPoint("TOPLEFT", block.BG, 6, -6)
	block.GoldCurlies:SetPoint("BOTTOMRIGHT", block.BG, -6, 6)

	anim.BGAnim:SetSize(width + 45, 85)
	anim.BorderAnim:SetSize(width + 21, 75)
	anim.BorderAnim:ClearAllPoints()
	anim.BorderAnim:SetPoint("TOPLEFT", block.BG, 8, -8)
	anim.BorderAnim:SetPoint("BOTTOMRIGHT", block.BG, -8, 8)

	-- Timer
	sb:StripTextures()
	sb:CreateBackdrop('Transparent')
	sb:SetStatusBarTexture(E['media'].MuiFlat)
	sb:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
	sb:ClearAllPoints()
	sb:SetPoint('TOPLEFT', block.MedalIcon, 'BOTTOMLEFT', -4, -5)
	sb:SetSize(200, 15)

	-- Create a little border around the Bar.
	local sb2 = sb:GetParent():CreateTexture(nil, 'BACKGROUND')
	sb2:SetPoint('TOPLEFT', sb, -1, 1)
	sb2:SetPoint('BOTTOMRIGHT', sb, 1, -1)
	sb2:SetTexture(E['media'].MuiFlat)
	sb2:SetAlpha(0.5)
	sb2:SetVertexColor(unpack(E.media.backdropcolor))
end

-- Quest Level
local function GossipFrameUpdate_hook()
	local buttonIndex = 1

	local availableQuests = {GetGossipAvailableQuests()}
	local numAvailableQuests = table.getn(availableQuests)
	for i = 1, numAvailableQuests, 6 do
		local titleButton = _G["GossipTitleButton" .. buttonIndex]
		local title = "[" .. availableQuests[i + 1] .. "] " .. availableQuests[i]
		local isTrivial = availableQuests[i + 2]
		if isTrivial then titleButton:SetFormattedText(TRIVIAL_QUEST_DISPLAY, title) else titleButton:SetFormattedText(NORMAL_QUEST_DISPLAY, title) end
		GossipResize(titleButton)
		buttonIndex = buttonIndex + 1
	end
	if numAvailableQuests > 1 then buttonIndex = buttonIndex + 1 end

	local activeQuests = {GetGossipActiveQuests()}
	local numActiveQuests = table.getn(activeQuests)
	for i = 1, numActiveQuests, 5 do
		local titleButton = _G["GossipTitleButton" .. buttonIndex]
		local title = "[" .. activeQuests[i + 1] .. "] " .. activeQuests[i]
		local isTrivial = activeQuests[i + 2]
		if isTrivial then titleButton:SetFormattedText(TRIVIAL_QUEST_DISPLAY, title) else titleButton:SetFormattedText(NORMAL_QUEST_DISPLAY, title) end
		GossipResize(titleButton)
		buttonIndex = buttonIndex + 1
	end
end

local function SetBlockHeader_hook()
	for i = 1, GetNumQuestWatches() do
		local questID, title, questLogIndex, numObjectives, requiredMoney, isComplete, startEvent, isAutoComplete, failureTime, timeElapsed, questType, isTask, isStory, isOnMap, hasLocalPOI = GetQuestWatchInfo(i)
		if not questID then break end
		local oldBlock = QUEST_TRACKER_MODULE:GetExistingBlock(questID)
		if oldBlock then
			local newTitle = "[" .. select(2, GetQuestLogTitle(questLogIndex)) .. "] " .. title
			QUEST_TRACKER_MODULE:SetStringText(oldBlock.HeaderText, newTitle, nil, OBJECTIVE_TRACKER_COLOR["Header"])
		end
	end
end

local function QuestLogQuests_hook(self, poiTable)
	local numEntries, numQuests = GetNumQuestLogEntries()
	local headerIndex = 0
	for questLogIndex = 1, numEntries do
		local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory = GetQuestLogTitle(questLogIndex)
		if isOnMap and not isTask and not isHeader then
			headerIndex = headerIndex + 1
			local button = QuestLogQuests_GetTitleButton(headerIndex)
			local newTitle = "[" .. level .. "] " .. button.Text:GetText()
			button.Text:SetText(newTitle)
		end
	end
end

-- Add quest/achievement wowhead link
local linkQuest, linkAchievement
if GetLocale() == "ruRU" then
	linkQuest = "http://ru.wowhead.com/quest=%d"
	linkAchievement = "http://ru.wowhead.com/achievement=%d"
elseif GetLocale() == "frFR" then
	linkQuest = "http://fr.wowhead.com/quest=%d"
	linkAchievement = "http://fr.wowhead.com/achievement=%d"
elseif GetLocale() == "deDE" then
	linkQuest = "http://de.wowhead.com/quest=%d"
	linkAchievement = "http://de.wowhead.com/achievement=%d"
elseif GetLocale() == "esES" or GetLocale() == "esMX" then
	linkQuest = "http://es.wowhead.com/quest=%d"
	linkAchievement = "http://es.wowhead.com/achievement=%d"
elseif GetLocale() == "ptBR" or GetLocale() == "ptPT" then
	linkQuest = "http://pt.wowhead.com/quest=%d"
	linkAchievement = "http://pt.wowhead.com/achievement=%d"
else
	linkQuest = "http://www.wowhead.com/quest=%d"
	linkAchievement = "http://www.wowhead.com/achievement=%d"
end

local function ObjectiveTrackerLink(self)
	local _, b, i, info, questID
	b = self.activeFrame
	i = b.questLogIndex
	_, _, _, _, _, _, _, questID = GetQuestLogTitle(i)
	info = UIDropDownMenu_CreateInfo()
	info.text = L['WATCH_WOWHEAD_LINK']
	info.func = function(id)
		local inputBox = E:StaticPopup_Show("WATCHFRAME_URL")
		inputBox.editBox:SetText(linkQuest:format(questID))
		inputBox.editBox:HighlightText()
	end
	info.arg1 = questID
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
end

local function AchievementTrackerLink(self)
	local _, b, i, info
	b = self.activeFrame
	i = b.id
	info = UIDropDownMenu_CreateInfo()
	info.text = L['WATCH_WOWHEAD_LINK']
	info.func = function(_, i)
		local inputBox = E:StaticPopup_Show("WATCHFRAME_URL")
		inputBox.editBox:SetText(linkAchievement:format(i))
		inputBox.editBox:HighlightText()
	end
	info.arg1 = i
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
end

-- Initialize
local function ObjectiveTrackerReskin()
	if IsAddOnLoaded("Blizzard_ObjectiveTracker") then
		if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.objectiveTracker ~= true or E.db.muiSkins.blizzard.objectivetracker ~= true then return end
		
		-- Objective Tracker Bar
		-- Quest
		ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetFont(LSM:Fetch('font', 'Merathilis Prototype'), 12, 'OUTLINE')
		ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetVertexColor(classColor.r, classColor.g, classColor.b)
		
		local QuestUnderline = CreateFrame("Frame", "QuestUnderline", ObjectiveTrackerBlocksFrame.QuestHeader)
		if QuestUnderline then
			QuestUnderline:SetPoint('BOTTOM', ObjectiveTrackerBlocksFrame.QuestHeader, -1, 1)
			QuestUnderline:SetSize(ObjectiveTrackerBlocksFrame.QuestHeader:GetWidth(), 1)
			QuestUnderline.Texture = QuestUnderline:CreateTexture(nil, 'OVERLAY')
			QuestUnderline.Texture:SetTexture(flat)
			QuestUnderline.Texture:SetVertexColor(classColor.r, classColor.g, classColor.b)
			QuestUnderline:CreateShadow()
			QuestUnderline.Texture:SetAllPoints(QuestUnderline)
		end
		
		-- Achievements
		ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetFont(LSM:Fetch('font', 'Merathilis Prototype'), 12, 'OUTLINE')
		ObjectiveTrackerBlocksFrame.AchievementHeader.Text:SetVertexColor(classColor.r, classColor.g, classColor.b)
		
		local AchievementUnderline = CreateFrame("Frame", "AchievementUnderline", ObjectiveTrackerBlocksFrame.AchievementHeader)
		if AchievementUnderline then
			AchievementUnderline:SetPoint('BOTTOM', ObjectiveTrackerBlocksFrame.AchievementHeader, -1, 1)
			AchievementUnderline:SetSize(ObjectiveTrackerBlocksFrame.AchievementHeader:GetWidth(), 1)
			AchievementUnderline.Texture = AchievementUnderline:CreateTexture(nil, 'OVERLAY')
			AchievementUnderline.Texture:SetTexture(flat)
			AchievementUnderline.Texture:SetVertexColor(classColor.r, classColor.g, classColor.b)
			AchievementUnderline:CreateShadow()
			AchievementUnderline.Texture:SetAllPoints(AchievementUnderline)
		end
		
		-- Bonus Objectives
		BONUS_OBJECTIVE_TRACKER_MODULE.Header.Text:SetFont(LSM:Fetch('font', 'Merathilis Prototype'), 12, 'OUTLINE')
		BONUS_OBJECTIVE_TRACKER_MODULE.Header.Text:SetVertexColor(classColor.r, classColor.g, classColor.b)
		
		local BonusUnderline =  CreateFrame("Frame", "BonusUnderline", BONUS_OBJECTIVE_TRACKER_MODULE.Header)
		if BonusUnderline then
			BonusUnderline:SetPoint('BOTTOM', BONUS_OBJECTIVE_TRACKER_MODULE.Header, -1, 1)
			BonusUnderline:SetSize(BONUS_OBJECTIVE_TRACKER_MODULE.Header:GetWidth(), 1)
			BonusUnderline.Texture = BonusUnderline:CreateTexture(nil, 'OVERLAY')
			BonusUnderline.Texture:SetTexture(flat)
			BonusUnderline.Texture:SetVertexColor(classColor.r, classColor.g, classColor.b)
			BonusUnderline:CreateShadow()
			BonusUnderline.Texture:SetAllPoints(BonusUnderline)
		end
		
		-- Scenario
		hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddTimerBar", SkinTimerBar)
		hooksecurefunc(SCENARIO_CONTENT_TRACKER_MODULE, "Update", SkinScenarioButtons)
		hooksecurefunc("ScenarioBlocksFrame_OnLoad", SkinScenarioButtons)
		ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetFont(LSM:Fetch('font', 'Merathilis Prototype'), 12, 'OUTLINE')
		ObjectiveTrackerBlocksFrame.ScenarioHeader.Text:SetVertexColor(classColor.r, classColor.g, classColor.b)
		
		local ScenarioUnderline = CreateFrame("Frame", "ScenarioUnderline", ObjectiveTrackerBlocksFrame.ScenarioHeader)
		if ScenarioUnderline then
			ScenarioUnderline:SetPoint('BOTTOM',ObjectiveTrackerBlocksFrame.ScenarioHeader, -1, 1)
			ScenarioUnderline:SetSize(ObjectiveTrackerBlocksFrame.ScenarioHeader:GetWidth(), 1)
			ScenarioUnderline.Texture = ScenarioUnderline:CreateTexture(nil, 'OVERLAY')
			ScenarioUnderline.Texture:SetTexture(flat)
			ScenarioUnderline.Texture:SetVertexColor(classColor.r, classColor.g, classColor.b)
			ScenarioUnderline:CreateShadow()
			ScenarioUnderline.Texture:SetAllPoints(ScenarioUnderline)
		end
		
		-- Proving grounds
		hooksecurefunc("Scenario_ProvingGrounds_ShowBlock", SkinProvingGroundButtons)
		-- Timer Bar
		hooksecurefunc(BONUS_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", skinObjectiveBar)
		-- QuestLevel
		hooksecurefunc("GossipFrameUpdate", GossipFrameUpdate_hook)
		hooksecurefunc(QUEST_TRACKER_MODULE, "Update", SetBlockHeader_hook)
		hooksecurefunc("QuestLogQuests_Update", QuestLogQuests_hook)
		-- WoWHead Links
		hooksecurefunc("QuestObjectiveTracker_OnOpenDropDown", ObjectiveTrackerLink)
		hooksecurefunc("AchievementObjectiveTracker_OnOpenDropDown", AchievementTrackerLink) 
	end
end
hooksecurefunc(S, "Initialize", ObjectiveTrackerReskin)