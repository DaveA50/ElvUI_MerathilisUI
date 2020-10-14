local MER, E, _, V, P, G = unpack(select(2, ...))
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale or 'enUS')
local module = MER:GetModule('MER_Actionbars')
local LCG = LibStub('LibCustomGlow-1.0')

--Cache global variables
local _G = _G
local pairs, unpack = pairs, unpack
--WoW API / Variables
local GetActionInfo = GetActionInfo
local IsAddOnLoaded = IsAddOnLoaded
local C_TimerAfter = C_Timer.After
-- GLOBALS:

function module:StyleBackdrops()
	-- Actionbar backdrops
	for i = 1, 10 do
		local styleBacks = {_G['ElvUI_Bar'..i]}
		for _, frame in pairs(styleBacks) do
			if frame then
				frame:Styling()
			end
		end
	end

	-- Other bar backdrops
	local styleOtherBacks = {_G.ElvUI_BarPet, _G.ElvUI_StanceBar}
	for _, frame in pairs(styleOtherBacks) do
		if frame then
			frame:Styling()
		end
	end

	-- Pet Buttons
	for i = 1, _G.NUM_PET_ACTION_SLOTS do
		local petButtons = {_G['PetActionButton'..i]}
		for _, button in pairs(petButtons) do
			if button then
				button:Styling()
			end
		end
	end
end

function module:ActionbarGlow()
	if not E.private.actionbar.enable or not E.db.mui.actionbars.customGlow then return end

	local r, g, b = unpack(E.media.rgbvaluecolor)
	local color = {r, g, b, 1}

	local lib = LibStub("LibButtonGlow-1.0")
	if lib then
		function lib.ShowOverlayGlow(button)
			if button:GetAttribute("type") == "action" then
				local actionType, actionID = GetActionInfo(button:GetAttribute("action"))
				LCG.PixelGlow_Start(button, color, nil, 0.5, nil, 1)
			end
		end
		function lib.HideOverlayGlow(button)
			LCG.PixelGlow_Stop(button)
		end
	end
end

function module:Initialize()
	if E.private.actionbar.enable ~= true then return; end

	local db = E.db.mui.actionbars
	MER:RegisterDB(self, "actionbars")

	self:EquipSpecBar()

	C_TimerAfter(1, module.StyleBackdrops)
	C_TimerAfter(0.1, module.ActionbarGlow)
end

MER:RegisterModule(module:GetName())
