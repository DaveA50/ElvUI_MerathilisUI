local MER, E, L, V, P, G = unpack(select(2, ...))
local MERS = E:GetModule("muiSkins")
local S = E:GetModule("Skins");
local LSM = LibStub("LibSharedMedia-3.0")

-- Cache global variables
-- Lua functions
local _G = _G
local ipairs, select, unpack = ipairs, select, unpack
-- WoW API / Variables
local CreateFrame = CreateFrame
local C_TimerAfter = C_Timer.After
--Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS: hooksecurefunc

local function styleOrderhall()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.orderhall ~= true or E.private.muiSkins.blizzard.orderhall ~= true then return end

	local b = _G["OrderHallCommandBar"]

	b:Styling(true, true)

	b.Background:SetAtlas(nil)

	b.CurrencyIcon:SetAtlas("legionmission-icon-currency", false)

	b.WorldMapButton:Show()
	b.WorldMapButton:ClearAllPoints()
	b.WorldMapButton:SetPoint("RIGHT", 0, 0)
	b.WorldMapButton:StripTextures()
	b.WorldMapButton:SetTemplate("Transparent")
	b.WorldMapButton:UnregisterAllEvents()
	S:HandleButton(b.WorldMapButton)

	local mapButton = b.WorldMapButton
	mapButton:Size(20, 20)
	mapButton:SetNormalTexture("")
	mapButton:SetPushedTexture("")

	mapButton.Text = mapButton:CreateFontString(nil, "OVERLAY")
	mapButton.Text:SetFont(LSM:Fetch("font", "Expressway"), 13, nil)
	mapButton.Text:SetText("M")
	mapButton.Text:SetPoint("CENTER", -1, 0)

	mapButton:HookScript("OnEnter", function() mapButton.Text:SetTextColor(MER.ClassColor.r, MER.ClassColor.g, MER.ClassColor.b) end)
	mapButton:HookScript("OnLeave", function() mapButton.Text:SetTextColor(1, 1, 1) end)

	local combatAlly = _G["OrderHallMissionFrameMissions"].CombatAllyUI
	combatAlly:StripTextures()
	MERS:CreateBD(combatAlly, .25)

	-- Mission Frame
	_G["OrderHallMissionFrame"]:Styling(true, true)

	_G["OrderHallMissionFrameMissions"].MaterialFrame:StripTextures()
	_G["OrderHallMissionFrameMissionsListScrollFrame"]:StripTextures()

	_G["OrderHallMissionFrame"].MissionTab.MissionPage:StripTextures()

	_G["OrderHallMissionFrame"].MissionTab.ZoneSupportMissionPage:StripTextures()
	MERS:CreateBD(_G["OrderHallMissionFrame"].MissionTab.ZoneSupportMissionPage, .5)

	for i, v in ipairs(_G["OrderHallMissionFrame"].MissionTab.MissionList.listScroll.buttons) do
		local Button = _G["OrderHallMissionFrameMissionsListScrollFrameButton" .. i]
		if Button and not Button.skinned then
			Button:StripTextures()
			MERS:CreateBD(Button, .25)
			MERS:Reskin(Button, true)
			Button.LocBG:SetAlpha(0)
			Button.backdropTexture:Hide()

			Button.isSkinned = true
		end
	end

	for i = 1, 2 do
		local tab = _G["OrderHallMissionFrameMissionsTab"..i]

		tab:StripTextures()
		tab:SetHeight(_G["GarrisonMissionFrameMissionsTab" .. i]:GetHeight() - 10)
		S:HandleTab(tab)
	end

	-- Missions
	local Mission = _G["OrderHallMissionFrameMissions"]
	Mission.CompleteDialog:StripTextures()
	Mission.CompleteDialog:SetTemplate("Transparent")

	local MissionPage = _G["OrderHallMissionFrame"].MissionTab.MissionPage
	for i = 1, 10 do
		select(i, MissionPage.RewardsFrame:GetRegions()):Hide()
	end
	MERS:CreateBD(MissionPage.RewardsFrame, .25)

	-- Credits Simpy <3
	-- Talent Frame
	local TalentFrame = _G["OrderHallTalentFrame"]
	TalentFrame:StripTextures()
	TalentFrame.LeftInset:StripTextures()
	TalentFrame:SetTemplate("Transparent")
	TalentFrame.CurrencyIcon:SetAtlas("legionmission-icon-currency", false)
	S:HandleCloseButton(TalentFrame.CloseButton)
	S:HandleButton(TalentFrame.BackButton)
	TalentFrame.BackButton:SetFrameLevel(TalentFrame.BackButton:GetFrameLevel()+2)
	TalentFrame.BackButton:Point('BOTTOMRIGHT', TalentFrame, 'BOTTOMRIGHT', -2, 2)

	local TalentInset = _G["ClassHallTalentInset"]
	local TalentClassBG = TalentFrame.Background
	TalentInset:CreateBackdrop("Transparent")
	TalentInset.backdrop:SetFrameLevel(TalentInset.backdrop:GetFrameLevel()+1)
	TalentInset.backdrop:Point('TOPLEFT', TalentClassBG, 'TOPLEFT', E.Border-1, -E.Border+1)
	TalentInset.backdrop:Point('BOTTOMRIGHT', TalentClassBG, 'BOTTOMRIGHT', -E.Border+1, E.Border-1)
	TalentClassBG:SetAtlas("orderhalltalents-background-"..E.myclass)
	TalentClassBG:SetDrawLayer("ARTWORK")
	TalentClassBG:SetAlpha(0.8)

	local function panelBackground(self)
		local tab8 = _G["OrderHallTalentFrame8PanelBackground"];
		if tab8 then
			if TalentFrame.BackButton:IsShown() then tab8:Hide() else tab8:Show() end
		else
			for i = 1, 8 do
				local bg = CreateFrame("Frame", "OrderHallTalentFrame"..i.."PanelBackground", self)
				if i == 1 then
					bg:Point("TOPLEFT", self, "TOPLEFT", E.PixelMode and 6 or 9, -80)
				else
					bg:Point("TOPLEFT", "OrderHallTalentFrame"..(i-1).."PanelBackground", "BOTTOMLEFT", 0, -6)
				end
				bg:SetTemplate("Transparent")
				bg:SetBackdropColor(0, 0, 0, 0.5)
				bg:SetSize(E.PixelMode and 322 or 316, 52)
			end
			tab8 = _G["OrderHallTalentFrame8PanelBackground"];
			if TalentFrame.BackButton:IsShown() then tab8:Hide() else tab8:Show() end
		end
	end

	local function colorBorder(child, backdrop, atlas)
		if child.AlphaIconOverlay:IsShown() then --isBeingResearched or (talentAvailability and not selected)
			local alpha = child.AlphaIconOverlay:GetAlpha()
			if alpha <= 0.5 then --talentAvailability
				backdrop:SetBackdropBorderColor(0.5, 0.5, 0.5) --[border = grey, shadow x2]
				child.darkOverlay:SetColorTexture(0, 0, 0, 0.50)
				child.darkOverlay:Show()
			elseif alpha <= 0.7 then --isBeingResearched
				backdrop:SetBackdropBorderColor(0,1,1) --[border = teal, shadow x1]
				child.darkOverlay:SetColorTexture(0, 0, 0, 0.25)
				child.darkOverlay:Show()
			end
		elseif atlas == "orderhalltalents-spellborder-green" then
			backdrop:SetBackdropBorderColor(0,1,0) --[border = green, no shadow]
			child.darkOverlay:Hide()
		elseif atlas == "orderhalltalents-spellborder-yellow" then
			backdrop:SetBackdropBorderColor(1,1,0) --[border = yellow, no shadow]
			child.darkOverlay:Hide()
		elseif atlas == "orderhalltalents-spellborder" then
			backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
			child.darkOverlay:SetColorTexture(0, 0, 0, 0.75) --[border will be default, shadow x3]
			child.darkOverlay:Show()
		end
	end

	TalentFrame:HookScript("OnShow", function(self)
		panelBackground(self) -- Chromie is the original classAgnostic talent tree
		if self.skinned then return end
		for i=1, self:GetNumChildren() do
			local child = select(i, self:GetChildren())
			if child and child.Icon and not child.backdrop then
				child:StyleButton()
				child:CreateBackdrop()
				child.Border:SetAlpha(0)
				child.Highlight:SetAlpha(0)
				child.AlphaIconOverlay:SetTexture(nil)
				child.Icon:SetTexCoord(unpack(E.TexCoords))
				child.Icon:SetInside(child.backdrop)
				child.hover:SetInside(child.backdrop)
				child.pushed:SetInside(child.backdrop)
				child.backdrop:SetFrameLevel(child.backdrop:GetFrameLevel()+1)

				child.darkOverlay = child:CreateTexture()
				child.darkOverlay:SetAllPoints(child.Icon)
				child.darkOverlay:SetDrawLayer('OVERLAY')
				child.darkOverlay:Hide()

				colorBorder(child, child.backdrop, child.Border:GetAtlas())

				child.TalentDoneAnim:HookScript("OnFinished", function(self)
					child.Border:SetAlpha(0) -- clear the yellow glow border again, after it finishes the animation
				end)
			end
		end
		self.choiceTexturePool:ReleaseAll()
		hooksecurefunc(self, "RefreshAllData", function(frame)
			frame.choiceTexturePool:ReleaseAll()
			for i=1, frame:GetNumChildren() do
				local child = select(i, frame:GetChildren())
				if child and child.Icon and child.backdrop then
					colorBorder(child, child.backdrop, child.Border:GetAtlas())
				end
			end
		end)
		self.skinned = true
	end)
