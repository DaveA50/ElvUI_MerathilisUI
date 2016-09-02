local E, L, V, P, G = unpack(ElvUI);
local MER = E:GetModule('MerathilisUI');
local LSM = LibStub('LibSharedMedia-3.0');
local S = E:GetModule('Skins');

-- Cache global variables
-- Lua functions
local _G = _G
local select, pairs, unpack = select, pairs, unpack
-- WoW API / Variables
local CreateFrame = CreateFrame
local GetScreenHeight = GetScreenHeight
local GetScreenWidth = GetScreenWidth
local IsAddOnLoaded = IsAddOnLoaded
local C_Scenario = C_Scenario
local BONUS_OBJECTIVE_TRACKER_MODULE = _G["BONUS_OBJECTIVE_TRACKER_MODULE"]
local LevelUpDisplayScenarioFrame = _G["LevelUpDisplayScenarioFrame"]
local ObjectiveTrackerFrame = _G["ObjectiveTrackerFrame"]
local ObjectiveTrackerBlocksFrame = _G["ObjectiveTrackerBlocksFrame"]
local ObjectiveTrackerBonusBannerFrame = _G["ObjectiveTrackerBonusBannerFrame"]
local GetNumQuestWatches = GetNumQuestWatches
local GetQuestDifficultyColor = GetQuestDifficultyColor
local GetQuestLogTitle = GetQuestLogTitle
local GetQuestWatchInfo = GetQuestWatchInfo

-- Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS: hooksecurefunc, QUEST_TRACKER_MODULE, OBJECTIVE_TRACKER_COLOR, ACHIEVEMENT_TRACKER_MODULE
-- GLOBALS: BonusObjectiveTrackerProgressBar_PlayFlareAnim, GameTooltip, ScenarioStageBlock
-- GLOBALS: ScenarioProvingGroundsBlock, ScenarioProvingGroundsBlockAnim,  DEFAULT_OBJECTIVE_TRACKER_MODULE
-- GLOBALS: SCENARIO_TRACKER_MODULE, ScenarioTrackerProgressBar_PlayFlareAnim, SCENARIO_CONTENT_TRACKER_MODULE

local classColor = E.myclass == 'PRIEST' and E.PriestColors or (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[E.myclass] or RAID_CLASS_COLORS[E.myclass])
local dummy = function() return end
local otf = ObjectiveTrackerFrame

