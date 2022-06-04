local MER, F, E, L, V, P, G = unpack(select(2, ...))
local module = MER.Modules.Skins
local S = E:GetModule('Skins')

local _G = _G
local pairs, select, unpack = pairs, select, unpack

local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

local r, g, b = unpack(E["media"].rgbvaluecolor)

local function LoadSkin()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.orderhall ~= true or E.private.skins.blizzard.garrison ~= true or E.private.mui.skins.blizzard.garrison ~= true then return end

	-- Building frame
	local GarrisonBuildingFrame = _G.GarrisonBuildingFrame
	GarrisonBuildingFrame:StripTextures()
	if not GarrisonBuildingFrame.backdrop then
		GarrisonBuildingFrame:CreateBackdrop('Transparent')
	end
	GarrisonBuildingFrame.backdrop:Styling()

	-- Building level tooltip
	local BuildingLevelTooltip = GarrisonBuildingFrame.BuildingLevelTooltip
	BuildingLevelTooltip:Styling()

	-- [[ Capacitive display frame ]]
	local GarrisonCapacitiveDisplayFrame = _G.GarrisonCapacitiveDisplayFrame
	GarrisonCapacitiveDisplayFrame:Styling()

	-- [[ Landing page ]]
	local GarrisonLandingPage = _G.GarrisonLandingPage

	for i = 1, 10 do
		select(i, GarrisonLandingPage:GetRegions()):Hide() -- Parchment
	end

	GarrisonLandingPage:Styling()
	MER:CreateBackdropShadow(GarrisonLandingPage)

	-- Report
	local Report = GarrisonLandingPage.Report
	local scrollFrame = Report.List.listScroll

	local buttons = scrollFrame.buttons
	for i = 1, #buttons do
		local button = buttons[i]
		button.BG:Hide()

		local bg = CreateFrame("Frame", nil, button, 'BackdropTemplate')
		bg:SetPoint("TOPLEFT")
		bg:SetPoint("BOTTOMRIGHT", 0, 1)
		bg:SetFrameLevel(button:GetFrameLevel() - 1)

		module:CreateBD(bg, .25)
		module:CreateGradient(bg)
	end

	for _, tab in pairs({Report.InProgress, Report.Available}) do
		tab:SetHighlightTexture("")
		tab.Text:ClearAllPoints()
		tab.Text:SetPoint("CENTER")

		local bg = CreateFrame("Frame", nil, tab, 'BackdropTemplate')
		bg:SetFrameLevel(tab:GetFrameLevel() - 1)
		bg:CreateBackdrop('Transparent')
		module:CreateGradient(bg.backdrop)

		local selectedTex = bg:CreateTexture(nil, "BACKGROUND")
		selectedTex:SetAllPoints()
		selectedTex:SetColorTexture(r, g, b, .2)
		selectedTex:Hide()
		tab.selectedTex = selectedTex

		if tab == Report.InProgress then
			bg:SetPoint("TOPLEFT", 5, 0)
			bg:SetPoint("BOTTOMRIGHT")
		else
			bg:SetPoint("TOPLEFT")
			bg:SetPoint("BOTTOMRIGHT", -7, 0)
		end
	end

	hooksecurefunc("GarrisonLandingPageReport_SetTab", function(self)
		local unselectedTab = Report.unselectedTab
		unselectedTab:SetHeight(36)
		unselectedTab:SetNormalTexture("")
		unselectedTab.selectedTex:Hide()
		self:SetNormalTexture("")
		self.selectedTex:Show()
	end)

	local FollowerList = GarrisonLandingPage.FollowerList

	FollowerList:GetRegions():Hide()
	select(2, FollowerList:GetRegions()):Hide()

	-- Ship follower list
	local FollowerList = GarrisonLandingPage.ShipFollowerList

	FollowerList:GetRegions():Hide()
	select(2, FollowerList:GetRegions()):Hide()

	-- [[ Mission UI ]]
	local GarrisonMissionFrame = _G.GarrisonMissionFrame
	if GarrisonMissionFrame.backdrop then GarrisonMissionFrame.backdrop:Hide() end
	GarrisonMissionFrame:Styling()

	hooksecurefunc("GarrisonMissonListTab_SetSelected", function(tab, isSelected)
		if isSelected then
			tab.backdrop:SetBackdropColor(r, g, b, .2)
		else
			tab.backdrop:SetBackdropColor(0, 0, 0, .25)
		end
	end)

	-- [[ Monuments ]]
	local GarrisonMonumentFrame = _G.GarrisonMonumentFrame

	GarrisonMonumentFrame.Background:Hide()
	module:CreateBD(GarrisonMonumentFrame)
	GarrisonMonumentFrame:Styling()

	-- [[ Shipyard ]]
	local GarrisonShipyardFrame = _G.GarrisonShipyardFrame
	if GarrisonShipyardFrame.backdrop then GarrisonShipyardFrame.backdrop:Hide() end
	module:CreateBD(GarrisonShipyardFrame, .25)
	GarrisonShipyardFrame:Styling()

	local shipyardTab = GarrisonShipyardFrame.FollowerTab
	shipyardTab:DisableDrawLayer("BORDER")

	local shipyardMission = GarrisonShipyardFrame.MissionTab.MissionPage
	shipyardMission:StripTextures()

	local smbg = module:CreateBDFrame(shipyardMission.Stage)
	smbg:SetPoint("TOPLEFT", 4, 1)
	smbg:SetPoint("BOTTOMRIGHT", -4, -1)

	for i = 1, 10 do
		select(i, shipyardMission.RewardsFrame:GetRegions()):Hide()
	end
	module:CreateBD(shipyardMission.RewardsFrame, .25)

	GarrisonShipyardFrame.MissionCompleteBackground:GetRegions():Hide()
	GarrisonShipyardFrame.MissionTab.MissionList.CompleteDialog:GetRegions():Hide()

	-- [[ Orderhall UI]]

	local OrderHallMissionFrame = _G.OrderHallMissionFrame
	if OrderHallMissionFrame.backdrop then OrderHallMissionFrame.backdrop:Hide() end
	module:CreateBD(OrderHallMissionFrame, .25)
	OrderHallMissionFrame:Styling()

	 --Missions
	local Mission = _G.OrderHallMissionFrameMissions
	Mission.CompleteDialog:StripTextures()
	Mission.CompleteDialog:CreateBackdrop("Transparent")

	local MissionPage = _G.OrderHallMissionFrame.MissionTab.MissionPage
	for i = 1, 10 do
		select(i, MissionPage.RewardsFrame:GetRegions()):Hide()
	end
	module:CreateBD(MissionPage.RewardsFrame, .25)

	-- [[ BFA Mission UI]]
	local BFAMissionFrame = _G.BFAMissionFrame
	BFAMissionFrame:Styling()

	-- [[ Shadowlands Missions ]]
	local CovenantMissionFrame = _G.CovenantMissionFrame
	CovenantMissionFrame:Styling()
	MER:CreateBackdropShadow(CovenantMissionFrame)

	CovenantMissionFrame.RaisedBorder:SetAlpha(0)
	_G.CovenantMissionFrameMissions.RaisedFrameEdges:SetAlpha(0)
	_G.CovenantMissionFrameMissions.MaterialFrame.LeftFiligree:SetAlpha(0)
	_G.CovenantMissionFrameMissions.MaterialFrame.RightFiligree:SetAlpha(0)

	hooksecurefunc(CovenantMissionFrame, "SetupTabs", function(self)
		self.MapTab:SetShown(not self.Tab2:IsShown())
	end)

	_G.CombatLog:DisableDrawLayer("BACKGROUND")
	_G.CombatLog.ElevatedFrame:SetAlpha(0)
	_G.CombatLog.CombatLogMessageFrame:StripTextures()
	module:CreateBDFrame(_G.CombatLog.CombatLogMessageFrame, .25)

	local bg = module:CreateBDFrame(CovenantMissionFrame.FollowerTab, .25)
	bg:SetPoint("TOPLEFT", 3, 2)
	bg:SetPoint("BOTTOMRIGHT", -3, -10)
	CovenantMissionFrame.FollowerTab.RaisedFrameEdges:SetAlpha(0)
	CovenantMissionFrame.FollowerTab.HealFollowerFrame.ButtonFrame:SetAlpha(0)
	_G.CovenantMissionFrameFollowers.ElevatedFrame:SetAlpha(0)
	_G.CovenantMissionFrameFollowersListScrollFrameScrollBar:DisableDrawLayer("BACKGROUND")
	_G.CovenantMissionFrameFollowersListScrollFrameScrollBar:CreateBackdrop('Transparent')
	module:CreateGradient(_G.CovenantMissionFrameFollowersListScrollFrameScrollBar.backdrop)
end

S:AddCallbackForAddon("Blizzard_GarrisonUI", LoadSkin)