end

local OrderHallFollower = CreateFrame("Frame")
OrderHallFollower:RegisterEvent("ADDON_LOADED")
OrderHallFollower:SetScript("OnEvent", function(self, event, addon)
	if (event == "ADDON_LOADED" and addon == "Blizzard_OrderHallUI") then
		OrderHallFollower:RegisterEvent("DISPLAY_SIZE_CHANGED")
		OrderHallFollower:RegisterEvent("UI_SCALE_CHANGED")
		OrderHallFollower:RegisterEvent("GARRISON_FOLLOWER_CATEGORIES_UPDATED")
		OrderHallFollower:RegisterEvent("GARRISON_FOLLOWER_ADDED")
		OrderHallFollower:RegisterEvent("GARRISON_FOLLOWER_REMOVED")

	elseif event ~= "ADDON_LOADED" then
		local bar = _G["OrderHallCommandBar"]

		local index = 1
		C_TimerAfter(0.5, function() -- Give it a bit more time to collect.
			local last
			for i, child in ipairs({bar:GetChildren()}) do
				if child.Icon and child.Count and child.TroopPortraitCover then
					child:SetWidth(65)

					child.TroopPortraitCover:Hide()
					child.Icon:SetSize(36, 22)

					child.Count:ClearAllPoints()
					child.Count:SetPoint("LEFT", child.Icon, "RIGHT", 5, 0)
					child.Count:SetTextColor(.9, .9, .9)
					child.Count:SetShadowOffset(.75, -.75)

					last = child.Count

					index = index + 1
				end
			end
		end)
	end
end)

S:AddCallbackForAddon("Blizzard_OrderHallUI", "mUIOrderHall", styleOrderhall)