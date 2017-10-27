local MER, E, L, V, P, G = unpack(select(2, ...))
local MERS = E:GetModule("muiSkins")
local S = E:GetModule("Skins")

--Cache global variables
--Lua functions
local _G = _G
--WoW API / Variables

--Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS:

local function styleCalendar()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.calendar ~= true or E.private.muiSkins.blizzard.calendar ~= true then return end

	for i = 1, 42 do
		_G["CalendarDayButton"..i]:DisableDrawLayer("BACKGROUND")
		_G["CalendarDayButton"..i.."DarkFrame"]:SetAlpha(.5)
	end
	for i = 1, 7 do
		_G["CalendarWeekday"..i.."Background"]:SetAlpha(0)
	end

	MERS:CreateStripes(_G["CalendarFrame"])
	MERS:CreateGradient(_G["CalendarFrame"])
	MERS:CreateStripes(_G["CalendarCreateEventFrame"])
	MERS:CreateGradient(_G["CalendarCreateEventFrame"])
	MERS:CreateStripes(_G["CalendarViewHolidayFrame"])
	MERS:CreateGradient(_G["CalendarViewHolidayFrame"])
end

S:AddCallbackForAddon("Blizzard_Calendar", "mUICalendar", styleCalendar)