local MER, E, L, V, P, G = unpack(select(2, ...))
local MI = MER:GetModule("mUIMisc")
local LSM = LibStub("LibSharedMedia-3.0")

--Cache global variables
--Lua functions
--WoW API / Variables
local CreateFrame = CreateFrame
local GetCursorPosition = GetCursorPosition
local GetMouseFocus = GetMouseFocus
local IsAddOnLoaded = IsAddOnLoaded
local UnitCanAttack = UnitCanAttack
local UnitClass = UnitClass
local UnitExists = UnitExists
local UnitReaction = UnitReaction
local UnitIsAFK = UnitIsAFK
local UnitIsDND = UnitIsDND
local UnitIsDead = UnitIsDead
local UnitIsPlayer = UnitIsPlayer
local UnitName = UnitName
local UIParent = UIParent
local UNKNOWN = UNKNOWN
--Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS: CUSTOM_CLASS_COLORS, RAID_CLASS_COLORS

local function getcolor()
	local reaction = UnitReaction("mouseover", "player") or 5

	if UnitIsPlayer("mouseover") then
		local _, class = UnitClass("mouseover")
		local color = (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class]) or (RAID_CLASS_COLORS and RAID_CLASS_COLORS[class])
		return color.r, color.g, color.b
	elseif UnitCanAttack("player", "mouseover") then
		if UnitIsDead("mouseover") then
			return 136/255, 136/255, 136/255
		else
			if reaction < 4 then
				return 1, 68/255, 68/255
			elseif reaction == 4 then
				return 1, 1, 68/255
			end
		end
	else
		if reaction < 4 then
			return 48/255, 113/255, 191/255
		else
			return 1, 1, 1
		end
	end
end

function MI:LoadnameHover()
	if E.db.mui.nameHover.enable ~= true or IsAddOnLoaded("bdNameHover") then return end

	local db = E.db.mui.nameHover
	local tooltip = CreateFrame("frame", nil)
	tooltip:SetFrameStrata("TOOLTIP")
	tooltip.text = MER:CreateText(tooltip, "OVERLAY", db.size or 7, "OUTLINE")

	-- Show unit name at mouse
	tooltip:SetScript("OnUpdate", function(self)
		if GetMouseFocus() and GetMouseFocus():IsForbidden() then self:Hide() return end
		if GetMouseFocus() and GetMouseFocus():GetName() ~= "WorldFrame" then self:Hide() return end
		if not UnitExists("mouseover") then self:Hide() return end
		local x, y = GetCursorPosition()
		local scale = UIParent:GetEffectiveScale()
		self.text:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x, y+15)
	end)

	tooltip:SetScript("OnEvent", function(self)
		if GetMouseFocus():GetName() ~= "WorldFrame" then return end

		local name = UnitName("mouseover") or UNKNOWN
		local AFK = UnitIsAFK("mouseover")
		local DND = UnitIsDND("mouseover")
		local prefix = ""

		if AFK then prefix = "|cffff0000<AFK>|r " end
		if DND then prefix = "|cffffce00<DND>|r " end

		self.text:SetTextColor(getcolor())
		self.text:SetText(prefix..name)

		self:Show()
	end)

	tooltip:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
end
