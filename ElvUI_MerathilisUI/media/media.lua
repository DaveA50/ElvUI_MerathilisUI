local MER, E, L, V, P, G = unpack(select(2, ...))
local M = MER:NewModule("MERMedia", "AceHook-3.0")
local LSM = E.LSM or E.Libs.LSM

-- Cache global variables
-- Lua functions
local _G = _G
local unpack = unpack
local random = random
-- WoW API / Variables
local FadingFrame_Show = FadingFrame_Show
local IsAddOnLoaded = IsAddOnLoaded
--GLOBALS: hooksecurefunc

M.Zones = L["MER_MEDIA_ZONES"]
M.PvPInfo = L["MER_MEDIA_PVP"]
M.Subzones = L["MER_MEDIA_SUBZONES"]
M.PVPArena = L["MER_MEDIA_PVPARENA"]

local Colors = {
	[1] = {0.41, 0.8, 0.94}, -- sanctuary
	[2] = {1.0, 0.1, 0.1}, -- hostile
	[3] = {0.1, 1.0, 0.1}, --friendly
	[4] = {1.0, 0.7, 0}, --contested
	[5] = {1.0, 0.9294, 0.7607}, --white
}

local function ZoneTextPos()
	if (_G["PVPInfoTextString"]:GetText() == "") then
		_G["SubZoneTextString"]:SetPoint("TOP", "ZoneTextString", "BOTTOM", 0, 0)
	else
		_G["SubZoneTextString"]:SetPoint("TOP", "PVPInfoTextString", "BOTTOM", 0, 0)
	end
end

local function MakeFont(obj, font, size, style, r, g, b, sr, sg, sb, sox, soy)
	obj:SetFont(font, size, style)
	if sr and sg and sb then obj:SetShadowColor(sr, sg, sb) end
	if sox and soy then obj:SetShadowOffset(sox, soy) end
	if r and g and b then obj:SetTextColor(r, g, b)
	elseif r then obj:SetAlpha(r) end
end

function M:SetBlizzFonts()
	if E.private.general.replaceBlizzFonts then
		local zoneDB = E.db.mui.media.zoneText
		local miscDB = E.db.mui.media.miscText

		if zoneDB.enable then
			_G["ZoneTextString"]:SetFont(E.LSM:Fetch('font', zoneDB.zone.font), zoneDB.zone.size, zoneDB.zone.outline) -- Main zone name
			_G["PVPInfoTextString"]:SetFont(E.LSM:Fetch('font', zoneDB.pvp.font), zoneDB.pvp.size, zoneDB.pvp.outline) -- PvP status for main zone
			_G["PVPArenaTextString"]:SetFont(E.LSM:Fetch('font', zoneDB.pvp.font), zoneDB.pvp.size, zoneDB.pvp.outline) -- PvP status for subzone
			_G["SubZoneTextString"]:SetFont(E.LSM:Fetch('font', zoneDB.subzone.font), zoneDB.subzone.size, zoneDB.subzone.outline) -- Subzone name
		end

		if miscDB.mail.enable then
			_G["SendMailBodyEditBox"]:SetFont(E.LSM:Fetch('font', miscDB.mail.font), miscDB.mail.size, miscDB.mail.outline) --Writing letter text
			_G["OpenMailBodyText"]:SetFont(E.LSM:Fetch('font', miscDB.mail.font), miscDB.mail.size, miscDB.mail.outline) --Received letter text
		end

		if miscDB.gossip.enable then
			_G["QuestFont"]:SetFont(E.LSM:Fetch('font', miscDB.gossip.font), miscDB.gossip.size, miscDB.gossip.outline) -- Font in Quest Log/Petitions and shit. It's fucking hedious with any outline so fuck it.
		end

		if miscDB.questFontSuperHuge.enable then
			_G["QuestFont_Super_Huge"]:SetFont(E.LSM:Fetch('font', miscDB.questFontSuperHuge.font), miscDB.questFontSuperHuge.size, miscDB.questFontSuperHuge.outline) -- No idea what that is for
			_G["QuestFont_Enormous"]:SetFont(E.LSM:Fetch('font', miscDB.questFontSuperHuge.font), miscDB.questFontSuperHuge.size, miscDB.questFontSuperHuge.outline) -- No idea what that is for
		end

		if miscDB.editbox.enable then
			_G["NumberFont_Shadow_Med"]:SetFont(E.LSM:Fetch('font', miscDB.editbox.font), miscDB.editbox.size, miscDB.editbox.outline) --Chat editbox
		end

		--Objective Frame
		if miscDB.objectiveHeader.enable then
			if not _G["ObjectiveTrackerFrame"].hooked then
				hooksecurefunc("ObjectiveTracker_Update", function(reason, id)
					_G["ObjectiveTrackerBlocksFrame"].QuestHeader.Text:SetFont(E.LSM:Fetch('font', miscDB.objectiveHeader.font), miscDB.objectiveHeader.size, miscDB.objectiveHeader.outline)
					_G["ObjectiveTrackerBlocksFrame"].AchievementHeader.Text:SetFont(E.LSM:Fetch('font', miscDB.objectiveHeader.font), miscDB.objectiveHeader.size, miscDB.objectiveHeader.outline)
					_G["ObjectiveTrackerBlocksFrame"].ScenarioHeader.Text:SetFont(E.LSM:Fetch('font', miscDB.objectiveHeader.font), miscDB.objectiveHeader.size, miscDB.objectiveHeader.outline)
					_G["WORLD_QUEST_TRACKER_MODULE"].Header.Text:SetFont(E.LSM:Fetch('font', miscDB.objectiveHeader.font), miscDB.objectiveHeader.size, miscDB.objectiveHeader.outline)
					_G["BONUS_OBJECTIVE_TRACKER_MODULE"].Header.Text:SetFont(E.LSM:Fetch('font', miscDB.objectiveHeader.font), miscDB.objectiveHeader.size, miscDB.objectiveHeader.outline)
				end)
				_G["ObjectiveTrackerFrame"].hooked = true
			end
			_G["ObjectiveTrackerFrame"].HeaderMenu.Title:SetFont(E.LSM:Fetch('font', miscDB.objectiveHeader.font), miscDB.objectiveHeader.size, miscDB.objectiveHeader.outline)
			_G["ObjectiveTrackerBlocksFrame"].QuestHeader.Text:SetFont(E.LSM:Fetch('font', miscDB.objectiveHeader.font), miscDB.objectiveHeader.size, miscDB.objectiveHeader.outline)
			_G["ObjectiveTrackerBlocksFrame"].AchievementHeader.Text:SetFont(E.LSM:Fetch('font', miscDB.objectiveHeader.font), miscDB.objectiveHeader.size, miscDB.objectiveHeader.outline)
			_G["ObjectiveTrackerBlocksFrame"].ScenarioHeader.Text:SetFont(E.LSM:Fetch('font', miscDB.objectiveHeader.font), miscDB.objectiveHeader.size, miscDB.objectiveHeader.outline)
			_G["BONUS_OBJECTIVE_TRACKER_MODULE"].Header.Text:SetFont(E.LSM:Fetch('font', miscDB.objectiveHeader.font), miscDB.objectiveHeader.size, miscDB.objectiveHeader.outline)
			_G["WORLD_QUEST_TRACKER_MODULE"].Header.Text:SetFont(E.LSM:Fetch('font', miscDB.objectiveHeader.font), miscDB.objectiveHeader.size, miscDB.objectiveHeader.outline)
		end

		if miscDB.objective.enable then
			MakeFont(_G["ObjectiveFont"], E.LSM:Fetch('font', miscDB.objective.font), miscDB.objective.size, miscDB.objective.outline)
			if M.BonusObjectiveBarText then M.BonusObjectiveBarText:SetFont(E.LSM:Fetch('font', miscDB.objective.font), miscDB.objective.size, miscDB.objective.outline) end
		end
	end
