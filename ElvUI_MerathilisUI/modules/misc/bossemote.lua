local E, L, V, P, G = unpack(ElvUI)
local MER = E:GetModule('MerathilisUI')
local MERS = E:GetModule('MuiSkins')
local LSM = LibStub('LibSharedMedia-3.0');

-- Cache global variables
-- Lua functions
local _G = _G
-- WoW API / Variables

-- Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS: 

RAID_NOTICE_DEFAULT_HOLD_TIME = 5

function MER:Bossemote()
	RaidWarningFrame:SetWidth(250)
	RaidWarningFrame:ClearAllPoints()
	RaidWarningFrame:SetPoint('TOP', UIParent, 'CENTER', 0, 200)
	RaidWarningFrame:SetScale(1)

	for i = 1, 2 do
		local bu = CreateFrame('Frame', 'bossemoteicon'..i, RaidBossEmoteFrame)
		MERS:BD(bu)
		bu:SetSize(20, 20)
		bu:SetPoint('RIGHT', 'RaidBossEmoteFrameSlot'..i, 'LEFT', 0, i > 1 and 2 or 0)

		bu.icon = bu:CreateTexture(nil, 'ARTWORK')
		bu.icon:SetTexCoord(.1, .9, .1, .9)
		bu.icon:SetAllPoints()

		FadingFrame_OnLoad(bu)
		FadingFrame_SetFadeInTime(bu, RAID_NOTICE_FADE_IN_TIME)
		FadingFrame_SetHoldTime(bu, RAID_NOTICE_FADE_IN_TIME)
		FadingFrame_SetFadeOutTime(bu, RAID_NOTICE_FADE_OUT_TIME)

		for _, slot in pairs({_G['RaidBossEmoteFrameSlot'..i], _G['RaidWarningFrameSlot'..i]}) do
			slot:SetJustifyH('CENTER')
			if i == 2 then
				slot:ClearAllPoints()
				slot:SetPoint('BOTTOM', slot == _G['RaidBossEmoteFrameSlot2'] and _G['RaidBossEmoteFrameSlot1'] or _G['RaidWarningFrameSlot1'], 'TOP', 0, 10)
			end
		end
	end
end

function MER:LoadBossemote()
	if E.db.mui.misc.bossemote then
		self:Bossemote()
	end
end