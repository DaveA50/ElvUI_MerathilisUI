local E, L, V, P, G = unpack(ElvUI);
local MER = E:GetModule("MerathilisUI");

-- Wow Lua
local _G = _G

-- Wow API
local ScriptErrorsFrame_Update = _ScriptErrorsFrame_Update
local InCombatLockdown = InCombatLockdown
local GetCVarBool = GetCVarBool
local ScriptErrorsFrame_OnError = ScriptErrorsFrame_OnError
local StaticPopup_Hide = StaticPopup_Hide

-- Global variables that we don't cache, list them here for mikk's FindGlobals script
-- GLOBALS: CreateFrame, hooksecurefunc, ScriptErrorsFrameScrollFrameText, ScriptErrorsFrame, ScriptErrorsFrameScrollFrame
-- GLOBALS: UIParent, IsAddOnLoaded, LoadAddOn

local UIDebugTools = LibStub("AceAddon-3.0"):NewAddon("DebugTools", "AceEvent-3.0", "AceHook-3.0")

UIDebugTools.ModifyErrorFrame = function()
	ScriptErrorsFrameScrollFrameText.cursorOffset = 0
	ScriptErrorsFrameScrollFrameText.cursorHeight = 0
	ScriptErrorsFrameScrollFrameText:SetScript("OnEditFocusGained", nil)

	local ScriptErrors_UnHighlightText = function()
		ScriptErrorsFrameScrollFrameText:HighlightText(0, 0)
	end
	hooksecurefunc("ScriptErrorsFrame_Update", ScriptErrors_UnHighlightText)

	-- Unhighlight text when focus is hit
	local UnHighlightText = function(self)
		self:HighlightText(0, 0)
	end
	ScriptErrorsFrameScrollFrameText:HookScript("OnEscapePressed", UnHighlightText)

	ScriptErrorsFrame:SetSize(500, 300)
	ScriptErrorsFrameScrollFrame:SetSize(ScriptErrorsFrame:GetWidth() - 45, ScriptErrorsFrame:GetHeight() - 71)

	local BUTTON_WIDTH = 75
	local BUTTON_HEIGHT = 24
	local BUTTON_SPACING = 2

	-- Add a first button
	local firstButton = CreateFrame("Button", nil, ScriptErrorsFrame, "UIPanelButtonTemplate")
	firstButton:SetPoint("RIGHT", ScriptErrorsFrame.previous, "LEFT", -BUTTON_SPACING, 0)
	firstButton:SetText("First")
	firstButton:SetHeight(BUTTON_HEIGHT)
	firstButton:SetWidth(BUTTON_WIDTH)
	firstButton:SetScript("OnClick", function()
		ScriptErrorsFrame.index = 1
		ScriptErrorsFrame_Update()
	end)
	ScriptErrorsFrame.firstButton = firstButton

	-- Also add a Last button for errors
	local lastButton = CreateFrame("Button", nil, ScriptErrorsFrame, "UIPanelButtonTemplate")
	lastButton:SetPoint("LEFT", ScriptErrorsFrame.next, "RIGHT", BUTTON_SPACING, 0)
	lastButton:SetHeight(BUTTON_HEIGHT)
	lastButton:SetWidth(BUTTON_WIDTH)
	lastButton:SetText("Last")
	lastButton:SetScript("OnClick", function()
		ScriptErrorsFrame.index = #(ScriptErrorsFrame.order)
		ScriptErrorsFrame_Update()
	end)
	ScriptErrorsFrame.lastButton = lastButton
end

UIDebugTools.ScriptErrorsFrame_UpdateButtons = function()
	local numErrors = #ScriptErrorsFrame.order
	local index = ScriptErrorsFrame.index
	if (index == 0) then
		ScriptErrorsFrame.lastButton:Disable()
		ScriptErrorsFrame.firstButton:Disable()
	else
		if (numErrors == 1) then
			ScriptErrorsFrame.lastButton:Disable()
			ScriptErrorsFrame.firstButton:Disable()
		else
			ScriptErrorsFrame.lastButton:Enable()
			ScriptErrorsFrame.firstButton:Enable()
		end
	end
end

UIDebugTools.ScriptErrorsFrame_OnError = function(self, keepHidden)
	if keepHidden or self.MessagePrinted or not InCombatLockdown() or GetCVarBool("scriptErrors") ~= true then return end

	MER:Print("|cFFE30000Lua error recieved. You can view the error message when you exit combat.")
	self.MessagePrinted = true
end

UIDebugTools.PLAYER_REGEN_ENABLED = function(self)
	ScriptErrorsFrame:SetParent(UIParent)
	self.MessagePrinted = nil
end

UIDebugTools.PLAYER_REGEN_DISABLED = function(self)
	ScriptErrorsFrame:SetParent(self.HideFrame)
end

UIDebugTools.TaintError = function(event, addonName, addonFunc)
	if GetCVarBool("scriptErrors") ~= true then return end
	ScriptErrorsFrame_OnError(L["Info"]["TriedToCall"]:format(event, addonName or "<name>", addonFunc or "<func>"), false)
end

UIDebugTools.StaticPopup_Show = function(name)
	if (name == "ADDON_ACTION_FORBIDDEN") then
		StaticPopup_Hide(name)
	end
end

UIDebugTools.Initialize = function(self)
	self.HideFrame = CreateFrame("Frame")
	self.HideFrame:Hide()

	if (not IsAddOnLoaded("Blizzard_DebugTools")) then
		LoadAddOn("Blizzard_DebugTools")
	end

	self:ModifyErrorFrame()
	self:SecureHook("ScriptErrorsFrame_UpdateButtons")
	self:SecureHook("ScriptErrorsFrame_OnError")
	self:SecureHook("StaticPopup_Show")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("ADDON_ACTION_BLOCKED", "TaintError")
	self:RegisterEvent("ADDON_ACTION_FORBIDDEN", "TaintError")
end

local Loading = CreateFrame("Frame")
Loading:RegisterEvent("PLAYER_LOGIN")
Loading:SetScript("OnEvent", function()
	UIDebugTools:Initialize()
end)