local E, L, V, P, G = unpack(ElvUI);
local MER = E:GetModule('MerathilisUI');

-- Cache global variables
-- GLOBALS: QuestMapQuestOptions_AbandonQuest, HideUIPanel, STATICPOPUP_NUMDIALOGS, StaticPopup_OnClick, QuestMapQuestOptions_ShareQuest, QuestObjectiveTracker_ShareQuest
local _G = _G
local pairs = pairs
local strmatch = strmatch

local GetQuestLink = GetQuestLink
local GetQuestLogPushable = GetQuestLogPushable
local AbandonQuest = AbandonQuest
local IsModifiedClick = IsModifiedClick
local IsControlKeyDown = IsControlKeyDown
local IsAltKeyDown = IsAltKeyDown

-- Quest level
hooksecurefunc("QuestLogQuests_Update", function()
	for i, button in pairs(_G["QuestMapFrame"].QuestsFrame.Contents.Titles) do
		if button:IsShown() then
			local level = strmatch(GetQuestLink(button.questLogIndex), "quest:%d+:(%d+)")
			if level then
				local height = button.Text:GetHeight()
				button.Text:SetFormattedText("[%d] %s", level, button.Text:GetText())
				button.Check:SetPoint("LEFT", button.Text, button.Text:GetWrappedWidth() + 2, 0)
				button:SetHeight(button:GetHeight() - height + button.Text:GetHeight())
			end
		end
	end
end)

-- Ctrl+Click to abandon a quest or Alt+Click to share a quest(by Suicidal Katt)
hooksecurefunc("QuestMapLogTitleButton_OnClick", function(self, button)
	if IsModifiedClick() then
		if IsControlKeyDown() then
			QuestMapQuestOptions_AbandonQuest(self.questID)
			AbandonQuest()
			if _G["QuestLogPopupDetailFrame"]:IsShown() then
				HideUIPanel(_G["QuestLogPopupDetailFrame"])
			end
			for i = 1, STATICPOPUP_NUMDIALOGS do
				local frame = _G["StaticPopup"..i]
				if (frame.which == "ABANDON_QUEST" or frame.which == "ABANDON_QUEST_WITH_ITEMS") and frame:IsVisible() then StaticPopup_OnClick(frame, 1) end
			end
		elseif IsAltKeyDown() then
			if GetQuestLogPushable() then
				QuestMapQuestOptions_ShareQuest(self.questID)
			end
		end
	end
end)

hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderClick", function(_, block)
	if IsModifiedClick() then
		if IsControlKeyDown() then
			AbandonQuest()
		elseif IsAltKeyDown() then
			QuestObjectiveTracker_ShareQuest(_, block.questLogIndex)
		end
	end
end)