local function ObjectiveTrackerReskin()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.objectiveTracker ~= true or E.private.muiSkins.blizzard.objectivetracker ~= true then return end

	LevelUpDisplayScenarioFrame.level:SetVertexColor(classColor.r, classColor.g, classColor.b)

	-- Underlines and header text
	hooksecurefunc("ObjectiveTracker_AddBlock", function(moduleHeader)
		if otf.MODULES then
			for i = 1, #otf.MODULES do
				if moduleHeader then
					local module = otf.MODULES[i]
					module.Header.Underline = MER:Underline(otf.MODULES[i].Header, true, 1)
					module.Header.Text:SetFont(LSM:Fetch("font", "Merathilis Roboto-Black"), 12, "OUTLINE")
					module.Header.Text:SetVertexColor(classColor.r, classColor.g, classColor.b)
				end
			end
		end
	end)

	-- Level Text for QuestTracker
	hooksecurefunc(QUEST_TRACKER_MODULE, "Update", function(self)
		for i = 1, GetNumQuestWatches() do
			local questID, title, questLogIndex, numObjectives, requiredMoney, isComplete, startEvent, isAutoComplete, failureTime, timeElapsed, questType, isTask, isStory, isOnMap, hasLocalPOI = GetQuestWatchInfo(i)
			if not questID then
				break
			end
			local block = QUEST_TRACKER_MODULE:GetBlock(questID)
			local oldBlock = QUEST_TRACKER_MODULE:GetExistingBlock(questID)
			if oldBlock then
				local newTitle = "[" .. select(2, GetQuestLogTitle(questLogIndex)) .. "] " .. title
				QUEST_TRACKER_MODULE:SetStringText(oldBlock.HeaderText, newTitle, nil, OBJECTIVE_TRACKER_COLOR["Header"])
			end
			local heightcheck = block.HeaderText:GetNumLines()
			if heightcheck == 2 then
				local height = block:GetHeight()
				block:SetHeight(height + 16)
			end
		end
	end)

	-- Level Color for QuestTracker
	hooksecurefunc(QUEST_TRACKER_MODULE, "Update", function()
		for i = 1, GetNumQuestWatches() do
			local questID, title, questLogIndex, numObjectives, requiredMoney, isComplete, startEvent, isAutoComplete, failureTime, timeElapsed, questType, isTask, isBounty, isStory, isOnMap, hasLocalPOI = GetQuestWatchInfo(i)
			if not questID then
				break
			end
			local _, level = GetQuestLogTitle(questLogIndex)
			local col = GetQuestDifficultyColor(level)
			local block = QUEST_TRACKER_MODULE:GetExistingBlock(questID)
			if block then
				block.HeaderText:SetTextColor(col.r, col.g, col.b)
				block.HeaderText.col = col
				block.HeaderText:SetFont(LSM:Fetch('font', 'Merathilis Roboto-Black'), 11, 'THINOUTLINE')
				block.HeaderText:SetShadowOffset(1, -1)
				block.HeaderText:SetShadowColor(0, 0, 0)
			end
		end
	end)

	hooksecurefunc("ObjectiveTrackerBlockHeader_OnLeave", function(self)
		local block = self:GetParent()
		if block.HeaderText.col then
			block.HeaderText:SetTextColor(block.HeaderText.col.r, block.HeaderText.col.g, block.HeaderText.col.b)
		end
	end)

	hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddObjective", function(self, block)
		if block.module == ACHIEVEMENT_TRACKER_MODULE then
			block.HeaderText:SetTextColor(0.75, 0.61, 0)
			block.HeaderText.col = nil
			block.HeaderText:SetFont(LSM:Fetch('font', 'Merathilis Roboto-Black'), 11, 'THINOUTLINE')
			block.HeaderText:SetShadowOffset(1, -1)
			block.HeaderText:SetShadowColor(0, 0, 0)
			block.HeaderText:SetWordWrap(true)
		end
	end)

	-- ProgressBar in the ObjectiveTacker
	hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", function(self, block, line, questID)
		local progressBar = self.usedProgressBars[block] and self.usedProgressBars[block][line];

		if progressBar and progressBar:IsShown() and not progressBar.skinned then
			progressBar.Bar:StripTextures()
			progressBar.Bar:SetStatusBarTexture(E["media"].MuiFlat)
			progressBar.Bar:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
			progressBar.Bar:CreateBackdrop()
			progressBar.Bar.backdrop:Point("TOPLEFT", Bar, -1, 1)
			progressBar.Bar.backdrop:Point("BOTTOMRIGHT", Bar, 1, -1)
			progressBar.skinned = true
		end
	end)

	-- Another ProgressBar in the ObjectiveTracker (e.g. Legion Pre-Event)
	hooksecurefunc(SCENARIO_TRACKER_MODULE, "AddProgressBar", function(self, block, line, criteriaIndex)
		local progressBar = self.usedProgressBars[block] and self.usedProgressBars[block][line];

		if progressBar and progressBar:IsShown() and not progressBar.skinned then
			progressBar.Bar:StripTextures()
			progressBar.Bar:SetStatusBarTexture(E["media"].MuiFlat)
			progressBar.Bar:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
			progressBar.Bar:CreateBackdrop()
			progressBar.Bar.backdrop:Point("TOPLEFT", Bar, -1, 1)
			progressBar.Bar.backdrop:Point("BOTTOMRIGHT", Bar, 1, -1)
			progressBar.skinned = true

			ScenarioTrackerProgressBar_PlayFlareAnim = dummy
		end
	end)

	-- Skin bonus objective progress bar
	hooksecurefunc(BONUS_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", function(self, block, line)
		local progressBar = line.ProgressBar
		local bar = progressBar.Bar
		local icon = bar.Icon
		local flare = progressBar.FullBarFlare1
		local BG = bar.BarBG

		if not progressBar.styled then
			bar.BarFrame:Hide()
			bar.BarFrame2:Hide()
			bar.BarFrame3:Hide()
			bar.BarGlow:Kill()
			bar.IconBG:Kill()
			BG:Hide()
			bar:CreateBackdrop("Transparent")
			bar.backdrop:Point("TOPLEFT", bar, -1, 1)
			bar.backdrop:Point("BOTTOMRIGHT", bar, 1, -1)
			bar:SetSize(225, 18)
			bar:SetStatusBarTexture(LSM:Fetch('statusbar', 'MerathilisFlat'))
			bar:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
			bar:SetBackdropColor(0, 0, 0, 0)

			flare:Kill()

			icon:Kill()

			bar.AnimIn.Play = dummy
			BonusObjectiveTrackerProgressBar_PlayFlareAnim = dummy
			progressBar.styled = true
		end
	end)

	hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddObjective", function(self, block, objectiveKey, _, lineType)
		local line = self:GetLine(block, objectiveKey, lineType)
		if not line.styled then
			line.Text:SetFont(LSM:Fetch('font', 'Merathilis Roboto-Black'), 10, 'THINOUTLINE')
			line.Text:SetShadowOffset(1, -1)
			line.Text:SetShadowColor(0, 0, 0)
			line.styled = true
		end
		if line.Dash and line.Dash:IsShown() then
			line.Dash:SetText("")
		end
	end)

	-- Set tooltip depending on position
	local function IsFramePositionedLeft(frame)
		local x = frame:GetCenter()
		local screenWidth = GetScreenWidth()
		local screenHeight = GetScreenHeight()
		local positionedLeft = false

		if x and x < (screenWidth / 2) then
			positionedLeft = true
		end
		return positionedLeft
	end

	hooksecurefunc("BonusObjectiveTracker_ShowRewardsTooltip", function(block)
		if IsFramePositionedLeft(ObjectiveTrackerFrame) then
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("TOPLEFT", block, "TOPRIGHT", 0, 0)
		end
	end)

	-- Dashes to dots
	hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddObjective", function(self, block, objectiveKey, _, lineType)
		local line = self:GetLine(block, objectiveKey, lineType)
		if line.Dash and line.Dash:IsShown() then line.Dash:SetText("• ") end
	end)

	-- Timer bars
	hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddTimerBar", function(self, block, line, duration, startTime)
		local tb = self.usedTimerBars[block] and self.usedTimerBars[block][line]
		if tb and tb:IsShown() and not tb.skinned then
			tb.Bar:StripTextures()
			tb.Bar:SetStatusBarTexture(E["media"].MuiFlat)
			tb.Bar:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
			tb.Bar:CreateBackdrop("Transparent")
			tb.Bar.backdrop:Point("TOPLEFT", tb.Bar, -1, 1)
			tb.Bar.backdrop:Point("BOTTOMRIGHT", tb.Bar, 1, -1)
			tb.skinned = true
		end
	end)

	-- Skin scenario buttons
	local function SkinScenarioButtons()
		local block = ScenarioStageBlock
		local stage = block.Stage

		block.NormalBG:ClearAllPoints()
		block.NormalBG:Point("CENTER", block, 25, 0)
		block.NormalBG:SetSize(otf:GetWidth(), 70)
		block.FinalBG:ClearAllPoints()
		block.FinalBG:SetPoint("TOPLEFT", block.NormalBG, 6, -6)
		block.FinalBG:SetPoint("BOTTOMRIGHT", block.NormalBG, -6, 6)
		block.FinalBG:SetAlpha(0)
		block.GlowTexture:SetSize(otf:GetWidth(), 70)

		stage:ClearAllPoints()
		stage:SetPoint("TOPLEFT", block.NormalBG, 8, -5)
	end
	hooksecurefunc(SCENARIO_CONTENT_TRACKER_MODULE, "Update", SkinScenarioButtons)
	hooksecurefunc("ScenarioBlocksFrame_OnLoad", SkinScenarioButtons)

	-- Skin proving grounds
	local function SkinProvingGroundButtons()
		local block = ScenarioProvingGroundsBlock
		local sb = block.StatusBar
		local anim = ScenarioProvingGroundsBlockAnim

		block.BG:ClearAllPoints()
		block.BG:Point("CENTER", block, 25, 4)

		block.MedalIcon:SetSize(32, 32)
		block.MedalIcon:ClearAllPoints()
		block.MedalIcon:SetPoint("LEFT", block.BG, 3, 0)

		block.WaveLabel:ClearAllPoints()
		block.WaveLabel:SetPoint("LEFT", block.MedalIcon, "RIGHT", 3, 0)

		block.BG:SetSize(otf:GetWidth(), 50)

		block.GoldCurlies:Kill()

		anim.Glow:Kill()
		anim.BGAnim:Kill()
		anim.BorderAnim:Kill()

		sb:StripTextures()
		sb:SetStatusBarTexture(E["media"].MuiFlat)
		sb:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
		sb:ClearAllPoints()
		sb:SetPoint("CENTER", block.BG, 0, -34)
		sb:CreateBackdrop("Transparent")
		sb.backdrop:Point("TOPLEFT", sb, -1, 1)
		sb.backdrop:Point("BOTTOMRIGHT", sb, 1, -1)
	end
	hooksecurefunc("Scenario_ProvingGrounds_ShowBlock", SkinProvingGroundButtons)
end
hooksecurefunc(S, "Initialize", ObjectiveTrackerReskin)
