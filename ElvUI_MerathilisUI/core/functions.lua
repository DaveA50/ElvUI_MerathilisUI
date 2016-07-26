local E, L, V, P, G = unpack(ElvUI);
local MER = E:GetModule('MerathilisUI');
local LSM = LibStub('LibSharedMedia-3.0');

-- Cache global variables
-- Lua functions
local _G = _G
local print, select = print, select
local format = string.format
-- WoW API / Variables
local AchievementFrame = _G["AchievementFrame"]
local AchievementFrame_LoadUI = _G["AchievementFrame_LoadUI"]
local AchievementAlertFrame_ShowAlert = _G["AchievementAlertFrame_ShowAlert"]
local AlertFrame_AnimateIn = _G["AlertFrame_AnimateIn"]
local AlertFrame_FixAnchors = _G["AlertFrame_FixAnchors"]
local ChallengeModeAlertFrame_ShowAlert = _G["ChallengeModeAlertFrame_ShowAlert"]
local CreateFrame = CreateFrame
local CriteriaAlertFrame_ShowAlert = _G["CriteriaAlertFrame_ShowAlert"]
local GarrisonBuildingAlertFrame_ShowAlert = _G["GarrisonBuildingAlertFrame_ShowAlert"]
local GarrisonMissionAlertFrame = _G["GarrisonMissionAlertFrame"]
local GetInventoryItemLink = GetInventoryItemLink
local GetItemInfo = GetItemInfo
local GetSpellInfo = GetSpellInfo
local GuildChallengeAlertFrame_ShowAlert = _G["GuildChallengeAlertFrame_ShowAlert"]
local LootUpgradeFrame_ShowAlert = _G["LootUpgradeFrame_ShowAlert"]
local LootWonAlertFrame_ShowAlert = _G["LootWonAlertFrame_ShowAlert"]
local MoneyWonAlertFrame_ShowAlert = _G["MoneyWonAlertFrame_ShowAlert"]
local PlaySound = PlaySound
local ScenarioAlertFrame1 = _G["ScenarioAlertFrame1"]
local StorePurchaseAlertFrame_ShowAlert = _G["StorePurchaseAlertFrame_ShowAlert"]

MER.NewSign = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:14:14|t"

function MER:MismatchText()
	local text = format(L["MSG_MER_ELV_OUTDATED"], MER.ElvUIV, MER.ElvUIX)
	return text
end

function MER:Print(msg)
	print(E["media"].hexvaluecolor..'MUI:|r', msg)
end

function MER:PrintURL(url)
	return format("|cFF00c0fa[|Hurl:%s|h%s|h]|r", url, url)
end

local color = { r = 1, g = 1, b = 1, a = 1 }
function MER:unpackColor(color)
	return color.r, color.g, color.b, color.a
end

function MER:CreateWideShadow(f)
	local borderr, borderg, borderb = 0, 0, 0
	local backdropr, backdropg, backdropb = 0, 0, 0

	local shadow = f.shadow or CreateFrame('Frame', nil, f) -- This way you can replace current shadows.
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetOutside(f, 6, 6)
	shadow:SetBackdrop( { 
		edgeFile = LSM:Fetch('border', 'ElvUI GlowBorder'), edgeSize = E:Scale(6),
		insets = {left = E:Scale(8), right = E:Scale(8), top = E:Scale(8), bottom = E:Scale(8)},
	})
	shadow:SetBackdropColor(backdropr, backdropg, backdropb, 0)
	shadow:SetBackdropBorderColor(borderr, borderg, borderb, 0.5)
	f.shadow = shadow
end

function MER:CreateSoftShadow(f)
	local borderr, borderg, borderb = 0, 0, 0
	local backdropr, backdropg, backdropb = 0, 0, 0

	local shadow = f.shadow or CreateFrame('Frame', nil, f) -- This way you can replace current shadows.
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetOutside(f, 2, 2)
	shadow:SetBackdrop( { 
		edgeFile = LSM:Fetch('border', 'ElvUI GlowBorder'), edgeSize = E:Scale(2),
		insets = {left = E:Scale(5), right = E:Scale(5), top = E:Scale(5), bottom = E:Scale(5)},
	})
	shadow:SetBackdropColor(backdropr, backdropg, backdropb, 0)
	shadow:SetBackdropBorderColor(borderr, borderg, borderb, 0.4)
	f.shadow = shadow
end

function MER:CreateSoftGlow(f)
	if f.sglow then return end

	local borderr, borderg, borderb = 1, 1, .5
	local backdropr, backdropg, backdropb = 1, 1, .5

	local sglow = CreateFrame('Frame', nil, f)
	sglow:SetFrameLevel(1)
	sglow:SetFrameStrata(f:GetFrameStrata())
	sglow:SetOutside(f, 2, 2)
	sglow:SetBackdrop( { 
		edgeFile = LSM:Fetch('border', 'ElvUI GlowBorder'), edgeSize = E:Scale(3),
		insets = {left = E:Scale(5), right = E:Scale(5), top = E:Scale(5), bottom = E:Scale(5)},
	})
	sglow:SetBackdropColor(MER:unpackColor(E.db.general.valuecolor), 0)
	sglow:SetBackdropBorderColor(MER:unpackColor(E.db.general.valuecolor), 0.4)
	f.sglow = sglow
end