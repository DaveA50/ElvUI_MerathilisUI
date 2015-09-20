local E, L, V, P, G = unpack(ElvUI)
local MER = E:GetModule('MerathilisUI')
local S = E:GetModule('Skins')

local classColor = RAID_CLASS_COLORS[E.myclass]
local logo = "Interface\\AddOns\\MerathilisUI\\media\\textures\\merathilis_logo.tga" -- loads on memory when gamemenu.lua loads and waits to be called. CPU wise it's better than searching for it everytime GameMenu function is called.

local function panel_onShow(self) -- Use the same onShow function for all panels. Using "self" makes the function to apply the anims on the frame that calls the panel_onShow function.
	self:Run("Alpha", .7, 0, 1)
	self:SetSmoothType("Out")
end

function MER:GameMenu()
	-- GameMenu Frame
	if not button then -- a check so that all the stuff is not created again when MER:GameMenu() is called, because the user might use Esc several times
		local button = CreateFrame("Button", "MerConfigButton", GameMenuFrame, "GameMenuButtonTemplate")
		button:Size(GameMenuButtonUIOptions:GetWidth(), GameMenuButtonUIOptions:GetHeight())
		button:SetPoint("TOP", GameMenuButtonUIOptions, "BOTTOM", 0 , -1)
		button:SetScript("OnClick", function() MER:DasOptions() PlaySound("igMainMenuOption") HideUIPanel(GameMenuFrame) end)
		button:SetText("|cffff7d0aMerathilisUI|r")
	
		if E.private.skins.blizzard.enable == true and E.private.skins.blizzard.misc == true then
			S:HandleButton(button)
		end
		
		GameMenuFrame:HookScript("OnShow", function()
			GameMenuFrame:Height(GameMenuFrame:GetHeight() + button:GetHeight())
		end)
	end
	
	if not bottomPanel then
		local bottomPanel = CreateFrame("Frame", nil, GameMenuFrame)
		bottomPanel:SetFrameLevel(0)
		bottomPanel:SetTemplate("Transparent")
		MER:StyleFrame(bottomPanel)
		bottomPanel:SetPoint("BOTTOM", E.UIParent, "BOTTOM", 0, -E.Border)
		bottomPanel:SetWidth(GetScreenWidth() + (E.Border*2))
		bottomPanel:SetHeight(GetScreenHeight() * (1 / 4))
		
		bottomPanel:SetScript("OnShow", panel_onShow)
	end
	
	if not topPanel then
		local topPanel = CreateFrame("Frame", nil, GameMenuFrame)
		topPanel:SetFrameLevel(0)
		topPanel:SetTemplate("Transparent")
		topPanel:SetPoint("TOP", E.UIParent, "TOP", 0, 0)
		topPanel:SetWidth(GetScreenWidth() + (E.Border*2))
		topPanel:SetHeight(GetScreenHeight() * (1 / 4))
		
		topPanel:SetScript("OnShow", panel_onShow)
		
		topPanel.style = CreateFrame("Frame", nil, GameMenuFrame)
		topPanel.style:SetTemplate("Default", true)
		topPanel.style:SetFrameStrata("BACKGROUND")
		topPanel.style:Point("TOPLEFT", topPanel, "BOTTOMLEFT", 0, 1)
		topPanel.style:Point("BOTTOMRIGHT", topPanel, "BOTTOMRIGHT", 0, (E.PixelMode and -4 or -7))
		
		topPanel.style:SetScript("OnShow", panel_onShow)
		
		topPanel.style.color = topPanel.style:CreateTexture(nil, 'OVERLAY')
		topPanel.style.color:SetVertexColor(classColor.r, classColor.g, classColor.b)
		topPanel.style.color:SetInside()
		topPanel.style.color:SetTexture(E['media'].MuiFlat)
		
		topPanel.Logo = topPanel:CreateTexture(nil, 'OVERLAY')
		topPanel.Logo:SetSize(285, 128)
		topPanel.Logo:SetPoint("TOP", topPanel, "TOP", 0, -60)
		topPanel.Logo:SetTexture(logo) -- call the logo
	end
	
	-- Use this frame to control the position of the model - taken from ElvUI
	if not modelHolder then
		local modelHolder = CreateFrame("Frame", nil, GameMenuFrame)
		modelHolder:SetSize(150, 150)
		modelHolder:SetPoint("LEFT", E.UIParent, "LEFT", 400, -10)
		
		playerModel = CreateFrame("PlayerModel", nil, modelHolder)
		playerModel:SetPoint("CENTER", modelHolder, "CENTER")
		playerModel:SetUnit("player")
		playerModel.isIdle = nil
		playerModel:SetSize(GetScreenWidth() * 2, GetScreenHeight() * 2) --YES, double screen size. This prevents clipping of models. Position is controlled with the helper frame.
		playerModel:SetCamDistanceScale(5)
		playerModel:SetFacing(6.5)
		
		playerModel:SetScript("OnShow", panel_onShow)
	end

	GameMenuButtonKeybindings:ClearAllPoints()
	GameMenuButtonKeybindings:Point("TOP", MerConfigButton, "BOTTOM", 0, -1)
end

function MER:LoadGameMenu()
	if E.db.Merathilis.GameMenu then
		self:GameMenu()
	end
end
