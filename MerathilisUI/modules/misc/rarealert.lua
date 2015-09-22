local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local MER = E:GetModule('MerathilisUI');

-- Credits to Haleth (RareAlert)
local blacklist = {
	[971] = true, -- Alliance garrison
	[976] = true, -- Horde garrison
}

local f = CreateFrame("Frame")
f:RegisterEvent("VIGNETTE_ADDED")
f:SetScript("OnEvent", function()
	if blacklist[GetCurrentMapAreaID()] then return end
	
	if E.db.Merathilis.RareAlert then
		PlaySoundFile("Interface\\AddOns\\MerathilisUI\\media\\sounds\\warning.ogg")
		RaidNotice_AddMessage(RaidWarningFrame, L["Rare spotted!"], ChatTypeInfo["RAID_WARNING"])
	end
end)