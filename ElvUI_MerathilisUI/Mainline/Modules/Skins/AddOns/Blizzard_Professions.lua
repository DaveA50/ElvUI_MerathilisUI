local MER, F, E, L, V, P, G = unpack(select(2, ...))
local module = MER:GetModule('MER_Skins')
local S = E:GetModule('Skins')

local _G = _G

local function LoadSkin()
	if not module:CheckDB('tradeskill', 'tradeskill') then
		return
	end

	local ProfessionsFrame = _G.ProfessionsFrame
	ProfessionsFrame:Styling()
	module:CreateShadow(ProfessionsFrame)

	for _, tab in next, { ProfessionsFrame.TabSystem:GetChildren() } do
		module:ReskinTab(tab)
	end
end

S:AddCallbackForAddon('Blizzard_Professions', LoadSkin)

