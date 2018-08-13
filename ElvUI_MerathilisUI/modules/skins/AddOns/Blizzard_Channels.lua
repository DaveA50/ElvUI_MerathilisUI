local MER, E, L, V, P, G = unpack(select(2, ...))
local MERS = E:GetModule("muiSkins")
local S = E:GetModule("Skins")

-- Cache global variables
-- Lua functions
local _G = _G
-- WoW API
local hooksecurefunc = hooksecurefunc
-- Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS:

local function styleChannels()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.Channels ~= true or E.private.muiSkins.blizzard.channels ~= true then return end

	local ChannelFrame = _G["ChannelFrame"]
	ChannelFrame:StripTextures()
	ChannelFrame:Styling()

	local CreateChannelPopup = _G["CreateChannelPopup"]
	CreateChannelPopup:Styling()

	local friendTex = "Interface\\HELPFRAME\\ReportLagIcon-Chat"
	local queueTex = "Interface\\HELPFRAME\\HelpIcon-ItemRestoration"

	local QuickJoinToastButton = _G["QuickJoinToastButton"]
	QuickJoinToastButton:SetSize(24, 32)

	if QuickJoinToastButton.backdrop then
		QuickJoinToastButton.backdrop:Hide()
	end

	MERS:CreateBD(QuickJoinToastButton, .25)
	QuickJoinToastButton:Styling()

	QuickJoinToastButton.FriendsButton:SetTexture(friendTex)
	QuickJoinToastButton.QueueButton:SetTexture(queueTex)
	QuickJoinToastButton:SetHighlightTexture("")

	hooksecurefunc(QuickJoinToastButton, "ToastToFriendFinished", function(self)
		self.FriendsButton:SetShown(not self.displayedToast)
		self.FriendCount:SetShown(not self.displayedToast)
	end)

	hooksecurefunc(QuickJoinToastButton, "UpdateQueueIcon", function(self)
		if not self.displayedToast then return end
		self.FriendsButton:SetTexture(friendTex)
		self.QueueButton:SetTexture(queueTex)
		self.FlashingLayer:SetTexture(queueTex)
		self.FriendsButton:SetShown(false)
		self.FriendCount:SetShown(false)
	end)

	QuickJoinToastButton:HookScript("OnMouseDown", function(self)
		self.FriendsButton:SetTexture(friendTex)
	end)

	QuickJoinToastButton:HookScript("OnMouseUp", function(self)
		self.FriendsButton:SetTexture(friendTex)
	end)

	QuickJoinToastButton.Toast.Background:SetTexture("")
	local bg = MERS:CreateBDFrame(QuickJoinToastButton.Toast)
	bg:SetPoint("TOPLEFT", 10, -1)
	bg:SetPoint("BOTTOMRIGHT", 0, 3)
	bg:Styling()
	bg:Hide()
	hooksecurefunc(QuickJoinToastButton, "ShowToast", function() bg:Show() end)
	hooksecurefunc(QuickJoinToastButton, "HideToast", function() bg:Hide() end)

	local VoiceChatPromptActivateChannel = _G["VoiceChatPromptActivateChannel"]
	MERS:CreateBD(VoiceChatPromptActivateChannel)
	VoiceChatPromptActivateChannel:Styling()
	MERS:CreateBD(VoiceChatChannelActivatedNotification)
	VoiceChatChannelActivatedNotification:Styling()
end

S:AddCallbackForAddon("Blizzard_Channels", "mUIChannels", styleChannels)