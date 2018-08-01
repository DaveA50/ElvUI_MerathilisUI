local MER, E, L, V, P, G = unpack(select(2, ...))
local RB = E:NewModule("RaidBuffs")
RB.modName = L["Raid Buff Reminder"]

-- Cache global variables
-- Lua functions
local _G = _G
local pairs, select, unpack = pairs, select, unpack
-- WoW API / Variables
local CreateFrame = CreateFrame
local IsInRaid = IsInRaid
local RegisterStateDriver = RegisterStateDriver
local UnregisterStateDriver = UnregisterStateDriver
local GetSpellInfo = GetSpellInfo
local UnitAura = UnitAura
local AuraUtil_FindAuraByName = AuraUtil.FindAuraByName

-- Global variables that we don"t cache, list them here for the mikk"s Find Globals script
-- GLOBALS: FlaskFrame, FoodFrame, DARuneFrame, mUIRaidBuffReminder

local bsize = 25

RB.VisibilityStates = {
	["DEFAULT"] = "[noexists, nogroup] hide; show",
	["INPARTY"] = "[combat] hide; [group] show; [petbattle] hide; hide",
	["ALWAYS"] = "[petbattle] hide; show",
}

RB.ReminderBuffs = {
	Flask = {
		188034,			-- Flask of the Countless Armies (1300 str)
		188035,			-- Flask of the Thousand Scars (1950 Sta)
		188033,			-- Flask of the Seventh Demon (1300 agi)
		188031,			-- Flask of the Whispered Pact (1300 int)
		242551,			-- Fel Focus Str, Agi and Int +500, stam + 750
	},
	DefiledAugmentRune = {
		224001,			-- Defiled Augumentation (325 primary stat)
	},
	Food = {
		104280,	-- Well Fed
	},
	Intellect = {
		1459, -- Arcane Intellect
	},
	Stamina = {
		21562, -- Power Word: Fortitude
		6307, -- Blood Pact
	},
	AttackPower = {
		6673, -- Battle Shout
	},
}

local flaskbuffs = RB.ReminderBuffs["Flask"]
local foodbuffs = RB.ReminderBuffs["Food"]
local darunebuffs = RB.ReminderBuffs["DefiledAugmentRune"]
local intellectbuffs = RB.ReminderBuffs["Intellect"]
local staminabuffs = RB.ReminderBuffs["Stamina"]
local attackpowerbuffs = RB.ReminderBuffs["AttackPower"]

local function OnAuraChange(self, event, arg1, unit)
	if (event == "UNIT_AURA" and arg1 ~= "player") then return end

	if (flaskbuffs and flaskbuffs[1]) then
		FlaskFrame.t:SetTexture(select(3, GetSpellInfo(flaskbuffs[1])))
		for i, flaskbuffs in pairs(flaskbuffs) do
			local spellname = select(1, GetSpellInfo(flaskbuffs))
			if AuraUtil_FindAuraByName(spellname, "player") then
				FlaskFrame.t:SetTexture(select(3, GetSpellInfo(flaskbuffs)))
				FlaskFrame:SetAlpha(0.3)
				break
			else
				FlaskFrame:SetAlpha(1)
			end
		end
	end

	if (foodbuffs and foodbuffs[1]) then
		FoodFrame.t:SetTexture(select(3, GetSpellInfo(foodbuffs[1])))
		for i, foodbuffs in pairs(foodbuffs) do
			local spellname = select(1, GetSpellInfo(foodbuffs))
			if AuraUtil_FindAuraByName(spellname, "player") then
				FoodFrame.t:SetTexture(select(3, GetSpellInfo(foodbuffs)))
				FoodFrame:SetAlpha(0.3)
				break
			else
				FoodFrame:SetAlpha(1)
				FoodFrame.t:SetTexture(select(3, GetSpellInfo(foodbuffs)))
			end
		end
	end

	if (darunebuffs and darunebuffs[1]) then
	DARuneFrame.t:SetTexture(select(3, GetSpellInfo(darunebuffs[1])))
		for i, darunebuffs in pairs(darunebuffs) do
			local spellname = select(1, GetSpellInfo(darunebuffs))
			if AuraUtil_FindAuraByName(spellname, "player") then
				DARuneFrame.t:SetTexture(select(3, GetSpellInfo(darunebuffs)))
				DARuneFrame:SetAlpha(0.3)
				break
			else
				DARuneFrame:SetAlpha(1)
				DARuneFrame.t:SetTexture(select(3, GetSpellInfo(darunebuffs)))
			end
		end
	end

	if E.db.mui.raidBuffs.class == true then
		if (intellectbuffs and intellectbuffs[1]) then
		IntellectFrame.t:SetTexture(select(3, GetSpellInfo(intellectbuffs[1])))
			for i, intellectbuffs in pairs(intellectbuffs) do
				local spellname = select(1, GetSpellInfo(intellectbuffs))
				if AuraUtil_FindAuraByName(spellname, "player") then
					IntellectFrame.t:SetTexture(select(3, GetSpellInfo(intellectbuffs)))
					IntellectFrame:SetAlpha(0.3)
					break
				else
					IntellectFrame:SetAlpha(1)
					IntellectFrame.t:SetTexture(select(3, GetSpellInfo(intellectbuffs)))
				end
			end
		end

		if (staminabuffs and staminabuffs[1]) then
		StaminaFrame.t:SetTexture(select(3, GetSpellInfo(staminabuffs[1])))
			for i, staminabuffs in pairs(staminabuffs) do
				local spellname = select(1, GetSpellInfo(staminabuffs))
				if AuraUtil_FindAuraByName(spellname, "player") then
					StaminaFrame.t:SetTexture(select(3, GetSpellInfo(staminabuffs)))
					StaminaFrame:SetAlpha(0.3)
					break
				else
					StaminaFrame:SetAlpha(1)
					StaminaFrame.t:SetTexture(select(3, GetSpellInfo(staminabuffs)))
				end
			end
		end

		if (attackpowerbuffs and attackpowerbuffs[1]) then
		AttackPowerFrame.t:SetTexture(select(3, GetSpellInfo(attackpowerbuffs[1])))
			for i, attackpowerbuffs in pairs(attackpowerbuffs) do
				local spellname = select(1, GetSpellInfo(attackpowerbuffs))
				if AuraUtil_FindAuraByName(spellname, "player") then
					AttackPowerFrame.t:SetTexture(select(3, GetSpellInfo(attackpowerbuffs)))
					AttackPowerFrame:SetAlpha(0.3)
					break
				else
					AttackPowerFrame:SetAlpha(1)
					AttackPowerFrame.t:SetTexture(select(3, GetSpellInfo(attackpowerbuffs)))
				end
			end
		end
	end
