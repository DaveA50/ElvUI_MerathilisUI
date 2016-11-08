local E, L, V, P, G = unpack(ElvUI);
local MER = E:GetModule('MerathilisUI');
if not IsAddOnLoaded("ElvUI_BenikUI") then return; end
local BFM = E:GetModule('BUIFlightMode');
local MFM = E:NewModule('MUIFlightMode');

function MFM:Initialize()
	if E.db.mui.general.FlightMode then

		-- Hide BenikUI Logo
		BFM.FlightMode.bottom.logo:Hide()

		-- Hide BenikUI Version
		BFM.FlightMode.bottom.benikui:Hide()

		-- Location Frame
		BFM.FlightMode.top.location:SetTemplate("Transparent")
		BFM.FlightMode.top.location:Point("TOP", BFM.FlightMode.top, "CENTER", 0, -25)
		BFM.FlightMode.top.location:Height(30)

		-- Coords X frame
		BFM.FlightMode.top.location.x:SetTemplate("Transparent")
		BFM.FlightMode.top.location.x:Height(30)

		-- Coords Y frame
		BFM.FlightMode.top.location.y:SetTemplate("Transparent")
		BFM.FlightMode.top.location.y:Height(30)

		-- MerathilisUI Logo
		BFM.FlightMode.bottom.logo = BFM.FlightMode:CreateTexture(nil, "OVERLAY")
		BFM.FlightMode.bottom.logo:Size(256, 128)
		BFM.FlightMode.bottom.logo:Point("CENTER", BFM.FlightMode.bottom, "CENTER", 0, 35)
		BFM.FlightMode.bottom.logo:SetTexture("Interface\\AddOns\\ElvUI_MerathilisUI\\media\\textures\\merathilis_logo.tga")

		-- MerathilisUI Version
		BFM.FlightMode.bottom.merathilisui = BFM.FlightMode.bottom:CreateFontString(nil, 'OVERLAY')
		BFM.FlightMode.bottom.merathilisui:FontTemplate(nil, 10)
		BFM.FlightMode.bottom.merathilisui:SetFormattedText("v%s", MER.Version)
		BFM.FlightMode.bottom.merathilisui:SetPoint("TOP", BFM.FlightMode.bottom.logo, "BOTTOM", 0, 30)
		BFM.FlightMode.bottom.merathilisui:SetTextColor(1, 1, 1)

		-- Pepe!!
		BFM.FlightMode.top.npcHolder = CreateFrame("Frame", nil, BFM.FlightMode.top)
		BFM.FlightMode.top.npcHolder:SetSize(60, 60)
		BFM.FlightMode.top.npcHolder:SetPoint("CENTER", BFM.FlightMode.top, "CENTER", 0, -2)

		BFM.FlightMode.top.pepe = CreateFrame("PlayerModel", nil, BFM.FlightMode.top.npcHolder)
		BFM.FlightMode.top.pepe:SetPoint("CENTER", BFM.FlightMode.top.npcHolder, "CENTER")
		BFM.FlightMode.top.pepe:ClearModel()
		BFM.FlightMode.top.pepe:SetCreature(86470)
		BFM.FlightMode.top.pepe:SetSize(45, 45)
		BFM.FlightMode.top.pepe:SetFacing(6.5)
		BFM.FlightMode.top.pepe:SetCamDistanceScale(1)
		BFM.FlightMode.top.pepe.isIdle = nil
	end
end

E:RegisterModule(MFM:GetName());