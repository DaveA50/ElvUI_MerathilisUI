local MER, F, E, L, V, P, G = unpack(select(2, ...))
local S = E:GetModule('Skins')

local _G = _G

local hooksecurefunc = hooksecurefunc

local function SkinDetailFrame()
	local ReputationDetailFrame = _G.ReputationDetailFrame

	if ReputationDetailFrame.backdrop then
		if not ReputationDetailFrame.backdrop.styling then
			ReputationDetailFrame.backdrop:Styling()

			ReputationDetailFrame.backdrop.styling = true
		end
	end
	MER:CreateBackdropShadow(ReputationDetailFrame)
end

local function LoadSkin()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.character ~= true or E.private.mui.skins.blizzard.character ~= true then return end

	hooksecurefunc("ExpandFactionHeader", SkinDetailFrame)
	hooksecurefunc("CollapseFactionHeader", SkinDetailFrame)
	hooksecurefunc("ReputationFrame_Update", SkinDetailFrame)
end

S:AddCallback("mUIReputation", LoadSkin)
