local MER, E, L, V, P, G = unpack(select(2, ...))
local MERS = MER:GetModule("muiSkins")
local S = E:GetModule("Skins")

-- Cache global variables
-- Lua functions
local _G = _G
-- WoW API
local hooksecurefunc = hooksecurefunc
-- Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS:

local function styleChatFrame()
	if E.private.chat.enable ~= true then return; end

	local VoiceChatPromptActivateChannel = _G["VoiceChatPromptActivateChannel"]
	MERS:CreateBD(VoiceChatPromptActivateChannel)
	VoiceChatPromptActivateChannel:Styling()
	MERS:CreateBD(_G.VoiceChatChannelActivatedNotification)
	_G.VoiceChatChannelActivatedNotification:Styling()

	-- Revert my Styling function on these buttons
	if not E.db.chat.hideVoiceButtons then
		if _G.ChatFrameChannelButton then
			_G.ChatFrameChannelButton:StripTextures()
			_G.ChatFrameChannelButton.glow:Hide()
		end

		if _G.ChatFrameToggleVoiceDeafenButton then
			_G.ChatFrameToggleVoiceDeafenButton:StripTextures()
			_G.ChatFrameToggleVoiceDeafenButton.glow:Hide()
		end

		if _G.ChatFrameToggleVoiceMuteButton then
			_G.ChatFrameToggleVoiceMuteButton:StripTextures()
			_G.ChatFrameToggleVoiceMuteButton.glow:Hide()
		end
	end
end

S:AddCallback("mUIChat", styleChatFrame)
