local MER, E, L, V, P, G = unpack(select(2, ...))
local SMB = MER:NewModule("mUIMinimapButtons", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
local COMP = MER:GetModule("mUICompatibility")
SMB.modName = L["Minimap Buttons"]

--Cache global variables
--Lua functions
local _G = _G

--WoW API / Variables

--Global variables that we don't cache, list them here for mikk's FindGlobals script
-- GLOBALS:

SMB.Buttons = {}

local ignoreButtons = {
	'GameTimeFrame',
	'HelpOpenWebTicketButton',
	'MiniMapVoiceChatFrame',
	'TimeManagerClockButton',
	'BattlefieldMinimap',
	'ButtonCollectFrame',
	'GameTimeFrame',
	'QueueStatusMinimapButton',
	'GarrisonLandingPageMinimapButton',
	'MiniMapMailFrame',
	'MiniMapTracking',
	'TukuiMinimapZone',
	'TukuiMinimapCoord',
}

local GenericIgnores = {
	'Archy',
	'GatherMatePin',
	'GatherNote',
	'GuildInstance',
	'HandyNotesPin',
	'MiniMap',
	'Spy_MapNoteList_mini',
	'ZGVMarker',
	'poiMinimap',
	'GuildMap3Mini',
	'LibRockConfig-1.0_MinimapButton',
	'NauticusMiniIcon',
	'WestPointer',
	'Cork',
	'DugisArrowMinimapPoint',
}

local PartialIgnores = { 'Node', 'Note', 'Pin', 'POI' }

local AcceptedFrames = {
	'BagSync_MinimapButton',
	'VendomaticButtonFrame',
}

local ButtonFunctions = { 'SetParent', 'ClearAllPoints', 'SetPoint', 'SetSize', 'SetScale', 'SetFrameStrata', 'SetFrameLevel' }

function SMB:LockButton(Button)
	for _, Function in pairs(ButtonFunctions) do
		Button[Function] = MER.dummy
	end
end

function SMB:UnlockButton(Button)
	for _, Function in pairs(ButtonFunctions) do
		Button[Function] = nil
	end
end

function SMB:HandleBlizzardButtons()
	if not self.db['enable'] then return end

	if self.db['hideGarrison'] then
		GarrisonLandingPageMinimapButton:UnregisterAllEvents()
		GarrisonLandingPageMinimapButton:SetParent(self.Hider)
		GarrisonLandingPageMinimapButton:Hide()
	elseif self.db["moveGarrison"] and not GarrisonLandingPageMinimapButton.SMB then
		GarrisonLandingPageMinimapButton:SetParent(Minimap)
		GarrisonLandingPageMinimapButton:Show()
		GarrisonLandingPageMinimapButton:SetScale(1)
		GarrisonLandingPageMinimapButton:SetHitRectInsets(0, 0, 0, 0)
		GarrisonLandingPageMinimapButton:SetScript('OnEnter', nil)
		GarrisonLandingPageMinimapButton:SetScript('OnLeave', nil)

		GarrisonLandingPageMinimapButton:HookScript('OnEnter', function(self)
			self:SetBackdropBorderColor(unpack(E["media"].rgbvaluecolor))
			if SMB.Bar:IsShown() then
				UIFrameFadeIn(SMB.Bar, 0.2, SMB.Bar:GetAlpha(), 1)
			end
		end)
		GarrisonLandingPageMinimapButton:HookScript('OnLeave', function(self)
			self:SetTemplate()
			if SMB.Bar:IsShown() and SMB.db['barMouseOver'] then
				UIFrameFadeOut(SMB.Bar, 0.2, SMB.Bar:GetAlpha(), 0)
			end
		end)

		GarrisonLandingPageMinimapButton.SMB = true
		tinsert(self.Buttons, GarrisonLandingPageMinimapButton)
	end

	if self.db["moveTracker"] and not MiniMapTrackingButton.SMB then
		MiniMapTracking.Show = nil

		MiniMapTracking:Show()

		MiniMapTracking:SetParent(self.Bar)
		MiniMapTracking:SetSize(self.db['iconSize'], self.db['iconSize'])

		MiniMapTrackingIcon:ClearAllPoints()
		MiniMapTrackingIcon:SetPoint('CENTER')

		MiniMapTrackingBackground:SetAlpha(0)
		MiniMapTrackingIconOverlay:SetAlpha(0)
		MiniMapTrackingButton:SetAlpha(0)

		MiniMapTrackingButton:SetParent(MinimapTracking)
		MiniMapTrackingButton:ClearAllPoints()
		MiniMapTrackingButton:SetAllPoints(MiniMapTracking)

		MiniMapTrackingButton:SetScript('OnMouseDown', nil)
		MiniMapTrackingButton:SetScript('OnMouseUp', nil)

		MiniMapTrackingButton:HookScript('OnEnter', function(self)
			MiniMapTracking:SetBackdropBorderColor(unpack(E["media"].rgbvaluecolor))
			if SMB.Bar:IsShown() then
				UIFrameFadeIn(SMB.Bar, 0.2, SMB.Bar:GetAlpha(), 1)
			end
		end)
		MiniMapTrackingButton:HookScript('OnLeave', function(self)
			MiniMapTracking:SetTemplate()
			if SMB.Bar:IsShown() and SMB.db['barMouseOver'] then
				UIFrameFadeOut(SMB.Bar, 0.2, SMB.Bar:GetAlpha(), 0)
			end
		end)

		MiniMapTrackingButton.SMB = true
		tinsert(self.Buttons, MiniMapTracking)
	end

	if self.db["moveQueue"] and not QueueStatusMinimapButton.SMB then
		local Frame = CreateFrame('Frame', 'SMB_QueueFrame', self.Bar)
		Frame:SetTemplate()
		Frame:SetSize(SMB.db['iconSize'], SMB.db['iconSize'])
		Frame.Icon = Frame:CreateTexture(nil, 'ARTWORK')
		Frame.Icon:SetSize(SMB.db['iconSize'], SMB.db['iconSize'])
		Frame.Icon:SetPoint('CENTER')
		Frame.Icon:SetTexture([[Interface\LFGFrame\LFG-Eye]])
		Frame.Icon:SetTexCoord(0, 64 / 512, 0, 64 / 256)
		Frame:SetScript('OnMouseDown', function()
			if PVEFrame:IsShown() then
				HideUIPanel(PVEFrame)
			else
				ShowUIPanel(PVEFrame)
				GroupFinderFrame_ShowGroupFrame()
			end
		end)
		Frame:HookScript('OnEnter', function(self)
			self:SetBackdropBorderColor(unpack(E["media"].rgbvaluecolor))
			if SMB.Bar:IsShown() then
				UIFrameFadeIn(SMB.Bar, 0.2, SMB.Bar:GetAlpha(), 1)
			end
		end)
		Frame:HookScript('OnLeave', function(self)
			self:SetTemplate()
			if SMB.Bar:IsShown() and SMB.db['barMouseOver'] then
				UIFrameFadeOut(SMB.Bar, 0.2, SMB.Bar:GetAlpha(), 0)
			end
		end)

		QueueStatusMinimapButton:SetParent(self.Bar)
		QueueStatusMinimapButton:SetFrameLevel(Frame:GetFrameLevel() + 2)
		QueueStatusMinimapButton:ClearAllPoints()
		QueueStatusMinimapButton:SetPoint("CENTER", Frame, "CENTER", 0, 0)

		QueueStatusMinimapButton:SetHighlightTexture(nil)

		QueueStatusMinimapButton:HookScript('OnShow', function(self)
			Frame:EnableMouse(false)
		end)
		QueueStatusMinimapButton:HookScript('PostClick', QueueStatusMinimapButton_OnLeave)
		QueueStatusMinimapButton:HookScript('OnHide', function(self)
			Frame:EnableMouse(true)
		end)

		QueueStatusMinimapButton.SMB = true
		tinsert(self.Buttons, Frame)
	end

	self:Update()
end

function SMB:SkinMinimapButton(Button)
	if (not Button) or Button.isSkinned then return end

	local Name = Button:GetName()
	if not Name then return end

	if Button:IsObjectType('Button') then
		if tContains(ignoreButtons, Name) then return end

		for i = 1, #GenericIgnores do
			if strsub(Name, 1, strlen(GenericIgnores[i])) == GenericIgnores[i] then return end
		end

		for i = 1, #PartialIgnores do
			if strfind(Name, PartialIgnores[i]) ~= nil then return end
		end
	end

	for i = 1, Button:GetNumRegions() do
		local Region = select(i, Button:GetRegions())
		if Region:GetObjectType() == 'Texture' then
			local Texture = Region:GetTexture()

			if Texture then
				if (strfind(Texture, "Interface\\CharacterFrame") or strfind(Texture, "Interface\\Minimap")) then
					Region:SetTexture(nil)
				elseif (strfind(Texture, 'Border') or strfind(Texture, 'Background') or strfind(Texture, 'AlphaMask') or strfind(Texture, 'Highlight')) then
					Region:SetAlpha(0)
				else
					if Name == 'BagSync_MinimapButton' then
						Region:SetTexture('Interface\\AddOns\\BagSync\\media\\icon')
					elseif Name == 'DBMMinimapButton' then
						Region:SetTexture('Interface\\Icons\\INV_Helmet_87')
					elseif Name == 'OutfitterMinimapButton' then
						if Region:GetTexture() == 'Interface\\Addons\\Outfitter\\Textures\\MinimapButton' then
							Region:SetTexture(nil)
						end
					elseif Name == 'SmartBuff_MiniMapButton' then
						Region:SetTexture('Interface\\Icons\\Spell_Nature_Purge')
					elseif Name == 'VendomaticButtonFrame' then
						Region:SetTexture('Interface\\Icons\\INV_Misc_Rabbit_2')
					end
					Region:ClearAllPoints()
					Region:SetInside()
					Region:SetTexCoord(unpack(self.TexCoords))
					Button:HookScript('OnLeave', function() Region:SetTexCoord(unpack(self.TexCoords)) end)
					Region:SetDrawLayer('ARTWORK')
					Region.SetPoint = function() return end
				end
			end
		end
	end

	Button:SetFrameLevel(Minimap:GetFrameLevel() + 5)
	Button:SetSize(SMB.db['iconSize'], SMB.db['iconSize'])
	Button:SetTemplate()
	Button:HookScript('OnEnter', function(self)
		self:SetBackdropBorderColor(unpack(E["media"].rgbvaluecolor))
		if SMB.Bar:IsShown() then
			UIFrameFadeIn(SMB.Bar, 0.2, SMB.Bar:GetAlpha(), 1)
		end
	end)
	Button:HookScript('OnLeave', function(self)
		self:SetTemplate()
		if SMB.Bar:IsShown() and SMB.db['barMouseOver'] then
			UIFrameFadeOut(SMB.Bar, 0.2, SMB.Bar:GetAlpha(), 0)
		end
	end)

	Button.isSkinned = true
	tinsert(self.Buttons, Button)
end

function SMB:GrabMinimapButtons()
	if (InCombatLockdown() or C_PetBattles.IsInBattle()) then return end

	for _, Frame in pairs({ Minimap, MinimapBackdrop }) do
		for i = 1, Frame:GetNumChildren() do
			local object = select(i, Frame:GetChildren())
			if object then
				local name = object:GetName()
				local width = object:GetWidth()
				if name and width > 15 and width < 40 and (object:IsObjectType('Button') or object:IsObjectType('Frame') and tContains(AcceptedFrames, name)) then
					self:SkinMinimapButton(object)
				end
			end
		end
	end

	self:Update()
end

function SMB:Update()
	if not SMB.db['enable'] then return end

	local AnchorX, AnchorY, MaxX = 0, 1, SMB.db['buttonsPerRow']
	local ButtonsPerRow = SMB.db['buttonsPerRow']
	local NumColumns = ceil(#SMB.Buttons / ButtonsPerRow)
	local Spacing, Mult = SMB.db['buttonSpacing'], 1
	local Size = SMB.db['iconSize']
	local ActualButtons, Maxed = 0

	if NumColumns == 1 and ButtonsPerRow > #SMB.Buttons then
		ButtonsPerRow = #SMB.Buttons
	end

	for _, Button in pairs(SMB.Buttons) do
		if Button:IsVisible() then
			AnchorX = AnchorX + 1
			ActualButtons = ActualButtons + 1
			if AnchorX > MaxX then
				AnchorY = AnchorY + 1
				AnchorX = 1
				Maxed = true
			end

			SMB:UnlockButton(Button)

			Button:SetTemplate()
			Button:SetParent(self.Bar)
			Button:ClearAllPoints()
			Button:SetPoint('TOPLEFT', self.Bar, 'TOPLEFT', (Spacing + ((Size + Spacing) * (AnchorX - 1))), (- Spacing - ((Size + Spacing) * (AnchorY - 1))))
			Button:SetSize(SMB.db['iconSize'], SMB.db['iconSize'])
			Button:SetScale(1)
			Button:SetFrameStrata('LOW')
			Button:SetFrameLevel(self.Bar:GetFrameLevel() + 1)
			Button:SetScript('OnDragStart', nil)
			Button:SetScript('OnDragStop', nil)

			SMB:LockButton(Button)

			if Maxed then ActualButtons = ButtonsPerRow end
		end
	end

	local BarWidth = (Spacing + ((Size * (ActualButtons * Mult)) + ((Spacing * (ActualButtons - 1)) * Mult) + (Spacing * Mult)))
	local BarHeight = (Spacing + ((Size * (AnchorY * Mult)) + ((Spacing * (AnchorY - 1)) * Mult) + (Spacing * Mult)))
	self.Bar:SetSize(BarWidth, BarHeight)

	if self.db.backdrop then
		self.Bar:SetTemplate('Transparent')
	else
		self.Bar:SetBackdrop(nil)
	end

	self.Bar:Show()

	if self.db['barMouseOver'] then
		UIFrameFadeOut(self.Bar, 0.2, self.Bar:GetAlpha(), 0)
	else
		UIFrameFadeIn(self.Bar, 0.2, self.Bar:GetAlpha(), 1)
	end
end

function SMB:Initialize()
	if E.private.general.minimap.enable ~= true or E.db.mui["smb"].enable ~= true then return end

	if (COMP.PA and _G.ProjectAzilroka.db.SMB == true or COMP.SLE and E.private.sle.minimap.mapicons.enable) then return end

	SMB.db = E.db.mui["smb"]

	SMB.Hider = CreateFrame("Frame", nil, UIParent)

	SMB.Bar = CreateFrame('Frame', 'SquareMinimapButtonBar', UIParent)
	SMB.Bar:Hide()
	SMB.Bar:SetPoint('RIGHT', UIParent, 'RIGHT', -45, 0)
	SMB.Bar:SetFrameStrata('LOW')
	SMB.Bar:SetClampedToScreen(true)
	SMB.Bar:SetMovable(true)
	SMB.Bar:EnableMouse(true)
	SMB.Bar:SetSize(SMB.db.iconSize, SMB.db.iconSize)

	SMB.Bar:SetScript('OnEnter', function(self) UIFrameFadeIn(self, 0.2, self:GetAlpha(), 1) end)
	SMB.Bar:SetScript('OnLeave', function(self)
		if SMB.db['barMouseOver'] then
			UIFrameFadeOut(self, 0.2, self:GetAlpha(), 0)
		end
	end)

	SMB.Bar:Styling()

	E:CreateMover(SMB.Bar, MER.Title.."SquareMinimapButtonBarMover", "SquareMinimapButtonBar Anchor", nil, nil, nil, 'ALL,GENERAL,MERATHILISUI')

	SMB.TexCoords = {unpack(E.TexCoords)}

	Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

	SMB:ScheduleRepeatingTimer('GrabMinimapButtons', 6)
	SMB:ScheduleTimer('HandleBlizzardButtons', 7)
end

local function InitializeCallback()
	SMB:Initialize()
end

MER:RegisterModule(SMB:GetName(), InitializeCallback)