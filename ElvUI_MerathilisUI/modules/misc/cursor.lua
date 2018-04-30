local MER, E, L, V, P, G = unpack(select(2, ...))

--Cache global variables
--Lua functions

--WoW API / Variables
local CreateFrame = CreateFrame
local GetCursorPosition = GetCursorPosition
local GetEffectiveScale = GetEffectiveScale
--Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS:

local frame = CreateFrame("Frame", nil, UIParent)
frame:SetFrameStrata("TOOLTIP")

local texture = frame:CreateTexture()
texture:SetTexture([[Interface\Cooldown\star4]])
texture:SetBlendMode("ADD")
texture:SetAlpha(0.5)

local x = 0
local y = 0
local speed = 0
local function OnUpdate(_, elapsed)
	if E.db.mui.misc.cursor ~= true then return end

	local dX = x
	local dY = y
	x, y = GetCursorPosition()
	dX = x - dX
	dY = y - dY
	local weight = 2048 ^ -elapsed
	speed = math.min(weight * speed + (1 - weight) * math.sqrt(dX * dX + dY * dY) / elapsed, 1024)
	local size = speed / 6 - 16
	if (size > 0) then
		local scale = UIParent:GetEffectiveScale()
		texture:SetHeight(size)
		texture:SetWidth(size)
		texture:SetPoint("CENTER", UIParent, "BOTTOMLEFT", (x + 0.5 * dX) / scale, (y + 0.5 * dY) / scale)
		texture:Show()
	else
		texture:Hide()
	end
end

frame:SetScript("OnUpdate", OnUpdate)