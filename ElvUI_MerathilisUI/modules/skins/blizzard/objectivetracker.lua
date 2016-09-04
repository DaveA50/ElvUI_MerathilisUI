local E, L, V, P, G = unpack(ElvUI);
local MER = E:GetModule('MerathilisUI');
local LSM = LibStub('LibSharedMedia-3.0');
local S = E:GetModule('Skins');

-- Cache global variables
-- Lua functions
local _G = _G
local pairs = pairs
-- WoW API / Variables
local CreateFrame = CreateFrame
local IsAddOnLoaded = IsAddOnLoaded
local ObjectiveTrackerFrame = _G["ObjectiveTrackerFrame"]
local ScenarioStageBlock = _G["ScenarioStageBlock"]
local GetNumQuestWatches = GetNumQuestWatches
local GetQuestDifficultyColor = GetQuestDifficultyColor
local GetQuestLogTitle = GetQuestLogTitle
local GetQuestIndexForWatch = GetQuestIndexForWatch
local GetQuestWatchInfo = GetQuestWatchInfo
local GetScreenHeight = GetScreenHeight
local GetScreenWidth = GetScreenWidth
local LE_QUEST_FREQUENCY_DAILY = LE_QUEST_FREQUENCY_DAILY
local LE_QUEST_FREQUENCY_WEEKLY = LE_QUEST_FREQUENCY_WEEKLY
local UIParentLoadAddOn = UIParentLoadAddOn

-- Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS: hooksecurefunc, QUEST_TRACKER_MODULE, ScenarioTrackerProgressBar_PlayFlareAnim, C_Scenario, Bar
-- GLOBALS: BonusObjectiveTrackerProgressBar_PlayFlareAnim, ObjectiveTracker_Initialize, ScenarioProvingGroundsBlock
-- GLOBALS: ScenarioProvingGroundsBlockAnim, GameTooltip

local classColor = E.myclass == 'PRIEST' and E.PriestColors or (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[E.myclass] or RAID_CLASS_COLORS[E.myclass])
local dummy = function() return end

local otf = ObjectiveTrackerFrame
local height = 450 -- overall height
local width = 188 -- overall width