end

function RB:CreateIconBuff(name, relativeTo, firstbutton)
	local button = CreateFrame("Frame", name, RB.frame)
	if firstbutton == true then
		button:Point("RIGHT", relativeTo, "RIGHT", E:Scale(-4), 0)
	else
		button:Point("RIGHT", relativeTo, "LEFT", E:Scale(-4), 0)
	end
	button:Size(bsize, bsize)
	button:SetFrameLevel(self.frame.backdrop:GetFrameLevel() + 2)

	button:CreateBackdrop("Default")
	button.backdrop:SetPoint("TOPLEFT", E:Scale(-1), E:Scale(1))
	button.backdrop:SetPoint("BOTTOMRIGHT", E:Scale(1), E:Scale(-1))
	button.backdrop:SetFrameLevel(button:GetFrameLevel() - 1)

	button.t = button:CreateTexture(name..".t", "OVERLAY")
	button.t:SetTexCoord(unpack(E.TexCoords))
	button.t:SetAllPoints(button)
end

function RB:Visibility()
	local db = E.db.mui.raidBuffs
	if db.enable then
		RegisterStateDriver(self.frame, "visibility", db.visibility == "CUSTOM" and db.customVisibility or RB.VisibilityStates[db.visibility])
		E:EnableMover(self.frame.mover:GetName())
	else
		UnregisterStateDriver(self.frame, "visibility")
		self.frame:Hide()
		E:DisableMover(self.frame.mover:GetName())
	end
end

function RB:Initialize()
	self.frame = CreateFrame("Frame", "RaidBuffReminder", E.UIParent)
	self.frame:CreateBackdrop("Transparent")
	self.frame.backdrop:SetPoint("TOPLEFT", E:Scale(-1), E:Scale(1))
	self.frame.backdrop:SetPoint("BOTTOMRIGHT", E:Scale(1), E:Scale(-1))
	self.frame.backdrop:SetFrameLevel(self.frame:GetFrameLevel() - 1)
	self.frame:Point("TOP", E.UIParent, "TOP", 0, -65)
	self.frame.backdrop:Styling()

	if E.db.mui.raidBuffs.class == true then
		self.frame:Size(bsize*3+103, bsize + 8) -- Background size (needs some adjustments)
		self:CreateIconBuff("IntellectFrame", RaidBuffReminder, true)
		self:CreateIconBuff("StaminaFrame", IntellectFrame, false)
		self:CreateIconBuff("AttackPowerFrame", StaminaFrame, false)
		self:CreateIconBuff("FlaskFrame", AttackPowerFrame, false)
		self:CreateIconBuff("FoodFrame", FlaskFrame, false)
		self:CreateIconBuff("DARuneFrame", FoodFrame, false)
	else
		self.frame:Size(bsize*3+14, bsize + 8) -- Background size (needs some adjustments)
		self:CreateIconBuff("FlaskFrame", RaidBuffReminder, true)
		self:CreateIconBuff("FoodFrame", FlaskFrame, false)
		self:CreateIconBuff("DARuneFrame", FoodFrame, false)
	end

	self.frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	self.frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
	self.frame:RegisterEvent("UNIT_AURA")
	self.frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	self.frame:RegisterEvent("PLAYER_REGEN_DISABLED")
	self.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	self.frame:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
	self.frame:RegisterEvent("CHARACTER_POINTS_CHANGED")
	self.frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self.frame:RegisterEvent("GROUP_ROSTER_UPDATE")
	self.frame:SetScript("OnEvent", OnAuraChange)

	E:CreateMover(self.frame, "RaidBuffReminderMover", L["Raid Buffs Reminder"], nil, nil, nil, "ALL,PARTY,SOLO,RAID")

	function RB:ForUpdateAll()
		RB.db = E.db.mui.raidBuffs
		self:Visibility()
	end

	self:ForUpdateAll()
end

local function InitializeCallback()
	RB:Initialize()
end

E:RegisterModule(RB:GetName(), InitializeCallback)