end

function M:TextWidth()
	local db = E.db.mui.media.zoneText

	_G["ZoneTextString"]:SetWidth(db.zone.width)
	_G["PVPInfoTextString"]:SetWidth(db.pvp.width)
	_G["PVPArenaTextString"]:SetWidth(db.pvp.width)
	_G["SubZoneTextString"]:SetWidth(db.subzone.width)
end

function M:TextShow()
	local z, i, a, s, c = random(1, #M.Zones), random(1, #M.PvPInfo), random(1, #M.PVPArena), random(1, #M.Subzones), random(1, #Colors)
	local red, green, blue = unpack(Colors[c])

	--Setting texts--
	_G["ZoneTextString"]:SetText(M.Zones[z])
	_G["PVPInfoTextString"]:SetText(M.PvPInfo[i])
	_G["PVPArenaTextString"]:SetText(M.PVPArena[a])
	_G["SubZoneTextString"]:SetText(M.Subzones[s])

	ZoneTextPos()--nil, true)

	-- Applying colors
	_G["ZoneTextString"]:SetTextColor(red, green, blue)
	_G["PVPInfoTextString"]:SetTextColor(red, green, blue)
	_G["PVPArenaTextString"]:SetTextColor(red, green, blue)
	_G["SubZoneTextString"]:SetTextColor(red, green, blue)

	FadingFrame_Show(_G["ZoneTextFrame"])
	FadingFrame_Show(_G["SubZoneTextFrame"])
end

function M:Initialize()
	if IsAddOnLoaded("ElvUI_SLE") then return; end

	-- Make sure the media table gets created
	if not E.db.media then
		E.db.media = {}
	end

	-- Clear old db setting
	if E.db.mui.media.fonts then
		E.db.mui.media.fonts = nil
	end

	if E.db.mui.media.zoneText.enable then
		M:TextWidth()
		hooksecurefunc("SetZoneText", ZoneTextPos)
	end

	hooksecurefunc(E, "UpdateBlizzardFonts", M.SetBlizzFonts)
	M.SetBlizzFonts()
end

local function InitializeCallback()
	M:Initialize()
end

MER:RegisterModule(M:GetName(), InitializeCallback)