local function ObjectiveTrackerReskin()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.objectiveTracker ~= true or E.private.muiSkins.blizzard.objectivetracker ~= true then return end

	if not ObjectiveTrackerFrame then
		UIParentLoadAddOn('Blizzard_ObjectiveTracker')
	end

	if not ObjectiveTrackerFrame.initialized then
		ObjectiveTracker_Initialize(ObjectiveTrackerFrame)
	end

	-- Underlines and header text
	hooksecurefunc("ObjectiveTracker_Update", function(reason, id)
		if otf.MODULES then
			for i = 1, #otf.MODULES do
				local module = otf.MODULES[i]
				module.Header.Underline = MER:Underline(otf.MODULES[i].Header, true, 1)
				module.Header.Text:SetFont(LSM:Fetch("font", "Merathilis Roboto-Black"), 12, "OUTLINE")
				module.Header.Text:SetVertexColor(classColor.r, classColor.g, classColor.b)
			end
		end
	end)

	local AddObjective = function(self, block, key)
		local header = block.HeaderText
		local line = block.lines[key]

		if  header then
			local wrap = header:GetNumLines()
			header:SetFont(LSM:Fetch('font', 'Merathilis Roboto-Black'), 11, n)
			header:SetShadowOffset(.7, -.7)
			header:SetShadowColor(0, 0, 0, 1)
			header:SetWidth(width)
			header:SetWordWrap(true)
			if wrap > 1 then
				local height = block:GetHeight()
				block:SetHeight(height*2)
			end
			header.styled = true
		end

		line.Text:SetWidth(width)

		if line.Dash and line.Dash:IsShown() then
			line.Dash:SetText('• ')
		end
	end

	-- ProgressBars
	local AddProgressBar = function(self, block, line)
		local frame = line.ProgressBar
		local bar = frame.Bar

		bar:StripTextures()
		bar:SetStatusBarTexture(E["media"].MuiFlat)
		bar:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
		bar:CreateBackdrop("Transparent")
		bar.backdrop:Point("TOPLEFT", Bar, -1, 1)
		bar.backdrop:Point("BOTTOMRIGHT", Bar, 1, -1)
		bar.skinned = true

		ScenarioTrackerProgressBar_PlayFlareAnim = dummy
		BonusObjectiveTrackerProgressBar_PlayFlareAnim = dummy

		if not bar.styled then
			local bg = CreateFrame("Frame", nil, bar)
			bg:SetPoint("TOPLEFT", bar)
			bg:SetPoint("BOTTOMRIGHT", bar)
			bg:SetFrameLevel(0)
			bar.styled = true
		end

		for _, v in pairs({bar.BarFrame, bar.Icon, bar.IconBG}) do
			if v then v:Kill() end -- causes a taint
		end
	end

	local AddTimerBar = function(self, block, line, duration, startTime)
		local bar = self.usedTimerBars[block] and self.usedTimerBars[block][line]

		bar:SetStatusBarColor(classColor.r, classColor.g, classColor.b)

		if not bar.styled then
			local bg = CreateFrame('Frame', nil, bar)
			bg:SetPoint('TOPLEFT', bar)
			bg:SetPoint('BOTTOMRIGHT', bar)
			bg:SetFrameLevel(0)
			bar.styled = true
		end

		bar.Label:SetFont(LSM:Fetch('font', 'Merathilis Roboto-Black'), 11, 'THINOUTLINE')
		bar.Label:SetShadowOffset(0, -0)
		bar.Label:ClearAllPoints()
		bar.Label:SetPoint('CENTER', bar, 'BOTTOM', 1, -2)
		bar.Label:SetDrawLayer('OVERLAY', 7)
	end

	--Set tooltip depending on position
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

	-- Scenario buttons
	local function SkinScenarioButtons()
		local block = ScenarioStageBlock
		local _, currentStage, numStages, flags = C_Scenario.GetInfo()

		-- pop-up artwork
		block.NormalBG:Hide()

		-- pop-up final artwork
		block.FinalBG:Hide()

		-- pop-up glow
		block.GlowTexture:SetSize(width+20, 75)
		block.GlowTexture.AlphaAnim.Play = dummy
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

		block.BG:Hide()
		block.BG:SetSize(width + 21, 75)

		block.GoldCurlies:Hide()
		block.GoldCurlies:ClearAllPoints()
		block.GoldCurlies:SetPoint("TOPLEFT", block.BG, 6, -6)
		block.GoldCurlies:SetPoint("BOTTOMRIGHT", block.BG, -6, 6)
	
		anim.BGAnim:Hide()
		anim.BGAnim:SetSize(width + 45, 85)
		anim.BorderAnim:SetSize(width + 21, 75)
		anim.BorderAnim:Hide()
		anim.BorderAnim:ClearAllPoints()
		anim.BorderAnim:SetPoint("TOPLEFT", block.BG, 8, -8)
		anim.BorderAnim:SetPoint("BOTTOMRIGHT", block.BG, -8, 8)

		-- Timer
		sb:StripTextures()
		sb:CreateBackdrop('Transparent')
		sb.backdrop:Point('TOPLEFT', sb, -1, 1)
		sb.backdrop:Point('BOTTOMRIGHT', sb, 1, -1)
		sb:SetStatusBarTexture(E["media"].MuiFlat)
		sb:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
		sb:ClearAllPoints()
		sb:SetPoint('TOPLEFT', block.MedalIcon, 'BOTTOMLEFT', -4, -5)
		sb:SetSize(200, 15)
	end

	local min = otf.HeaderMenu.MinimizeButton
	min:SetSize(15, 15)
	min:SetNormalTexture''
	min:SetPushedTexture''

	min.minus = min:CreateFontString(nil, 'OVERLAY')
	min.minus:SetFont(LSM:Fetch('font', 'Merathilis Roboto-Black'), 14, nil)
	min.minus:SetText('>')
	min.minus:SetPoint('CENTER')
	min.minus:SetTextColor(1, 1, 1)
	min.minus:SetShadowOffset(1, -1)
	min.minus:SetShadowColor(0, 0, 0)

	min.plus = min:CreateFontString(nil, 'OVERLAY')
	min.plus:SetFont(LSM:Fetch('font', 'Merathilis Roboto-Black'), 14, 'THINOUTLINE')
	min.plus:SetText('<')
	min.plus:SetPoint('CENTER')
	min.plus:SetTextColor(1, 1, 1)
	min.plus:SetShadowOffset(1, -1)
	min.plus:SetShadowColor(0, 0, 0)
	min.plus:Hide()

	local title = otf.HeaderMenu.Title
	title:SetFont(LSM:Fetch('font', 'Merathilis Roboto-Black'), 13, nil)
	title:ClearAllPoints()
	title:SetPoint('RIGHT', min, 'LEFT', -8, 0)

	min:HookScript('OnEnter', function() min.minus:SetTextColor(.7, .5, 0) min.plus:SetTextColor(.7, .5, 0) end)
	min:HookScript('OnLeave', function() min.minus:SetTextColor(1, 1, 1) min.plus:SetTextColor(1, 1, 1) end)

	hooksecurefunc('ObjectiveTracker_Collapse', function() min.plus:Show() min.minus:Hide() end)
	hooksecurefunc('ObjectiveTracker_Expand', function()   min.plus:Hide() min.minus:Show() end)

	-- Kill reward animation when finished dungeon or bonus objectives
	ObjectiveTrackerScenarioRewardsFrame.Show = dummy

	hooksecurefunc("BonusObjectiveTracker_AnimateReward", function(block)
		ObjectiveTrackerBonusRewardsFrame:ClearAllPoints()
		ObjectiveTrackerBonusRewardsFrame:SetPoint("BOTTOM", UIParent, "TOP", 0, 90)
	end)

	-- Hooks
	for i = 1, #otf.MODULES do
		local module = otf.MODULES[i]
		hooksecurefunc(module, 'AddObjective', AddObjective)
		hooksecurefunc(module, "AddProgressBar", AddProgressBar)
		hooksecurefunc(module, 'AddTimerBar', AddTimerBar)
	end

	if IsAddOnLoaded('Blizzard_ObjectiveTracker') then
		hooksecurefunc(_G["SCENARIO_CONTENT_TRACKER_MODULE"], "Update", SkinScenarioButtons)
		hooksecurefunc("ScenarioBlocksFrame_OnLoad", SkinScenarioButtons)
		hooksecurefunc("Scenario_ProvingGrounds_ShowBlock", SkinProvingGroundButtons)
	end
end
hooksecurefunc(S, "Initialize", ObjectiveTrackerReskin)
