local MER, E, L, V, P, G = unpack(select(2, ...))
local MERS = E:GetModule("muiSkins")
local S = E:GetModule("Skins")

--Cache global variables
--Lua functions
local _G = _G
local select, unpack = select, unpack
--WoW API / Variables
local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc
--Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS:

local function styleCommunities()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.Communities ~= true or E.private.muiSkins.blizzard.communities ~= true then return end

	local CommunitiesFrame = _G["CommunitiesFrame"]
	CommunitiesFrame:StripTextures()
	CommunitiesFrame:Styling()

	MERS:CreateBD(CommunitiesFrame)

	if CommunitiesFrame.backdrop then
		CommunitiesFrame.backdrop:Hide()
	end

	hooksecurefunc(CommunitiesFrameCommunitiesList, "Update", function(self)
		local buttons = self.ListScrollFrame.buttons
		for i = 1, #buttons do
			local button = buttons[i]
			if button.bg then
				button.bg:Hide() -- Hide ElvUI's bg Frame
			end

			if not button.IsSkinned then
				button.Selection:Kill()
				button:SetHighlightTexture("")

				button.bd = MERS:CreateBDFrame(button, 0)
				button.bd:SetPoint("TOPLEFT", 4, -3)
				button.bd:SetPoint("BOTTOMRIGHT", -1, 3)
				--MERS:CreateBD(button, .25)
				MERS:Reskin(button.bd)

				button.IsSkinned = true
			end
		end
	end)

	-- Guild Perks
	hooksecurefunc("CommunitiesGuildPerks_Update", function(self)
		local buttons = self.Container.buttons
		for i = 1, #buttons do
			local button = buttons[i]
			if button and button:IsShown() and not button.bg then
				-- Hide the ElvUI backdrop
				if button.backdrop then
					button.backdrop:Hide()
				end
				MERS:ReskinIcon(button.Icon)
				for i = 1, 4 do
					select(i, button:GetRegions()):SetAlpha(0)
				end
				button.bg = MERS:CreateBDFrame(button, .25)
				button.bg:SetPoint("TOPLEFT", button.Icon)
				button.bg:SetPoint("BOTTOMRIGHT", button.Right)
				MERS:Reskin(button.bg)
			end
		end
	end)

	-- Guild Rewards
	hooksecurefunc("CommunitiesGuildRewards_Update", function(self)
		local buttons = self.RewardsContainer.buttons
		for i = 1, #buttons do
			local button = buttons[i]
			if button then
				-- Hide the ElvUI backdrop
				if button.backdrop then
					button.backdrop:Hide()
				end
				-- Hide the hover from ElvUI
				if button.hover then
					button.hover:Hide()
				end
				if not button.bg then
					MERS:ReskinIcon(button.Icon)
					select(6, button:GetRegions()):SetAlpha(0)
					select(7, button:GetRegions()):SetAlpha(0)

					button.bg = MERS:CreateBDFrame(button, .25)
					button.bg:SetPoint("TOPLEFT", button.Icon, 0, 1)
					button.bg:SetPoint("BOTTOMRIGHT", 0, 3)
					MERS:Reskin(button.bg)
				end
				button.DisabledBG:Hide()
			end
		end
	end)

	-- Guild Info
	local bg3 = MERS:CreateBDFrame(_G["CommunitiesFrameGuildDetailsFrameInfoMOTDScrollFrame"], .25)
	bg3:SetPoint("TOPLEFT", 0, 3)
	bg3:SetPoint("BOTTOMRIGHT", 0, -4)
end

S:AddCallbackForAddon("Blizzard_Communities", "mUICommunities", styleCommunities)