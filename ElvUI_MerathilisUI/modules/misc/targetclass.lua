local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local TC = E:NewModule('TargetClass', 'AceEvent-3.0')

local classIcon

function TC:TargetChanged()
	classIcon:Hide()

	local class = UnitIsPlayer("target") and select(2, UnitClass("target")) or UnitClassification("target")
	if class then
		--local CLASS_BUTTONS = CLASS_BUTTONS
		local coordinates = CLASS_ICON_TCOORDS[class];
		--local coordinates = CLASS_BUTTONS[class]
		if coordinates then
			classIcon.Texture:SetTexCoord(coordinates[1], coordinates[2], coordinates[3], coordinates[4])
			classIcon:Show()
		end
	end	
end

function TC:ToggleSettings()
	if classIcon.db.enable then
		classIcon:SetSize(classIcon.db.size, classIcon.db.size)
		classIcon:ClearAllPoints()
		classIcon:SetPoint("CENTER", ElvUF_Target, "CENTER", classIcon.db.xOffset, classIcon.db.yOffset)

		TC:RegisterEvent("PLAYER_TARGET_CHANGED", "TargetChanged")
		TC:TargetChanged()
	else
		TC:UnregisterEvent("PLAYER_TARGET_CHANGED")
		classIcon:Hide()
	end
end

function TC:Initialize()
	classIcon = CreateFrame("Frame", "TargetClass", ElvUF_Target)
	classIcon:SetFrameLevel(12)
	classIcon.Texture = classIcon:CreateTexture(ElvUF_Target, "ARTWORK")
	classIcon.Texture:SetAllPoints()
	classIcon.Texture:SetTexture([[Interface\ArenaEnemyFrame\UI-Classes-Circles]])
	classIcon.db = E.db.mui.unitframes.unit.target.classicon

	self:ToggleSettings()
end

E:RegisterModule(TC:GetName())
