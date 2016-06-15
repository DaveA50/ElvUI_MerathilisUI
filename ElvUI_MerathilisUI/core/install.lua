local E, L, V, P, G = unpack(ElvUI);
local MER = E:GetModule('MerathilisUI');

-- Cache global variables
-- Lua functions
local _G = _G
local print, tonumber, unpack = print, tonumber, unpack
local format = format
local ceil = ceil
-- WoW API / Variables
local IsAddOnLoaded = IsAddOnLoaded
local GetAddOnMetadata = GetAddOnMetadata
local PlaySoundFile = PlaySoundFile
local UIFrameFadeOut = UIFrameFadeOut
local ReloadUI = ReloadUI
local CreateFrame = CreateFrame
local ChangeChatColor = ChangeChatColor
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local FCF_GetChatWindowInfo = FCF_GetChatWindowInfo
local FCF_SetChatWindowFontSize = FCF_SetChatWindowFontSize
local FCF_DockFrame, FCF_UnDockFrame = FCF_DockFrame, FCF_UnDockFrame
local FCF_SetLocked = FCF_SetLocked
local FCF_SetWindowName = FCF_SetWindowName
local FCF_SavePositionAndDimensions = FCF_SavePositionAndDimensions
local FCF_StopDragging = FCF_StopDragging
local ChatFrame_RemoveChannel = ChatFrame_RemoveChannel
local ChatFrame_AddChannel = ChatFrame_AddChannel
local ChatFrame_AddMessageGroup = ChatFrame_AddMessageGroup
local CONTINUE, PREVIOUS, ADDONS = CONTINUE, PREVIOUS, ADDONS
local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS
local LOOT, TRADE = LOOT, TRADE
local ToggleChatColorNamesByClassGroup = ToggleChatColorNamesByClassGroup
local LeftChatToggleButton = LeftChatToggleButton
local CreateAnimationGroup = CreateAnimationGroup

-- Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS: SkadaDB, xCTSavedDB, MERTitleFrame, MERInstallFrame, InstallStatus, InstallStepComplete
-- GLOBALS: ChatFrame3, ChatFrame1, InstallNextButton, InstallPrevButton, InstallOption1Button, InstallOption2Button
-- GLOBALS: InstallOption3Button,  InstallOption4Button

local CURRENT_PAGE = 0
local MAX_PAGE = 8
local titleText = {}

local classColor = E.myclass == 'PRIEST' and E.PriestColors or (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[E.myclass] or RAID_CLASS_COLORS[E.myclass])
local factionGroup = UnitFactionGroup("player")

function E:GetColor(r, b, g, a)
	return { r = r, b = b, g = g, a = a }
end

local function SetupMERLayout(layout)
	if not IsAddOnLoaded('ElvUI_BenikUI') then
		E:StaticPopup_Show('BENIKUI')
	end
	
	if E.db["movers"] == nil then E.db["movers"] = {} end -- prevent a lua error when running the install after a profile gets deleted.
	
	-- General
	E.private["general"]["pixelPerfect"] = true
	E.global["general"]["autoScale"] = true
	E.private["general"]["chatBubbles"] = "nobackdrop"
	E.private["general"]["chatBubbleFont"] = "Merathilis Prototype"
	E.private["general"]["chatBubbleFontSize"] = 11
	E.db["general"]["valuecolor"] = {r = classColor.r, g = classColor.g, b = classColor.b}
	E.db["general"]["totems"]["size"] = 36
	E.db["general"]["font"] = "Merathilis Prototype"
	E.db["general"]["fontSize"] = 10
	E.db["general"]["interruptAnnounce"] = "RAID"
	E.db["general"]["minimap"]["size"] = 130
	E.db["general"]["minimap"]["locationText"] = "HIDE"
	E.db["general"]["loginmessage"] = false
	E.db["general"]["stickyFrames"] = false
	E.db["general"]["loot"] = true
	E.db["general"]["lootRoll"] = true
	E.db["general"]["backdropcolor"]["r"] = 0.101
	E.db["general"]["backdropcolor"]["g"] = 0.101
	E.db["general"]["backdropcolor"]["b"] = 0.101
	E.db["general"]["bottomPanel"] = false
	E.db["general"]["topPanel"] = false
	E.db["general"]["bonusObjectivePosition"] = "AUTO"
	E.global["general"]["smallerWorldMap"] = false
	E.db["general"]["backdropfadecolor"]["r"] = 0.0549
	E.db["general"]["backdropfadecolor"]["g"] = 0.0549
	E.db["general"]["backdropfadecolor"]["b"] = 0.0549
	E.private["general"]["namefont"] = "Merathilis PrototypeRU"
	E.private["general"]["dmgfont"] = "Action Man"
	E.private["general"]["normTex"] = "MerathilisFlat"
	E.private["general"]["glossTex"] = "MerathilisFlat"
	E.db["general"]["experience"]["enable"] = true
	E.db["general"]["experience"]["mouseover"] = false
	E.db["general"]["experience"]["height"] = 155
	E.db["general"]["experience"]["textSize"] = 10
	E.db["general"]["experience"]["width"] = 10
	E.db["general"]["experience"]["textFormat"] = "NONE"
	E.db["general"]["experience"]["orientation"] = "VERTICAL"
	E.db["general"]["experience"]["hideAtMaxLevel"] = true
	E.db["general"]["experience"]["hideInVehicle"] = true
	E.db["general"]["reputation"]["enable"] = true
	E.db["general"]["reputation"]["mouseover"] = false
	E.db["general"]["reputation"]["height"] = 155
	E.db["general"]["reputation"]["textSize"] = 10
	E.db["general"]["reputation"]["width"] = 10
	E.db["general"]["reputation"]["textFormat"] = "NONE"
	E.db["general"]["reputation"]["orientation"] = "VERTICAL"
	E.db["general"]["reputation"]["hideInVehicle"] = true
	E.db["movers"]["AltPowerBarMover"] = "TOP,ElvUIParent,TOP,1,-272"
	E.db["movers"]["MinimapMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-5,-6"
	E.db["movers"]["GMMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,329,0"
	E.db["movers"]["BNETMover"] = "TOP,ElvUIParent,TOP,0,-38"
	E.db["movers"]["LootFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-495,-457"
	E.db["movers"]["AlertFrameMover"] = "TOP,ElvUIParent,TOP,0,-140"
	E.db["movers"]["TotemBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,446,2"
	E.db["movers"]["LossControlMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,432"
	E.db["movers"]["ExperienceBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,413,23"
	E.db["movers"]["ReputationBarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-413,23"
	E.db["movers"]["ObjectiveFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-200,-281"
	E.db["movers"]["VehicleSeatMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,2,-84"
	E.db["movers"]["ProfessionsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-184"
	
	-- Auras
	if IsAddOnLoaded("Masque") then
		E.private["auras"]["masque"]["buffs"] = true
		E.private["auras"]["masque"]["debuffs"] = true
	end
	E.db["auras"]["debuffs"]["size"] = 30
	E.db["auras"]["fadeThreshold"] = 10
	E.db["auras"]["font"] = "Merathilis Prototype"
	E.db["auras"]["fontOutline"] = "OUTLINE"
	E.db["auras"]["buffs"]["fontSize"] = 12
	E.db["auras"]["buffs"]["horizontalSpacing"] = 10
	E.db["auras"]["buffs"]["verticalSpacing"] = 15
	E.db["auras"]["buffs"]["size"] = 24
	E.db["auras"]["buffs"]["wrapAfter"] = 10
	E.db["auras"]["debuffs"]["horizontalSpacing"] = 5
	E.db["auras"]["debuffs"]["size"] = 30
	E.db["movers"]["BuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-158,-6"
	E.db["movers"]["DebuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-158,-115"
	
	-- Bags
	E.db["bags"]["itemLevelFont"] = "Merathilis Prototype"
	E.db["bags"]["itemLevelFontSize"] = 9
	E.db["bags"]["itemLevelFontOutline"] = 'OUTLINE'
	E.db["bags"]["countFont"] = "Merathilis Prototype"
	E.db["bags"]["countFontSize"] = 10
	E.db["bags"]["countFontOutline"] = "OUTLINE"
	E.db["bags"]["yOffsetBank"] = 20
	E.db["bags"]["yOffset"] = 20
	E.db["bags"]["bagSize"] = 23
	E.db["bags"]["alignToChat"] = false
	E.db["bags"]["bagWidth"] = 350
	E.db["bags"]["bankSize"] = 23
	E.db["bags"]["bankWidth"] = 350
	E.db["bags"]["moneyFormat"] = "BLIZZARD"
	E.db["bags"]["itemLevelThreshold"] = 650
	E.db["bags"]["junkIcon"] = true

	-- Nameplates need to be redone
	-- E.db["nameplate"]["debuffs"]["fontSize"] = 9
	-- E.db["nameplate"]["debuffs"]["font"] = "Merathilis Prototype"
	-- E.db["nameplate"]["debuffs"]["fontOutline"] = "OUTLINE"
	-- E.db["nameplate"]["wrapName"] = false
	-- E.db["nameplate"]["fontOutline"] = "OUTLINE"
	-- E.db["nameplate"]["sortDirection"] = 1
	-- E.db["nameplate"]["comboPoints"] = true
	-- E.db["nameplate"]["colorByTime"] = true
	-- E.db["nameplate"]["healthBar"]["colorByRaidIcon"] = true
	-- E.db["nameplate"]["healthBar"]["height"] = 4
	-- E.db["nameplate"]["healthBar"]["text"]["enable"] = true
	-- E.db["nameplate"]["healthBar"]["text"]["format"] = "CURRENT_PERCENT"
	-- E.db["nameplate"]["healthBar"]["lowHPScale"]["enable"] = true
	-- E.db["nameplate"]["healthBar"]["width"] = 100
	-- E.db["nameplate"]["auraFont"] = "PT Sans Narrow"
	-- E.db["nameplate"]["targetIndicator"]["color"]["g"] = 0
	-- E.db["nameplate"]["targetIndicator"]["color"]["b"] = 0
	-- E.db["nameplate"]["font"] = "Merathilis Tukui"
	-- E.db["nameplate"]["maxAuras"] = 5
	-- E.db["nameplate"]["fontSize"] = 10
	-- E.db["nameplate"]["auraAnchor"] = 1
	-- E.db["nameplate"]["buffs"]["fontOutline"] = "OUTLINE"
	-- E.db["nameplate"]["buffs"]["font"] = "Merathilis Prototype"
	-- E.db["nameplate"]["auraFontOutline"] = "OUTLINE"
	-- E.db["nameplate"]["healthtext"] = "CURRENT_PERCENT"
	
	-- Tooltip
	E.db["tooltip"]["itemCount"] = "NONE"
	E.db["tooltip"]["healthBar"]["height"] = 5
	E.db["tooltip"]["healthBar"]["font"] = "Merathilis Prototype"
	E.db["tooltip"]["healthBar"]["fontOutline"] = "OUTLINE"
	E.db["tooltip"]["visibility"]["combat"] = true
	E.db["tooltip"]["font"] = "Merathilis Expressway"
	E.db["tooltip"]["style"] = "inset"
	E.db["tooltip"]["fontOutline"] = "OUTLINE"
	E.db["tooltip"]["headerFontSize"] = 12
	E.db["tooltip"]["textFontSize"] = 11
	E.db["tooltip"]["smallTextFontSize"] = 11
	E.db["movers"]["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-3,278"

	if InstallStepComplete then
		InstallStepComplete.message = MER.Title..L['MerathilisUI Set']
		InstallStepComplete:Show()
		titleText[2].check:Show()
	end
	E:UpdateAll(true)
end

local function SetupMERChat(layout)

	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format('ChatFrame%s', i)]
		local chatFrameId = frame:GetID()
		local chatName = FCF_GetChatWindowInfo(chatFrameId)
		
		FCF_SetChatWindowFontSize(nil, frame, 12)
		
		-- move ElvUI default loot frame to the left chat, so that Recount/Skada can go to the right chat.
		if i == 3 and chatName == LOOT..' / '..TRADE then
			FCF_UnDockFrame(frame)
			frame:ClearAllPoints()
			frame:Point('BOTTOMLEFT', LeftChatToggleButton, 'TOPLEFT', 1, 3)
			FCF_SetWindowName(frame, LOOT)
			FCF_DockFrame(frame)
			FCF_SetLocked(frame, 1)
			frame:Show()
		end
		FCF_SavePositionAndDimensions(frame)
		FCF_StopDragging(frame)
	end
	ChatFrame_RemoveChannel(ChatFrame3, L["Trade"])
	ChatFrame_AddChannel(ChatFrame1, L["Trade"])
	ChatFrame_AddMessageGroup(ChatFrame1, "TARGETICONS")
	
	-- Chat
	E.db["chat"]["keywordSound"] = "Whisper Alert"
	E.db["chat"]["tabFont"] = "Merathilis Prototype"
	E.db["chat"]["tabFontOutline"] = "OUTLINE"
	E.db["chat"]["tabFontSize"] = 10
	E.db["chat"]["panelTabTransparency"] = true
	E.db["chat"]["fontOutline"] = "OUTLINE"
	E.db["chat"]["chatHistory"] = false
	E.db["chat"]["font"] = "Merathilis Expressway"
	E.db["chat"]["panelWidth"] = 350
	E.db["chat"]["panelHeight"] = 155
	E.db["chat"]["editBoxPosition"] = "ABOVE_CHAT"
	E.db["chat"]["panelBackdrop"] = "SHOWBOTH"
	if E.myname == "Merathilis" or "Damará" or "Melisendra" or "Asragoth" or "Róhal" or "Jústice" or "Jazira" or "Brítt" or "Jahzzy" then
		E.db["chat"]["keywords"] = "%MYNAME%, ElvUI, MerathilisUI, Andy"
	else
		E.db["chat"]["keywords"] = "%MYNAME%, ElvUI, MerathilisUI"
	end
	E.db["chat"]["timeStampFormat"] = "%H:%M "
	if E.myclass == "DRUID" and E.myname == "Merathilis" then
		E.db["chat"]["panelBackdropNameRight"] = "Interface\\AddOns\\ElvUI_MerathilisUI\\media\\textures\\chat.tga"
	else
		E.db["chat"]["panelBackdropNameRight"] = ""
	end
	E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-2,23"
	E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,2,23"
	
	if InstallStepComplete then
		InstallStepComplete.message = MER.Title..L['Chat Set']
		InstallStepComplete:Show()
		titleText[3].check:Show()
	end
	E:UpdateAll(true)
end

local function SetupMERActionbars(layout)
	-- Actionbars
	if layout == 'small' then
		E.db["actionbar"]["font"] = "Merathilis Prototype"
		E.db["actionbar"]["fontOutline"] = "OUTLINE"
		E.db["actionbar"]["macrotext"] = true
		E.db["actionbar"]["showGrid"] = false
		E.db["actionbar"]["lockActionBars"] = true
		
		if IsAddOnLoaded("Masque") then
			E.private["actionbar"]["masque"]["stanceBar"] = true
			E.private["actionbar"]["masque"]["petBar"] = true
			E.private["actionbar"]["masque"]["actionbars"] = true
		end
		
		if IsAddOnLoaded("ElvUI_BenikUI") then
			E.db['benikui']['actionbars']['transparent'] = true
			E.db['benikui']['actionbars']['toggleButtons']['enable'] = true
			E.db['benikui']['actionbars']['toggleButtons']['chooseAb'] = "BAR1"
			E.db['benikui']['actionbars']['requestStop'] = true
		end
		
		E.db["actionbar"]["bar1"]["buttonspacing"] = 4
		E.db["actionbar"]["bar1"]["backdrop"] = true
		E.db["actionbar"]["bar1"]["heightMult"] = 2
		E.db["actionbar"]["bar1"]["buttonsize"] = 30
		E.db["actionbar"]["bar1"]["buttons"] = 12
		E.db["actionbar"]["bar1"]["backdropSpacing"] = 3
		
		E.db["actionbar"]["bar2"]["enabled"] = true
		E.db["actionbar"]["bar2"]["buttonspacing"] = 4
		E.db["actionbar"]["bar2"]["buttons"] = 12
		E.db["actionbar"]["bar2"]["buttonsize"] = 30
		E.db["actionbar"]["bar2"]["backdrop"] = false
		E.db["actionbar"]["bar2"]["visibility"] = "[vehicleui][overridebar][petbattle][possessbar] hide; show"
		E.db["actionbar"]["bar2"]["mouseover"] = false
		E.db["actionbar"]["bar2"]["backdropSpacing"] = 4
		
		E.db["actionbar"]["bar3"]["backdrop"] = true
		E.db["actionbar"]["bar3"]["buttonsPerRow"] = 2
		E.db["actionbar"]["bar3"]["buttonsize"] = 24
		E.db["actionbar"]["bar3"]["buttonspacing"] = 5
		E.db["actionbar"]["bar3"]["buttons"] = 12
		E.db["actionbar"]["bar3"]["point"] = "TOPLEFT"
		E.db["actionbar"]["bar3"]["backdropSpacing"] = 2
		
		E.db["actionbar"]["bar4"]["buttonspacing"] = 4
		E.db["actionbar"]["bar4"]["mouseover"] = true
		E.db["actionbar"]["bar4"]["buttonsize"] = 24
		E.db["actionbar"]["bar4"]["backdropSpacing"] = 2
		
		E.db["actionbar"]["bar5"]["backdrop"] = true
		E.db["actionbar"]["bar5"]["buttonsPerRow"] = 2
		E.db["actionbar"]["bar5"]["buttonsize"] = 24
		E.db["actionbar"]["bar5"]["buttonspacing"] = 5
		E.db["actionbar"]["bar5"]["buttons"] = 12
		E.db["actionbar"]["bar5"]["point"] = "BOTTOMLEFT"
		E.db["actionbar"]["bar5"]["backdropSpacing"] = 2
		
		E.db["actionbar"]["bar6"]["enabled"] = false
		
		E.db["actionbar"]["barPet"]["point"] = "BOTTOMLEFT"
		E.db["actionbar"]["barPet"]["buttons"] = 8
		E.db["actionbar"]["barPet"]["buttonspacing"] = 1
		E.db["actionbar"]["barPet"]["buttonsPerRow"] = 1
		E.db["actionbar"]["barPet"]["buttonsize"] = 19
		E.db["actionbar"]["barPet"]["mouseover"] = true
		
		E.db["actionbar"]["stanceBar"]["point"] = "BOTTOMLEFT"
		E.db["actionbar"]["stanceBar"]["backdrop"] = true
		E.db["actionbar"]["stanceBar"]["buttonsPerRow"] = 6
		E.db["actionbar"]["stanceBar"]["buttonsize"] = 18
		if E.myclass == "DRUID" then
			E.db["actionbar"]["stanceBar"]["mouseover"] = true
		else
			E.db["actionbar"]["stanceBar"]["mouseover"] = false
		end
		E.db["actionbar"]["extraActionButton"]["scale"] = 0.75
		E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,26"
		E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,60"
		E.db["movers"]["ElvAB_3"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-353,3"
		E.db["movers"]["ElvAB_4"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,367"
		E.db["movers"]["ElvAB_5"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,353,3"
		E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,98"
		E.db["movers"]["PetAB"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,423,2"
		E.db["movers"]["BossButton"] = "BOTTOM,ElvUIParent,BOTTOM,-233,29"
		E.db["movers"]["MicrobarMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-4"

	elseif layout == 'big' then
		E.db["actionbar"]["font"] = "Merathilis Prototype"
		E.db["actionbar"]["fontOutline"] = "OUTLINE"
		E.db["actionbar"]["macrotext"] = true
		E.db["actionbar"]["showGrid"] = false
		E.db["actionbar"]["lockActionBars"] = true
		
		if IsAddOnLoaded("Masque") then
			E.private["actionbar"]["masque"]["stanceBar"] = true
			E.private["actionbar"]["masque"]["petBar"] = true
			E.private["actionbar"]["masque"]["actionbars"] = true
		end
		
		if IsAddOnLoaded("ElvUI_BenikUI") then
			E.db['benikui']['actionbars']['transparent'] = true
			E.db['benikui']['actionbars']['toggleButtons']['enable'] = true
			E.db['benikui']['actionbars']['toggleButtons']['chooseAb'] = "BAR1"
			E.db['benikui']['actionbars']['requestStop'] = true
		end
		
		E.db["actionbar"]["bar1"]["buttonspacing"] = 4
		E.db["actionbar"]["bar1"]["backdrop"] = true
		E.db["actionbar"]["bar1"]["heightMult"] = 3
		E.db["actionbar"]["bar1"]["buttonsize"] = 28
		E.db["actionbar"]["bar1"]["buttons"] = 12
		E.db["actionbar"]["bar1"]["backdropSpacing"] = 3
		
		E.db["actionbar"]["bar2"]["enabled"] = true
		E.db["actionbar"]["bar2"]["buttonspacing"] = 4
		E.db["actionbar"]["bar2"]["buttons"] = 12
		E.db["actionbar"]["bar2"]["buttonsize"] = 28
		E.db["actionbar"]["bar2"]["backdrop"] = false
		E.db["actionbar"]["bar2"]["visibility"] = "[vehicleui][overridebar][petbattle][possessbar] hide; show"
		E.db["actionbar"]["bar2"]["mouseover"] = false
		E.db["actionbar"]["bar2"]["backdropSpacing"] = 4
		E.db["actionbar"]["bar2"]["heightMult"] = 1
		
		E.db["actionbar"]["bar3"]["backdrop"] = true
		E.db["actionbar"]["bar3"]["buttonsPerRow"] = 2
		E.db["actionbar"]["bar3"]["buttonsize"] = 24
		E.db["actionbar"]["bar3"]["buttonspacing"] = 5
		E.db["actionbar"]["bar3"]["buttons"] = 12
		E.db["actionbar"]["bar3"]["point"] = "TOPLEFT"
		E.db["actionbar"]["bar3"]["backdropSpacing"] = 2
		
		E.db["actionbar"]["bar4"]["buttonspacing"] = 4
		E.db["actionbar"]["bar4"]["mouseover"] = true
		E.db["actionbar"]["bar4"]["buttonsize"] = 24
		E.db["actionbar"]["bar4"]["backdropSpacing"] = 2
		
		E.db["actionbar"]["bar5"]["backdrop"] = true
		E.db["actionbar"]["bar5"]["buttonsPerRow"] = 2
		E.db["actionbar"]["bar5"]["buttonsize"] = 24
		E.db["actionbar"]["bar5"]["buttonspacing"] = 5
		E.db["actionbar"]["bar5"]["buttons"] = 12
		E.db["actionbar"]["bar5"]["point"] = "BOTTOMLEFT"
		E.db["actionbar"]["bar5"]["backdropSpacing"] = 2
		
		E.db["actionbar"]["bar6"]["enabled"] = true
		E.db["actionbar"]["bar6"]["enabled"] = true
		E.db["actionbar"]["bar6"]["buttonspacing"] = 4
		E.db["actionbar"]["bar6"]["buttons"] = 12
		E.db["actionbar"]["bar6"]["buttonsize"] = 28
		E.db["actionbar"]["bar6"]["backdrop"] = false
		E.db["actionbar"]["bar6"]["mouseover"] = false
		E.db["actionbar"]["bar6"]["backdropSpacing"] = 4
		
		E.db["actionbar"]["barPet"]["point"] = "BOTTOMLEFT"
		E.db["actionbar"]["barPet"]["buttons"] = 8
		E.db["actionbar"]["barPet"]["buttonspacing"] = 1
		E.db["actionbar"]["barPet"]["buttonsPerRow"] = 1
		E.db["actionbar"]["barPet"]["buttonsize"] = 19
		E.db["actionbar"]["barPet"]["mouseover"] = true
		
		E.db["actionbar"]["stanceBar"]["point"] = "BOTTOMLEFT"
		E.db["actionbar"]["stanceBar"]["backdrop"] = true
		E.db["actionbar"]["stanceBar"]["buttonsPerRow"] = 6
		E.db["actionbar"]["stanceBar"]["buttonsize"] = 18
		if E.myclass == "DRUID" then
			E.db["actionbar"]["stanceBar"]["mouseover"] = true
		else
			E.db["actionbar"]["stanceBar"]["mouseover"] = false
		end
		E.db["actionbar"]["extraActionButton"]["scale"] = 0.75
		E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,26"
		E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,59"
		E.db["movers"]["ElvAB_3"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-353,3"
		E.db["movers"]["ElvAB_4"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,367"
		E.db["movers"]["ElvAB_5"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,353,3"
		E.db["movers"]["ElvAB_6"] = "BOTTOM,ElvUIParent,BOTTOM,0,91"
		E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,130"
		E.db["movers"]["PetAB"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,423,2"
		E.db["movers"]["BossButton"] = "BOTTOM,ElvUIParent,BOTTOM,-233,29"
		E.db["movers"]["MicrobarMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-4"
	end

	if InstallStepComplete then
		InstallStepComplete.message = MER.Title..L['Actionbars Set']
		InstallStepComplete:Show()
		titleText[5].check:Show()
	end
	E:UpdateAll(true)
end

local function SetupUnitframes(layout)

	-- Unitframes
	E.db["unitframe"]["font"] = "Merathilis Tukui"
	E.db["unitframe"]["fontSize"] = 12
	E.db["unitframe"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["smoothbars"] = true
	E.db["unitframe"]["statusbar"] = "MerathilisFlat"
	E.db["unitframe"]["colors"]["powerclass"] = true
	E.db["unitframe"]["colors"]["castColor"]["r"] = 0.1
	E.db["unitframe"]["colors"]["castColor"]["g"] = 0.1
	E.db["unitframe"]["colors"]["castColor"]["b"] = 0.1
	E.db["unitframe"]["colors"]["transparentHealth"] = true
	E.db["unitframe"]["colors"]["transparentAurabars"] = true
	E.db["unitframe"]["colors"]["transparentPower"] = false
	E.db["unitframe"]["colors"]["transparentCastbar"] = true
	E.db["unitframe"]["colors"]["castClassColor"] = false
	E.db["unitframe"]["colors"]["health"]["r"] = 0.23
	E.db["unitframe"]["colors"]["health"]["g"] = 0.23
	E.db["unitframe"]["colors"]["health"]["b"] = 0.23
	E.db["unitframe"]["colors"]["power"]["MANA"] = E:GetColor(classColor.r, classColor.b, classColor.g)
	E.db["unitframe"]["colors"]["power"]["RAGE"] = E:GetColor(classColor.r, classColor.b, classColor.g)
	E.db["unitframe"]["colors"]["power"]["FOCUS"] = E:GetColor(classColor.r, classColor.b, classColor.g)
	E.db["unitframe"]["colors"]["power"]["ENERGY"] = E:GetColor(classColor.r, classColor.b, classColor.g)
	E.db["unitframe"]["colors"]["power"]["RUNIC_POWER"] = E:GetColor(classColor.r, classColor.b, classColor.g)
	E.db["unitframe"]["colors"]["castClassColor"] = false
	E.db["unitframe"]["colors"]["castReactionColor"] = false
	
	-- Player
	E.db["unitframe"]["units"]["player"]["width"] = 180
	E.db["unitframe"]["units"]["player"]["height"] = 40
	E.db["unitframe"]["units"]["player"]['orientation'] = "RIGHT"
	E.db["unitframe"]["units"]["player"]["debuffs"]["fontSize"] = 12
	E.db["unitframe"]["units"]["player"]["debuffs"]["attachTo"] = "POWER"
	E.db["unitframe"]["units"]["player"]["debuffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["player"]["debuffs"]["xOffset"] = 0
	E.db["unitframe"]["units"]["player"]["debuffs"]["yOffset"] = 1
	E.db["unitframe"]["units"]["player"]["debuffs"]["perrow"] = 6
	E.db["unitframe"]["units"]["player"]["debuffs"]["anchorPoint"] = "TOPLEFT"
	E.db["unitframe"]["units"]["player"]["smartAuraPosition"] = "DISABLED"
	E.db["unitframe"]["units"]["player"]["portrait"]["enable"] = true
	E.db["unitframe"]["units"]["player"]["portrait"]["overlay"] = false
	E.db["unitframe"]["units"]["player"]["portrait"]["camDistanceScale"] = 1
	-- Use Classbar not for Druid, because of Balance PowerTracker
	if E.myclass == "DRUID" then
		E.db["unitframe"]["units"]["player"]["classbar"]["enable"] = false
	else
		E.db["unitframe"]["units"]["player"]["classbar"]["enable"] = true
		E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = true
		E.db["unitframe"]["units"]["player"]["classbar"]["xOffset"] = 110
		E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 135
		E.db["unitframe"]["units"]["player"]["classbar"]["fill"] = "spaced"
		E.db["unitframe"]["units"]["player"]["classbar"]["autoHide"] = true
	end
	E.db["unitframe"]["units"]["player"]["aurabar"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["threatStyle"] = "INFOPANELBORDER"
	E.db["unitframe"]["units"]["player"]["castbar"]["icon"] = true
	E.db["unitframe"]["units"]["player"]["castbar"]["latency"] = true
	E.db["unitframe"]["units"]["player"]["castbar"]["insideInfoPanel"] = true
	if not E.db["unitframe"]["units"]["player"]["customTexts"] then E.db["unitframe"]["units"]["player"]["customTexts"] = {} end
	E.db["unitframe"]["units"]["player"]["customTexts"] = {}
	E.db["unitframe"]["units"]["player"]["customTexts"]["BigName"] = {}
	E.db["unitframe"]["units"]["player"]["customTexts"]["BigName"]["font"] = "Merathilis Tukui"
	E.db["unitframe"]["units"]["player"]["customTexts"]["BigName"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["player"]["customTexts"]["BigName"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["BigName"]["text_format"] = "[name:medium] [difficultycolor][smartlevel] [shortclassification]"
	E.db["unitframe"]["units"]["player"]["customTexts"]["BigName"]["size"] = 22
	E.db["unitframe"]["units"]["player"]["customTexts"]["BigName"]["attachTextTo"] = 'Health'
	E.db["unitframe"]["units"]["player"]["customTexts"]["Percent"] = {}
	E.db["unitframe"]["units"]["player"]["customTexts"]["Percent"]["font"] = "Merathilis Tukui"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Percent"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Percent"]["size"] = 20
	E.db["unitframe"]["units"]["player"]["customTexts"]["Percent"]["justifyH"] = "RIGHT"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Percent"]["text_format"] = "[namecolor][health:percent_short]"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Percent"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["player"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["player"]["health"]["yOffset"] = 0
	E.db["unitframe"]["units"]["player"]["health"]["text_format"] = "[healthcolor][health:current] - [namecolor][power:current]"
	E.db["unitframe"]["units"]["player"]["health"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["player"]["power"]["height"] = 5
	E.db["unitframe"]["units"]["player"]["power"]["hideonnpc"] = true
	E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] = true
	E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 180
	E.db["unitframe"]["units"]["player"]["power"]["druidMana"] = false
	E.db["unitframe"]["units"]["player"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["player"]["buffs"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["raidicon"]["enable"] = true
	E.db["unitframe"]["units"]["player"]["raidicon"]["position"] = "TOP"
	E.db["unitframe"]["units"]["player"]["raidicon"]["size"] = 18
	E.db["unitframe"]["units"]["player"]["raidicon"]["xOffset"] = 0
	E.db["unitframe"]["units"]["player"]["raidicon"]["yOffset"] = 15
	E.db["unitframe"]["units"]["player"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["player"]["infoPanel"]["height"] = 13
	E.db["unitframe"]["units"]["player"]["infoPanel"]["transparent"] = true
	if IsAddOnLoaded("ElvUI_BenikUI") then
		-- Detach portrait 
		E.db['benikui']['unitframes']['player']['detachPortrait'] = true
		E.db['benikui']['unitframes']['player']['portraitWidth'] = 92
		E.db['benikui']['unitframes']['player']['portraitHeight'] = 39
		E.db['benikui']['unitframes']['player']['portraitShadow'] = false
		E.db['benikui']['unitframes']['player']['portraitTransparent'] = true
		E.db['benikui']['unitframes']['player']['portraitStyle'] = true
		E.db['benikui']['unitframes']['player']['portraitStyleHeight'] = 4
		-- Castbar
		E.db['benikui']['unitframes']['castbar']['text']['yOffset'] = 0
		E.db['benikui']['unitframes']['castbar']['text']['ShowInfoText'] = false
		E.db['benikui']['unitframes']['castbar']['text']['castText'] = true
		E.db['benikui']['unitframes']['castbar']['text']['texture'] = "MerathilisEmpty"
		E.db['benikui']['unitframes']['castbar']['text']['textColor'] = {r = classColor.r, g = classColor.g, b = classColor.b}
	end
	E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-176,141"
	E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-176,179"
	E.db["movers"]["PlayerPortraitMover"] = "BOTTOM,ElvUIParent,BOTTOM,-313,141"
	E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,185"
	
	-- Target
	E.db["unitframe"]["units"]["target"]["width"] = 180
	E.db["unitframe"]["units"]["target"]["height"] = 40
	E.db["unitframe"]["units"]["target"]['orientation'] = "LEFT"
	E.db["unitframe"]["units"]["target"]["castbar"]["icon"] = true
	E.db["unitframe"]["units"]["target"]["castbar"]["latency"] = true
	E.db["unitframe"]["units"]["target"]["castbar"]["insideInfoPanel"] = true
	E.db["unitframe"]["units"]["target"]["debuffs"]["fontSize"] = 12
	E.db["unitframe"]["units"]["target"]["debuffs"]["sizeOverride"] = 28
	E.db["unitframe"]["units"]["target"]["debuffs"]["yOffset"] = 7
	E.db["unitframe"]["units"]["target"]["debuffs"]["xOffset"] = 94
	E.db["unitframe"]["units"]["target"]["debuffs"]["anchorPoint"] = "RIGHT"
	E.db["unitframe"]["units"]["target"]["debuffs"]["perrow"] = 4
	E.db["unitframe"]["units"]["target"]["debuffs"]["attachTo"] = "FRAME"
	E.db["unitframe"]["units"]["target"]["smartAuraPosition"] = "DISABLED"
	E.db["unitframe"]["units"]["target"]["aurabar"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["aurabar"]["attachTo"] = "BUFFS"
	E.db["unitframe"]["units"]["target"]["name"]["xOffset"] = 8
	E.db["unitframe"]["units"]["target"]["name"]["yOffset"] = -32
	E.db["unitframe"]["units"]["target"]["name"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["target"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["target"]["threatStyle"] = "INFOPANELBORDER"
	E.db["unitframe"]["units"]["target"]["power"]["detachFromFrame"] = true
	E.db["unitframe"]["units"]["target"]["power"]["detachedWidth"] = 180
	E.db["unitframe"]["units"]["target"]["power"]["hideonnpc"] = false
	E.db["unitframe"]["units"]["target"]["power"]["height"] = 5
	E.db["unitframe"]["units"]["target"]["power"]["text_format"] = ""
	if not E.db["unitframe"]["units"]["target"]["customTexts"] then E.db["unitframe"]["units"]["target"]["customTexts"] = {} end
	E.db["unitframe"]["units"]["target"]["customTexts"] = {}
	E.db["unitframe"]["units"]["target"]["customTexts"]["BigName"] = {}
	E.db["unitframe"]["units"]["target"]["customTexts"]["BigName"]["font"] = "Merathilis Tukui"
	E.db["unitframe"]["units"]["target"]["customTexts"]["BigName"]["justifyH"] = "RIGHT"
	E.db["unitframe"]["units"]["target"]["customTexts"]["BigName"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["BigName"]["xOffset"] = 4
	E.db["unitframe"]["units"]["target"]["customTexts"]["BigName"]["yOffset"] = 0
	E.db["unitframe"]["units"]["target"]["customTexts"]["BigName"]["size"] = 22
	E.db["unitframe"]["units"]["target"]["customTexts"]["BigName"]["text_format"] = "[name:short] [difficultycolor][shortclassification]"
	E.db["unitframe"]["units"]["target"]["customTexts"]["BigName"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Class"] = {}
	E.db["unitframe"]["units"]["target"]["customTexts"]["Class"]["font"] = "Merathilis Tukui"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Class"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Class"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Class"]["xOffset"] = 1
	E.db["unitframe"]["units"]["target"]["customTexts"]["Class"]["size"] = 12
	E.db["unitframe"]["units"]["target"]["customTexts"]["Class"]["text_format"] = "[namecolor][smartclass] [difficultycolor][level]"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Class"]["yOffset"] = 0
	E.db["unitframe"]["units"]["target"]["customTexts"]["Class"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Percent"] = {}
	E.db["unitframe"]["units"]["target"]["customTexts"]["Percent"]["font"] = "Merathilis Tukui"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Percent"]["size"] = 20
	E.db["unitframe"]["units"]["target"]["customTexts"]["Percent"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Percent"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Percent"]["text_format"] = "[namecolor][health:percent_short]"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Percent"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Targeting"] = {}
	E.db["unitframe"]["units"]["target"]["customTexts"]["Targeting"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Targeting"]["font"] = "Merathilis Tukui"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Targeting"]["size"] = 12
	E.db["unitframe"]["units"]["target"]["customTexts"]["Targeting"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Targeting"]["justifyH"] = "CENTER"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Targeting"]["text_format"] = "[num:targeting]"
	E.db["unitframe"]["units"]["target"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["target"]["health"]["yOffset"] = 0
	E.db["unitframe"]["units"]["target"]["health"]["text_format"] = "[namecolor][power:current][healthcolor] - [health:current]"
	E.db["unitframe"]["units"]["target"]["health"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["target"]["portrait"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["portrait"]["overlay"] = false
	E.db["unitframe"]["units"]["target"]["portrait"]["camDistanceScale"] = 1
	E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["buffs"]["xOffset"] = 0
	E.db["unitframe"]["units"]["target"]["buffs"]["yOffset"] = 1
	E.db["unitframe"]["units"]["target"]["buffs"]["attachTo"] = "POWER"
	E.db["unitframe"]["units"]["target"]["buffs"]["sizeOverride"] = 20
	E.db["unitframe"]["units"]["target"]["buffs"]["perrow"] = 9
	E.db["unitframe"]["units"]["target"]["buffs"]["fontSize"] = 12
	E.db["unitframe"]["units"]["target"]["raidicon"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["raidicon"]["position"] = "TOP"
	E.db["unitframe"]["units"]["target"]["raidicon"]["size"] = 18
	E.db["unitframe"]["units"]["target"]["raidicon"]["xOffset"] = 0
	E.db["unitframe"]["units"]["target"]["raidicon"]["yOffset"] = 15
	E.db["unitframe"]["units"]["target"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["infoPanel"]["height"] = 13
	E.db["unitframe"]["units"]["target"]["infoPanel"]["transparent"] = true
	E.db["unitframe"]["units"]["target"]["combobar"]["autoHide"] = true
	E.db["unitframe"]["units"]["target"]["combobar"]["fill"] = "spaced"
	E.db["unitframe"]["units"]["target"]["combobar"]["height"] = 10
	E.db["unitframe"]["units"]["target"]["combobar"]["detachedWidth"] = 135
	E.db["unitframe"]["units"]["target"]["combobar"]["detachFromFrame"] = true
	
	if IsAddOnLoaded ("ElvUI_BenikUI") then
		E.db['benikui']['unitframes']['target']['detachPortrait'] = true
		E.db['benikui']['unitframes']['target']['portraitWidth'] = 92
		E.db['benikui']['unitframes']['target']['portraitHeight'] = 39
		E.db['benikui']['unitframes']['target']['portraitShadow'] = false
		E.db['benikui']['unitframes']['target']['portraitTransparent'] = true
		E.db['benikui']['unitframes']['target']['portraitStyle'] = true
		E.db['benikui']['unitframes']['target']['portraitStyleHeight'] = 4
	end
	E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,176,141"
	E.db["movers"]["TargetPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,176,179"
	E.db["movers"]["TargetPortraitMover"] = "BOTTOM,ElvUIParent,BOTTOM,313,141"
	E.db["movers"]["ComboBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,196"
	
	-- TargetTarget
	E.db["unitframe"]["units"]["targettarget"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["targettarget"]["power"]["enable"] = true
	E.db["unitframe"]["units"]["targettarget"]["power"]["position"] = "CENTER"
	E.db["unitframe"]["units"]["targettarget"]["power"]["height"] = 4
	E.db["unitframe"]["units"]["targettarget"]["width"] = 100
	E.db["unitframe"]["units"]["targettarget"]["name"]["yOffset"] = -1
	E.db["unitframe"]["units"]["targettarget"]["height"] = 20
	E.db["unitframe"]["units"]["targettarget"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["targettarget"]["raidicon"]["enable"] = true
	E.db["unitframe"]["units"]["targettarget"]["raidicon"]["position"] = "TOP"
	E.db["unitframe"]["units"]["targettarget"]["raidicon"]["size"] = 18
	E.db["unitframe"]["units"]["targettarget"]["raidicon"]["xOffset"] = 0
	E.db["unitframe"]["units"]["targettarget"]["raidicon"]["yOffset"] = 15
	E.db["unitframe"]["units"]["targettarget"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["targettarget"]["infoPanel"]["enable"] = false
	E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,163"
	
	-- Focus
	E.db["unitframe"]["units"]["focus"]["width"] = 122
	E.db["unitframe"]["units"]["focus"]["height"] = 30
	E.db["unitframe"]["units"]["focus"]["health"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["focus"]["health"]["text_format"] = "[healthcolor][health:current]"
	E.db["unitframe"]["units"]["focus"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["focus"]["health"]["yOffset"] = 0
	E.db["unitframe"]["units"]["focus"]["health"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["focus"]["power"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["focus"]["power"]["height"] = 4
	E.db["unitframe"]["units"]["focus"]["power"]["text_format"] = "[powercolor][power:current]"
	E.db["unitframe"]["units"]["focus"]["power"]["xOffset"] = 0
	E.db["unitframe"]["units"]["focus"]["power"]["yOffset"] = 0
	E.db["unitframe"]["units"]["focus"]["power"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["focus"]["castbar"]["enable"] = true
	E.db["unitframe"]["units"]["focus"]["castbar"]["latency"] = true
	E.db["unitframe"]["units"]["focus"]["castbar"]["insideInfoPanel"] = true
	E.db["unitframe"]["units"]["focus"]["castbar"]["iconSize"] = 20
	E.db["unitframe"]["units"]["focus"]["debuffs"]["anchorPoint"] = "BOTTOMRIGHT"
	E.db["unitframe"]["units"]["focus"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["focus"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["focus"]["infoPanel"]["height"] = 13
	E.db["unitframe"]["units"]["focus"]["infoPanel"]["transparent"] = true
	E.db["movers"]["ElvUF_FocusMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-452,199"
	E.db["movers"]["ElvUF_FocusCastbarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-452,220"
	
	-- FocusTarget
	E.db["unitframe"]["units"]["focustarget"]["enable"] = true
	E.db["unitframe"]["units"]["focustarget"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["focustarget"]["debuffs"]["anchorPoint"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["focustarget"]["threatStyle"] = "GLOW"
	E.db["unitframe"]["units"]["focustarget"]["power"]["enable"] = true
	E.db["unitframe"]["units"]["focustarget"]["power"]["height"] = 4
	E.db["unitframe"]["units"]["focustarget"]["width"] = 122
	E.db["unitframe"]["units"]["focustarget"]["height"] = 20
	E.db["unitframe"]["units"]["focustarget"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["focustarget"]["infoPanel"]["enable"] = false
	E.db["movers"]["ElvUF_FocusTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-452,234"
	
	-- Raid
	E.db["unitframe"]["units"]["raid"]["height"] = 35
	E.db["unitframe"]["units"]["raid"]["width"] = 69
	E.db["unitframe"]["units"]["raid"]["threatStyle"] = "GLOW"
	E.db["unitframe"]["units"]["raid"]["orientation"] = "MIDDLE"
	E.db["unitframe"]["units"]["raid"]["horizontalSpacing"] = 1
	E.db["unitframe"]["units"]["raid"]["verticalSpacing"] = 10
	E.db["unitframe"]["units"]["raid"]["debuffs"]["fontSize"] = 12
	E.db["unitframe"]["units"]["raid"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["raid"]["debuffs"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["debuffs"]["yOffset"] = -10
	E.db["unitframe"]["units"]["raid"]["debuffs"]["anchorPoint"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["raid"]["debuffs"]["sizeOverride"] = 20
	E.db["unitframe"]["units"]["raid"]["rdebuffs"]["enable"] = false
	E.db["unitframe"]["units"]["raid"]["rdebuffs"]["font"] = "Merathilis Prototype"
	E.db["unitframe"]["units"]["raid"]["rdebuffs"]["fontSize"] = 10
	E.db["unitframe"]["units"]["raid"]["rdebuffs"]["size"] = 20
	E.db["unitframe"]["units"]["raid"]["numGroups"] = 4
	E.db["unitframe"]["units"]["raid"]["growthDirection"] = "RIGHT_UP"
	E.db["unitframe"]["units"]["raid"]["colorOverride"] = "USE_DEFAULT"
	E.db["unitframe"]["units"]["raid"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["raid"]["name"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["name"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["name"]["text_format"] = "[namecolor][name:short]"
	E.db["unitframe"]["units"]["raid"]["name"]["position"] = "CENTER"
	E.db["unitframe"]["units"]["raid"]["name"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["raid"]["buffIndicator"]["fontSize"] = 11
	E.db["unitframe"]["units"]["raid"]["buffIndicator"]["size"] = 10
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["size"] = 10
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["position"] = "BOTTOMRIGHT"
	E.db["unitframe"]["units"]["raid"]["power"]["enable"] = true
	E.db["unitframe"]["units"]["raid"]["power"]["height"] = 4
	E.db["unitframe"]["units"]["raid"]["healPrediction"] = true
	E.db["unitframe"]["units"]["raid"]["groupBy"] = "ROLE"
	E.db["unitframe"]["units"]["raid"]["health"]["frequentUpdates"] = true
	E.db["unitframe"]["units"]["raid"]["health"]["position"] = "CENTER"
	E.db["unitframe"]["units"]["raid"]["health"]["text_format"] = "[healthcolor][health:deficit]"
	E.db["unitframe"]["units"]["raid"]["health"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["raid"]["buffs"]["enable"] = true
	E.db["unitframe"]["units"]["raid"]["buffs"]["yOffset"] = 5
	E.db["unitframe"]["units"]["raid"]["buffs"]["anchorPoint"] = "CENTER"
	E.db["unitframe"]["units"]["raid"]["buffs"]["clickTrough"] = false
	E.db["unitframe"]["units"]["raid"]["buffs"]["useBlacklist"] = false
	E.db["unitframe"]["units"]["raid"]["buffs"]["noDuration"] = false
	E.db["unitframe"]["units"]["raid"]["buffs"]["playerOnly"] = false
	E.db["unitframe"]["units"]["raid"]["buffs"]["perrow"] = 1
	E.db["unitframe"]["units"]["raid"]["buffs"]["useFilter"] = "TurtleBuffs"
	E.db["unitframe"]["units"]["raid"]["buffs"]["noConsolidated"] = false
	E.db["unitframe"]["units"]["raid"]["buffs"]["sizeOverride"] = 20
	E.db["unitframe"]["units"]["raid"]["buffs"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["raidicon"]["attachTo"] = "CENTER"
	E.db["unitframe"]["units"]["raid"]["raidicon"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["raidicon"]["yOffset"] = 5
	E.db["unitframe"]["units"]["raid"]["raidicon"]["size"] = 15
	E.db["unitframe"]["units"]["raid"]["raidicon"]["yOffset"] = 0
	if not E.db["unitframe"]["units"]["raid"]["customTexts"] then E.db["unitframe"]["units"]["raid"]["customTexts"] = {} end
	E.db["unitframe"]["units"]["raid"]["customTexts"] = {}
	E.db["unitframe"]["units"]["raid"]["customTexts"]["Status"] = {}
	E.db["unitframe"]["units"]["raid"]["customTexts"]["Status"]["font"] = "Merathilis Tukui"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["Status"]["justifyH"] = "CENTER"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["Status"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["Status"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["customTexts"]["Status"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["customTexts"]["Status"]["size"] = 12
	E.db["unitframe"]["units"]["raid"]["customTexts"]["Status"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["Status"]["text_format"] = "[namecolor][statustimer]"
	E.db["unitframe"]["units"]["raid"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["raid"]["infoPanel"]["height"] = 13
	E.db["unitframe"]["units"]["raid"]["infoPanel"]["transparent"] = true
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["enable"] = true
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["damager"] = true
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["tank"] = true
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["heal"] = true
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["attachTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["size"] = 10
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["position"] = "RIGHT"
	if IsAddOnLoaded("ElvUI_BenikUI") then
		E.db["unitframe"]["units"]["raid"]["classHover"] = true
	end
	E.db["movers"]["ElvUF_RaidMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,2,185"
	
	-- Raid40
	E.db["unitframe"]["units"]["raid40"]["horizontalSpacing"] = 1
	E.db["unitframe"]["units"]["raid40"]["debuffs"]["sizeOverride"] = 21
	E.db["unitframe"]["units"]["raid40"]["debuffs"]["useBlacklist"] = false
	E.db["unitframe"]["units"]["raid40"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["raid40"]["debuffs"]["yOffset"] = -9
	E.db["unitframe"]["units"]["raid40"]["debuffs"]["anchorPoint"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["raid40"]["debuffs"]["clickTrough"] = true
	E.db["unitframe"]["units"]["raid40"]["debuffs"]["useFilter"] = "Whitlist (Strict)"
	E.db["unitframe"]["units"]["raid40"]["debuffs"]["xOffset"] = -4
	E.db["unitframe"]["units"]["raid40"]["debuffs"]["perrow"] = 2
	E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["font"] = "Merathilis Prototype"
	E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["size"] = 26
	E.db["unitframe"]["units"]["raid40"]["growthDirection"] = "RIGHT_UP"
	E.db["unitframe"]["units"]["raid40"]["groupBy"] = "ROLE"
	E.db["unitframe"]["units"]["raid40"]["classHover"] = true
	E.db["unitframe"]["units"]["raid40"]["orientation"] = "MIDDLE"
	E.db["unitframe"]["units"]["raid40"]["roleIcon"]["enable"] = true
	E.db["unitframe"]["units"]["raid40"]["roleIcon"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["raid40"]["roleIcon"]["attachTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["raid40"]["roleIcon"]["damager"] = true
	E.db["unitframe"]["units"]["raid40"]["roleIcon"]["tank"] = true
	E.db["unitframe"]["units"]["raid40"]["roleIcon"]["heal"] = true
	E.db["unitframe"]["units"]["raid40"]["roleIcon"]["size"] = 9
	E.db["unitframe"]["units"]["raid40"]["roleIcon"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid40"]["roleIcon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid40"]["raidWideSorting"] = false
	E.db["unitframe"]["units"]["raid40"]["healPrediction"] = true
	E.db["unitframe"]["units"]["raid40"]["health"]["frequentUpdates"] = true
	E.db["unitframe"]["units"]["raid40"]["width"] = 69
	E.db["unitframe"]["units"]["raid40"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["raid40"]["infoPanel"]["transparent"] = true
	E.db["unitframe"]["units"]["raid40"]["verticalSpacing"] = 1
	E.db["unitframe"]["units"]["raid40"]["name"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["raid40"]["positionOverride"] = "BOTTOMRIGHT"
	E.db["unitframe"]["units"]["raid40"]["height"] = 35
	E.db["unitframe"]["units"]["raid40"]["buffs"]["noConsolidated"] = false
	E.db["unitframe"]["units"]["raid40"]["buffs"]["sizeOverride"] = 17
	E.db["unitframe"]["units"]["raid40"]["buffs"]["useBlacklist"] = false
	E.db["unitframe"]["units"]["raid40"]["buffs"]["noDuration"] = false
	E.db["unitframe"]["units"]["raid40"]["buffs"]["playerOnly"] = false
	E.db["unitframe"]["units"]["raid40"]["buffs"]["perrow"] = 1
	E.db["unitframe"]["units"]["raid40"]["buffs"]["anchorPoint"] = "CENTER"
	E.db["unitframe"]["units"]["raid40"]["buffs"]["clickTrough"] = true
	E.db["unitframe"]["units"]["raid40"]["buffs"]["useFilter"] = "TurtleBuffs"
	E.db["unitframe"]["units"]["raid40"]["buffs"]["enable"] = true
	E.db["unitframe"]["units"]["raid40"]["power"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["raid40"]["power"]["height"] = 3
	E.db["unitframe"]["units"]["raid40"]["power"]["enable"] = true
	E.db["unitframe"]["units"]["raid40"]["power"]["position"] = "CENTER"
	E.db["unitframe"]["units"]["raid40"]["raidicon"]["attachTo"] = "LEFT"
	E.db["unitframe"]["units"]["raid40"]["raidicon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid40"]["raidicon"]["xOffset"] = 9
	E.db["unitframe"]["units"]["raid40"]["raidicon"]["size"] = 13
	E.db["movers"]["ElvUF_Raid40Mover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,2,185"
	
	-- Party
	E.db["unitframe"]["units"]["party"]["height"] = 40
	E.db["unitframe"]["units"]["party"]["width"] = 180
	E.db["unitframe"]["units"]["party"]["growthDirection"] = "UP_RIGHT"
	E.db["unitframe"]["units"]["party"]["healPrediction"] = true
	E.db["unitframe"]["units"]["party"]["colorOverride"] = "USE_DEFAULT"
	E.db["unitframe"]["units"]["party"]["debuffs"]["anchorPoint"] = "RIGHT"
	E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 24
	E.db["unitframe"]["units"]["party"]["debuffs"]["xOffset"] = 1
	E.db["unitframe"]["units"]["party"]["debuffs"]["yOffset"] = 8
	E.db["unitframe"]["units"]["party"]["debuffs"]["numrows"] = 2
	E.db["unitframe"]["units"]["party"]["debuffs"]["perrow"] = 5
	E.db["unitframe"]["units"]["party"]["debuffs"]["fontSize"] = 12
	E.db["unitframe"]["units"]["party"]["showPlayer"] = true
	E.db["unitframe"]["units"]["party"]["GPSArrow"]["size"] = 40
	E.db["unitframe"]["units"]["party"]["health"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["party"]["health"]["text_format"] = "[healthcolor][health:current] - [namecolor][power:current]"
	E.db["unitframe"]["units"]["party"]["health"]["xOffset"] = 2
	E.db["unitframe"]["units"]["party"]["health"]["yOffset"] = 0
	E.db["unitframe"]["units"]["party"]["health"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["party"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["party"]["roleIcon"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["roleIcon"]["tank"] = true
	E.db["unitframe"]["units"]["party"]["roleIcon"]["healer"] = true
	E.db["unitframe"]["units"]["party"]["roleIcon"]["damager"] = true
	E.db["unitframe"]["units"]["party"]["roleIcon"]["position"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["party"]["roleIcon"]["attachTo"] = "Frame"
	E.db["unitframe"]["units"]["party"]["roleIcon"]["size"] = 12
	E.db["unitframe"]["units"]["party"]["roleIcon"]["xOffset"] = 0
	E.db["unitframe"]["units"]["party"]["roleIcon"]["yOffset"] = -2
	E.db["unitframe"]["units"]["party"]["raidRoleIcons"]["position"] = "TOPRIGHT"
	if not E.db["unitframe"]["units"]["party"]["customTexts"] then E.db["unitframe"]["units"]["party"]["customTexts"] = {} end
	E.db["unitframe"]["units"]["party"]["customTexts"] = {}
	E.db["unitframe"]["units"]["party"]["customTexts"]["HealthText"] = {}
	E.db["unitframe"]["units"]["party"]["customTexts"]["HealthText"]["font"] = "Merathilis Tukui"
	E.db["unitframe"]["units"]["party"]["customTexts"]["HealthText"]["justifyH"] = "CENTER"
	E.db["unitframe"]["units"]["party"]["customTexts"]["HealthText"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["HealthText"]["xOffset"] = 0
	E.db["unitframe"]["units"]["party"]["customTexts"]["HealthText"]["yOffset"] = 0
	E.db["unitframe"]["units"]["party"]["customTexts"]["HealthText"]["text_format"] = "[healthcolor][health:deficit]"
	E.db["unitframe"]["units"]["party"]["customTexts"]["HealthText"]["size"] = 10
	E.db["unitframe"]["units"]["party"]["customTexts"]["HealthText"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["party"]["customTexts"]["LevelClass"] = {}
	E.db["unitframe"]["units"]["party"]["customTexts"]["LevelClass"]["font"] = "Merathilis Tukui"
	E.db["unitframe"]["units"]["party"]["customTexts"]["LevelClass"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["party"]["customTexts"]["LevelClass"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["LevelClass"]["xOffset"] = 0
	E.db["unitframe"]["units"]["party"]["customTexts"]["LevelClass"]["yOffset"] = 0
	E.db["unitframe"]["units"]["party"]["customTexts"]["LevelClass"]["text_format"] = "[namecolor][smartclass] [difficultycolor][level]"
	E.db["unitframe"]["units"]["party"]["customTexts"]["LevelClass"]["size"] = 12
	E.db["unitframe"]["units"]["party"]["customTexts"]["LevelClass"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["party"]["customTexts"]["BigName"] = {}
	E.db["unitframe"]["units"]["party"]["customTexts"]["BigName"]["font"] = 'Merathilis Tukui'
	E.db["unitframe"]["units"]["party"]["customTexts"]["BigName"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["party"]["customTexts"]["BigName"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["BigName"]["xOffset"] = 0
	E.db["unitframe"]["units"]["party"]["customTexts"]["BigName"]["yOffset"] = 0
	E.db["unitframe"]["units"]["party"]["customTexts"]["BigName"]["text_format"] = "[name:medium] [difficultycolor][smartlevel] [shortclassification]"
	E.db["unitframe"]["units"]["party"]["customTexts"]["BigName"]["size"] = 20
	E.db["unitframe"]["units"]["party"]["customTexts"]["BigName"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["party"]["threatStyle"] = "INFOPANELBORDER"
	E.db["unitframe"]["units"]["party"]["verticalSpacing"] = 15
	E.db["unitframe"]["units"]["party"]["horizontalSpacing"] = 0
	E.db["unitframe"]["units"]["party"]["raidicon"]["attachTo"] = "TOP"
	E.db["unitframe"]["units"]["party"]["raidicon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["party"]["raidicon"]["xOffset"] = 0
	E.db["unitframe"]["units"]["party"]["raidicon"]["size"] = 15
	E.db["unitframe"]["units"]["party"]["raidicon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["party"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["party"]["power"]["height"] = 4
	E.db["unitframe"]["units"]["party"]["power"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["party"]["power"]["yOffset"] = 0
	E.db["unitframe"]["units"]["party"]["buffs"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["buffs"]["yOffset"] = 6
	E.db["unitframe"]["units"]["party"]["buffs"]["xOffset"] = 25
	E.db["unitframe"]["units"]["party"]["buffs"]["anchorPoint"] = "CENTER"
	E.db["unitframe"]["units"]["party"]["buffs"]["attachTo"] = "Frame"
	E.db["unitframe"]["units"]["party"]["buffs"]["clickTrough"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["useBlacklist"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["noDuration"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["playerOnly"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["perrow"] = 1
	E.db["unitframe"]["units"]["party"]["buffs"]["useFilter"] = "TurtleBuffs"
	E.db["unitframe"]["units"]["party"]["buffs"]["noConsolidated"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["sizeOverride"] = 22
	E.db["unitframe"]["units"]["party"]["portrait"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["portrait"]["overlay"] = false
	E.db["unitframe"]["units"]["party"]["portrait"]["width"] = 40
	E.db["unitframe"]["units"]["party"]["portrait"]["height"] = 0
	E.db["unitframe"]["units"]["party"]["portrait"]["camDistanceScale"] = 1.2
	E.db["unitframe"]["units"]["party"]["portrait"]["style"] = "3D"
	E.db["unitframe"]["units"]["party"]["portrait"]["transparent"] = true
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["infoPanel"]["height"] = 13
	E.db["unitframe"]["units"]["party"]["infoPanel"]["transparent"] = true
	E.db["movers"]["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,2,200"
	
	-- Assist
	E.db["unitframe"]["units"]["assist"]["enable"] = false
	E.db["movers"]["ElvUF_AssistMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,2,571"
	
	-- Tank
	E.db["unitframe"]["units"]["tank"]["enable"] = false
	E.db["movers"]["ElvUF_TankMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,2,626"
	
	-- Pet
	E.db["unitframe"]["units"]["pet"]["castbar"]["enable"] = true
	E.db["unitframe"]["units"]["pet"]["castbar"]["latency"] = true
	E.db["unitframe"]["units"]["pet"]["castbar"]["insideInfoPanel"] = true
	E.db["unitframe"]["units"]["pet"]["debuffs"]["fontSize"] = 10
	E.db["unitframe"]["units"]["pet"]["debuffs"]["attachTo"] = "FRAME"
	E.db["unitframe"]["units"]["pet"]["debuffs"]["sizeOverride"] = 0
	E.db["unitframe"]["units"]["pet"]["debuffs"]["xOffset"] = 0
	E.db["unitframe"]["units"]["pet"]["debuffs"]["yOffset"] = 0
	E.db["unitframe"]["units"]["pet"]["debuffs"]["perrow"] = 5
	E.db["unitframe"]["units"]["pet"]["debuffs"]["anchorPoint"] = "TOPLEFT"
	E.db["unitframe"]["units"]["pet"]["health"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["pet"]["health"]["text_format"] = "[healthcolor][health:current]"
	E.db["unitframe"]["units"]["pet"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["pet"]["health"]["yOffset"] = 0
	E.db["unitframe"]["units"]["pet"]["health"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["pet"]["power"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["pet"]["power"]["height"] = 4
	E.db["unitframe"]["units"]["pet"]["power"]["text_format"] = "[namecolor][power:current]"
	E.db["unitframe"]["units"]["pet"]["power"]["xOffset"] = 0
	E.db["unitframe"]["units"]["pet"]["power"]["yOffset"] = 0
	E.db["unitframe"]["units"]["pet"]["power"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["pet"]["width"] = 90
	E.db["unitframe"]["units"]["pet"]["height"] = 40
	E.db["unitframe"]["units"]["pet"]["power"]["height"] = 4
	E.db["unitframe"]["units"]["pet"]["portrait"]["enable"] = true
	E.db["unitframe"]["units"]["pet"]["portrait"]["overlay"] = true
	E.db["unitframe"]["units"]["pet"]["orientation"] = "MIDDLE"
	E.db["unitframe"]["units"]["pet"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["pet"]["infoPanel"]["height"] = 13
	E.db["unitframe"]["units"]["pet"]["infoPanel"]["transparent"] = true
	E.db["movers"]["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,498,141"
	
	-- Arena
	E.db["unitframe"]["units"]["arena"]["power"]["width"] = "inset"
	E.db["movers"]["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-150,-305"
	
	-- Boss
	E.db["unitframe"]["units"]["boss"]["castbar"]["latency"] = true
	E.db["unitframe"]["units"]["boss"]["castbar"]["width"] = 155
	E.db["unitframe"]["units"]["boss"]["castbar"]["height"] = 16
	E.db["unitframe"]["units"]["boss"]["castbar"]["insideInfoPanel"] = true
	E.db["unitframe"]["units"]["boss"]["castbar"]["iconSize"] = 26
	E.db["unitframe"]["units"]["boss"]["buffs"]["sizeOverride"] = 26
	E.db["unitframe"]["units"]["boss"]["buffs"]["yOffset"] = 7
	E.db["unitframe"]["units"]["boss"]["buffs"]["xOffset"] = -2
	E.db["unitframe"]["units"]["boss"]["buffs"]["anchorPoint"] = "LEFT"
	E.db["unitframe"]["units"]["boss"]["buffs"]["attachTo"] = "Frame"
	E.db["unitframe"]["units"]["boss"]["debuffs"]["anchorPoint"] = "RIGHT"
	E.db["unitframe"]["units"]["boss"]["debuffs"]["yOffset"] = 10
	E.db["unitframe"]["units"]["boss"]["debuffs"]["xOffset"] = 2
	E.db["unitframe"]["units"]["boss"]["debuffs"]["perrow"] = 5
	E.db["unitframe"]["units"]["boss"]["debuffs"]["attachTo"] = "Frame"
	E.db["unitframe"]["units"]["boss"]["portrait"]["enable"] = true
	E.db["unitframe"]["units"]["boss"]["portrait"]["overlay"] = false
	E.db["unitframe"]["units"]["boss"]["power"]["enable"] = true
	E.db["unitframe"]["units"]["boss"]["power"]["height"] = 4
	E.db["unitframe"]["units"]["boss"]["power"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["boss"]["name"]["xOffset"] = 6
	E.db["unitframe"]["units"]["boss"]["name"]["yOffset"] = 16
	E.db["unitframe"]["units"]["boss"]["name"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["boss"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["boss"]["width"] = 156
	E.db["unitframe"]["units"]["boss"]["height"] = 40
	E.db["unitframe"]["units"]["boss"]["spacing"] = 27
	E.db["unitframe"]["units"]["boss"]["growthDirection"] = "UP"
	E.db["unitframe"]["units"]["boss"]["threatStyle"] = "HEALTHBORDER"
	E.db["unitframe"]["units"]["boss"]["infoPanel"]["enable"] = true
	E.db["unitframe"]["units"]["boss"]["infoPanel"]["height"] = 13
	E.db["unitframe"]["units"]["boss"]["infoPanel"]["transparent"] = true
	E.db["unitframe"]["units"]["boss"]["health"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["boss"]["health"]["text_format"] = "[healthcolor][health:current] - [namecolor][power:current]"
	E.db["unitframe"]["units"]["boss"]["health"]["attachTextTo"] = "InfoPanel"
	if not E.db["unitframe"]["units"]["boss"]["customTexts"] then E.db["unitframe"]["units"]["boss"]["customTexts"] = {} end
	E.db["unitframe"]["units"]["boss"]["customTexts"]["BigName"] = {}
	E.db["unitframe"]["units"]["boss"]["customTexts"]["BigName"]["font"] = "Merathilis Tukui"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["BigName"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["BigName"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["BigName"]["xOffset"] = 0
	E.db["unitframe"]["units"]["boss"]["customTexts"]["BigName"]["yOffset"] = 0
	E.db["unitframe"]["units"]["boss"]["customTexts"]["BigName"]["text_format"] = "[name:medium] [difficultycolor][smartlevel] [shortclassification]"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["BigName"]["size"] = 16
	E.db["unitframe"]["units"]["boss"]["customTexts"]["BigName"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Class"] = {}
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Class"]["font"] = "Merathilis Tukui"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Class"]["size"] = 12
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Class"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Class"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Class"]["text_format"] = "[namecolor][smartclass] [difficultycolor][level]"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Class"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Percent"] = {}
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Percent"]["font"] = "Merathilis Tukui"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Percent"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Percent"]["size"] = 16
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Percent"]["justifyH"] = "RIGHT"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Percent"]["text_format"] = "[namecolor][health:percent_short]"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["Percent"]["attachTextTo"] = "Health"
	E.db["movers"]["BossHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-230,-404"
	
	-- Bodyguard
	E.db["movers"]["ElvUF_BodyGuardMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-452,167"
	
	-- PetTarget
	E.db["unitframe"]["units"]["pettarget"]["enable"] = false
	
	-- RaidPet
	E.db["unitframe"]["units"]["raidpet"]["enable"] = false
	E.db["movers"]["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,0,808"

	if InstallStepComplete then
		InstallStepComplete.message = MER.Title..L['Unitframes Set']
		InstallStepComplete:Show()
		titleText[6].check:Show()
	end
	E:UpdateAll(true)
end

function MER:SetupDts(role)
	-- Data Texts
	E.db["datatexts"]["font"] = "Merathilis Roadway"
	E.db["datatexts"]["fontSize"] = 13
	E.db["datatexts"]["fontOutline"] = "OUTLINE"
	E.db["datatexts"]["time24"] = true
	E.db["datatexts"]["goldCoins"] = true
	E.db["datatexts"]["noCombatHover"] = true
	E.db["datatexts"]["panelTransparency"] = true
	E.db["datatexts"]["wordWrap"] = true

	if IsAddOnLoaded('ElvUI_BenikUI') then
		E.db["datatexts"]["leftChatPanel"] = false
		E.db["datatexts"]["rightChatPanel"] = false
		E.db["datatexts"]["minimapPanels"] = true
		E.db["datatexts"]["actionbar3"] = false
		E.db["datatexts"]["actionbar5"] = false
	else
		E.db["datatexts"]["leftChatPanel"] = true
		E.db["datatexts"]["rightChatPanel"] = true
		E.db["datatexts"]["minimapPanels"] = true
		E.db["datatexts"]["actionbar3"] = true
		E.db["datatexts"]["actionbar5"] = true
	end

	if IsAddOnLoaded('ElvUI_SLE') then
		E.db["datatexts"]["panels"]["LeftMiniPanel"] = "S&L Guild"
		E.db["datatexts"]["panels"]["RightMiniPanel"] = "S&L Friends"
	else
		E.db["datatexts"]["panels"]["LeftMiniPanel"] = "Guild"
		E.db["datatexts"]["panels"]["RightMiniPanel"] = "Friends"
	end

	if IsAddOnLoaded('ElvUI_BenikUI') then
		-- define BenikUI Datetexts
		if role == 'tank' then
			E.db["datatexts"]["panels"]["BuiLeftChatDTPanel"]["right"] = "Attack Power"
		elseif role == 'dpsMelee' then
			E.db["datatexts"]["panels"]["BuiLeftChatDTPanel"]["right"] = "Attack Power"
		elseif role == 'healer' or 'dpsCaster' then
			E.db["datatexts"]["panels"]["BuiLeftChatDTPanel"]["right"] = "Spell/Heal Power"
		end
		E.db["datatexts"]["panels"]["BuiLeftChatDTPanel"]["left"] = "MUI Talent/Loot Specialization"
		E.db["datatexts"]["panels"]["BuiLeftChatDTPanel"]["middle"] = "Durability"
		E.db["datatexts"]["panels"]["BuiRightChatDTPanel"]["middle"] = "Garrison+ (BenikUI)"
		E.db["datatexts"]["panels"]["BuiRightChatDTPanel"]["right"] = "BuiMail"
		
		if IsAddOnLoaded('Skada') then
			E.db["datatexts"]["panels"]["BuiRightChatDTPanel"]["left"] = "Skada"
		else
			E.db["datatexts"]["panels"]["BuiRightChatDTPanel"]["left"] = "Bags"
		end
		
		if IsAddOnLoaded('ElvUI_SLE') then
			E.db["datatexts"]["panels"]["BuiMiddleDTPanel"]["right"] = "S&L Currency"
		else
			E.db["datatexts"]["panels"]["BuiMiddleDTPanel"]["right"] = "Gold"
		end
		
		E.db["datatexts"]["panels"]["BuiMiddleDTPanel"]["left"] = "MUI System"
		E.db["datatexts"]["panels"]["BuiMiddleDTPanel"]["middle"] = "Time"
		
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["middle"] = ""
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["right"] = ""
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["left"] = ""
		
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["left"] = ""
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["middle"] = ""
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["right"] = ""
	else
		-- define the default ElvUI datatexts
		if role == 'tank' then
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["right"] = "Attack Power"
		elseif role == 'dpsMelee' then
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["right"] = "Attack Power"
		elseif role == 'healer' or 'dpsCaster' then
			E.db["datatexts"]["panels"]["LeftChatDataPanel"]["right"] = "Spell/Heal Power"
		end
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["left"] = "MUI Talent/Loot Specialization"
		E.db["datatexts"]["panels"]["LeftChatDataPanel"]["middle"] = "Durability"
		
		if IsAddOnLoaded('Skada') then
			E.db["datatexts"]["panels"]["RightChatDataPanel"]["left"] = "Skada"
		else
			E.db["datatexts"]["panels"]["RightChatDataPanel"]["left"] = "MUI System"
		end
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["middle"] = "Time"
		E.db["datatexts"]["panels"]["RightChatDataPanel"]["right"] = "Gold"
	end

	if InstallStepComplete then
		InstallStepComplete.message = MER.Title..L['DataTexts Set']
		InstallStepComplete:Show()
		titleText[4].check:Show()
	end
	E:UpdateAll(true)
end

local function SetupMERAddons()
	if InstallStepComplete then
		InstallStepComplete.message = MER.Title..L['Addons Set']
		InstallStepComplete:Show()
		titleText[7].check:Show()
	end
	E:UpdateAll(true)
end

local function ResetAll()
	InstallNextButton:Disable()
	InstallPrevButton:Disable()
	InstallOption1Button:Hide()
	InstallOption1Button:SetScript('OnClick', nil)
	InstallOption1Button:SetText('')
	InstallOption2Button:Hide()
	InstallOption2Button:SetScript('OnClick', nil)
	InstallOption2Button:SetText('')
	InstallOption3Button:Hide()
	InstallOption3Button:SetScript('OnClick', nil)
	InstallOption3Button:SetText('')
	InstallOption4Button:Hide()
	InstallOption4Button:SetScript('OnClick', nil)
	InstallOption4Button:SetText('')
	MERInstallFrame.SubTitle:SetText('')
	MERInstallFrame.Desc1:SetText('')
	MERInstallFrame.Desc2:SetText('')
	MERInstallFrame.Desc3:SetText('')
	MERInstallFrame.Desc4:SetText('')
	MERInstallFrame:Size(500, 400)
	MERTitleFrame:Size(180, 400)
end

local function InstallComplete()
	E.private.install_complete = E.version
	E.db.mui.installed = true
	
	ReloadUI()
end

local function SetPage(PageNum)
	CURRENT_PAGE = PageNum
	ResetAll()
	
	InstallStatus.anim.progress:SetChange(PageNum)
	InstallStatus.anim.progress:Play()
	
	local f = MERInstallFrame
	
	if PageNum == MAX_PAGE then
		InstallNextButton:Disable()
	else
		InstallNextButton:Enable()
	end
	
	if PageNum == 1 then
		InstallPrevButton:Disable()
	else
		InstallPrevButton:Enable()
	end
	
	if PageNum == 1 then
		f.SubTitle:SetFormattedText(L['Welcome to MerathilisUI |cff00c0faVersion|r %s, for ElvUI %s.'], MER.Version, E.version)
		f.Desc1:SetFormattedText("%s", L["By pressing the Continue button, MerathilisUI will be applied in your current ElvUI installation.\r|cffff8000 TIP: It would be nice if you apply the changes in a new profile, just in case you don't like the result.|r"])
		f.Desc2:SetFormattedText("%s", L['Please press the continue button to go onto the next step.'])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', InstallComplete)
		InstallOption1Button:SetText(L['Skip Process'])
	elseif PageNum == 2 then
		f.SubTitle:SetText(L['Layout'])
		f.Desc1:SetFormattedText("%s", L['This part of the installation changes the default ElvUI look.'])
		f.Desc2:SetFormattedText("%s", L['Please click the button below to apply the new layout.'])
		f.Desc3:SetFormattedText("%s", L['Importance: |cff07D400High|r'])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', function() SetupMERLayout('Layout') end)
		InstallOption1Button:SetFormattedText("%s", L['Layout'])
	elseif PageNum == 3 then
		f.SubTitle:SetFormattedText("%s", L['Chat'])
		f.Desc1:SetFormattedText("%s", L['This part of the installation process sets up your chat fonts and colors.'])
		f.Desc2:SetFormattedText("%s", L['Please click the button below to setup your chat windows.'])
		f.Desc3:SetFormattedText("%s", L['Importance: |cffD3CF00Medium|r'])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', SetupMERChat)
		InstallOption1Button:SetFormattedText("%s", L['Setup Chat'])
	elseif PageNum == 4 then
		f.SubTitle:SetFormattedText("%s", L['DataTexts'])
		f.Desc1:SetFormattedText("%s", L["This part of the installation process will fill MerathilisUI datatexts.\r|cffff8000This doesn't touch ElvUI datatexts|r"])
		f.Desc2:SetFormattedText("%s", L['Please click the button below to setup your datatexts.'])
		f.Desc3:SetFormattedText("%s", L['Importance: |cffD3CF00Medium|r'])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', function() MER:SetupDts('tank') end)
		InstallOption1Button:SetFormattedText("%s", _G["TANK"])
		InstallOption2Button:Show()
		InstallOption2Button:SetScript('OnClick', function() MER:SetupDts('healer') end)
		InstallOption2Button:SetFormattedText("%s", _G["HEALER"])
		InstallOption3Button:Show()
		InstallOption3Button:SetScript('OnClick', function() MER:SetupDts('dpsMelee') end)
		InstallOption3Button:SetFormattedText("%s", L['Physical DPS'])
		InstallOption4Button:Show()
		InstallOption4Button:SetScript('OnClick', function() MER:SetupDts('dpsCaster') end)
		InstallOption4Button:SetFormattedText("%s", L['Caster DPS'])
	elseif PageNum == 5 then
		f.SubTitle:SetText(L['ActionBars'])
		f.Desc1:SetFormattedText("%s", L['This part of the installation process will reposition your Actionbars and will enable backdrops'])
		f.Desc2:SetFormattedText("%s", L['Please click the button below to setup your actionbars.'])
		f.Desc3:SetFormattedText("%s", L['Importance: |cff07D400High|r'])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', function() SetupMERActionbars('small') end)
		InstallOption1Button:SetFormattedText("%s", L['Setup ActionBars'].." - 1")
		InstallOption2Button:Show()
		InstallOption2Button:SetScript('OnClick', function() SetupMERActionbars('big') end)
		InstallOption2Button:SetFormattedText("%s", L['Setup ActionBars'].." - 2")
	elseif PageNum == 6 then
		f.SubTitle:SetFormattedText("%s", L['UnitFrames'])
		f.Desc1:SetFormattedText("%s", L['This part of the installation process will reposition your Unitframes.'])
		f.Desc2:SetFormattedText("%s", L['Please click the button below to setup your Unitframes.'])
		f.Desc3:SetFormattedText("%s", L['Importance: |cff07D400High|r'])
		f.Desc4:SetFormattedText("%s", L['Buttons must be clicked twice'])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', function() SetupUnitframes() end)
		InstallOption1Button:SetFormattedText("%s", L['Setup Unitframes'])
	elseif PageNum == 7 then
		f.SubTitle:SetFormattedText("%s", ADDONS)
		f.Desc1:SetFormattedText("%s", L['This part of the installation process will apply changes to Skada and ElvUI plugins'])
		f.Desc2:SetFormattedText("%s", L['Please click the button below to setup your addons.'])
		f.Desc3:SetFormattedText("%s", L['Importance: |cffD3CF00Medium|r'])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', function() MER:SetupMERAddons(); SetupMERAddons(); end)
		InstallOption1Button:SetFormattedText("%s", L['Setup Addons'])
	elseif PageNum == 8 then
		f.SubTitle:SetFormattedText("%s", L['Installation Complete'])
		f.Desc1:SetFormattedText("%s", L['You are now finished with the installation process. If you are in need of technical support please visit us at http://www.tukui.org.'])
		f.Desc2:SetFormattedText("%s", L['Please click the button below so you can setup variables and ReloadUI.'])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', InstallComplete)
		InstallOption1Button:SetFormattedText("%s", L['Finished'])
		MERInstallFrame:Size(500, 400)
		MERTitleFrame:Size(180, 400)
		if InstallStepComplete then
			InstallStepComplete.message = MER.Title..L['Installed']
			InstallStepComplete:Show()
		end
	end
end

local function NextPage()
	if CURRENT_PAGE ~= MAX_PAGE then
		CURRENT_PAGE = CURRENT_PAGE + 1
		SetPage(CURRENT_PAGE)
		titleText[CURRENT_PAGE].text.anim.color:SetChange(1, 1, 0)
		titleText[CURRENT_PAGE].text.anim:Play()
		E:UIFrameFadeIn(titleText[CURRENT_PAGE].hoverTex, .3, 0, 1)
		if CURRENT_PAGE > 1 then
			E:UIFrameFadeIn(titleText[CURRENT_PAGE - 1].hoverTex, .3, 1, 0)
			titleText[CURRENT_PAGE - 1].text.anim.color:SetChange(unpack(E['media'].rgbvaluecolor))
			titleText[CURRENT_PAGE - 1].text.anim:Play()
		end
	end
end

local function PreviousPage()
	if CURRENT_PAGE ~= 1 then
		E:UIFrameFadeIn(titleText[CURRENT_PAGE].hoverTex, .3, 1, 0)
		titleText[CURRENT_PAGE].text.anim.color:SetChange(unpack(E['media'].rgbvaluecolor))
		titleText[CURRENT_PAGE].text.anim:Play()
		CURRENT_PAGE = CURRENT_PAGE - 1
		SetPage(CURRENT_PAGE)
		E:UIFrameFadeIn(titleText[CURRENT_PAGE].hoverTex, .3, 0, 1)
		titleText[CURRENT_PAGE].text.anim.color:SetChange(1, 1, 0)
		titleText[CURRENT_PAGE].text.anim:Play()
	end
end

function MER:SetupUI()
	if not InstallStepComplete then
		local imsg = CreateFrame('Frame', 'InstallStepComplete', E.UIParent)
		imsg:Size(418, 72)
		imsg:Point('TOP', 0, -190)
		imsg:Hide()
		imsg:SetScript('OnShow', function(self)
			if self.message then 
				PlaySoundFile([[Sound\Interface\LevelUp.ogg]])
				self.text:SetText(self.message)
				UIFrameFadeOut(self, 3.5, 1, 0)
				E:Delay(4, function() self:Hide() end)
				self.message = nil
			else
				self:Hide()
			end
		end)
		
		imsg.firstShow = false
		
		imsg.bg = imsg:CreateTexture(nil, 'BACKGROUND')
		imsg.bg:SetTexture([[Interface\LevelUp\LevelUpTex]])
		imsg.bg:SetPoint('BOTTOM')
		imsg.bg:Size(326, 103)
		imsg.bg:SetTexCoord(0.00195313, 0.63867188, 0.03710938, 0.23828125)
		imsg.bg:SetVertexColor(1, 1, 1, 0.6)
		
		imsg.lineTop = imsg:CreateTexture(nil, 'BACKGROUND')
		imsg.lineTop:SetDrawLayer('BACKGROUND', 2)
		imsg.lineTop:SetTexture([[Interface\LevelUp\LevelUpTex]])
		imsg.lineTop:SetPoint('TOP')
		imsg.lineTop:Size(418, 7)
		imsg.lineTop:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)
		
		imsg.lineBottom = imsg:CreateTexture(nil, 'BACKGROUND')
		imsg.lineBottom:SetDrawLayer('BACKGROUND', 2)
		imsg.lineBottom:SetTexture([[Interface\LevelUp\LevelUpTex]])
		imsg.lineBottom:SetPoint('BOTTOM')
		imsg.lineBottom:Size(418, 7)
		imsg.lineBottom:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)
		
		imsg.text = imsg:CreateFontString(nil, 'ARTWORK')
		imsg.text:FontTemplate(nil, 32)
		imsg.text:Point('CENTER', 0, -4)
		imsg.text:SetTextColor(1, 0.82, 0)
		imsg.text:SetJustifyH('CENTER')
	end
	
	--Create Frame
	if not MERInstallFrame then
		local f = CreateFrame('Button', 'MERInstallFrame', E.UIParent)
		f.SetPage = SetPage
		f:Size(500, 400)
		f:SetTemplate('Transparent')
		f:SetPoint('CENTER', 70, 0)
		f:SetFrameStrata('TOOLTIP')
		
		f.Title = f:CreateFontString(nil, 'OVERLAY')
		f.Title:FontTemplate(nil, 17, nil)
		f.Title:Point('TOP', 0, -5)
		f.Title:SetFormattedText("%s", MER.Title..L['Installation'])
		
		f.Next = CreateFrame('Button', 'InstallNextButton', f, 'UIPanelButtonTemplate')
		f.Next:StripTextures()
		f.Next:SetTemplate('Default', true)
		f.Next:Size(110, 25)
		f.Next:Point('BOTTOMRIGHT', -5, 5)
		f.Next:SetFormattedText("%s", CONTINUE)
		f.Next:Disable()
		f.Next:SetScript('OnClick', NextPage)
		E.Skins:HandleButton(f.Next, true)
		
		f.Prev = CreateFrame('Button', 'InstallPrevButton', f, 'UIPanelButtonTemplate')
		f.Prev:StripTextures()
		f.Prev:SetTemplate('Default', true)
		f.Prev:Size(110, 25)
		f.Prev:Point('BOTTOMLEFT', 5, 5)
		f.Prev:SetFormattedText("%s", PREVIOUS)	
		f.Prev:Disable()
		f.Prev:SetScript('OnClick', PreviousPage)
		E.Skins:HandleButton(f.Prev, true)
		
		f.Status = CreateFrame('StatusBar', 'InstallStatus', f)
		f.Status:SetFrameLevel(f.Status:GetFrameLevel() + 2)
		f.Status:CreateBackdrop('Default')
		f.Status:SetStatusBarTexture(E['media'].normTex)
		f.Status:SetStatusBarColor(unpack(E['media'].rgbvaluecolor))
		f.Status:SetMinMaxValues(0, MAX_PAGE)
		f.Status:Point('TOPLEFT', f.Prev, 'TOPRIGHT', 6, -2)
		f.Status:Point('BOTTOMRIGHT', f.Next, 'BOTTOMLEFT', -6, 2)
		-- Setup StatusBar Animation
		f.Status.anim = CreateAnimationGroup(f.Status)
		f.Status.anim.progress = f.Status.anim:CreateAnimation("Progress")
		f.Status.anim.progress:SetSmoothing("Out")
		f.Status.anim.progress:SetDuration(.3)
		
		f.Status.text = f.Status:CreateFontString(nil, 'OVERLAY')
		f.Status.text:FontTemplate()
		f.Status.text:SetPoint('CENTER')
		f.Status.text:SetFormattedText("%s / %s", CURRENT_PAGE, MAX_PAGE)
		f.Status:SetScript('OnValueChanged', function(self)
			self.text:SetText(ceil(self:GetValue())..' / '..MAX_PAGE)
		end)
		
		f.Option1 = CreateFrame('Button', 'InstallOption1Button', f, 'UIPanelButtonTemplate')
		f.Option1:StripTextures()
		f.Option1:Size(160, 30)
		f.Option1:Point('BOTTOM', 0, 45)
		f.Option1:SetText('')
		f.Option1:Hide()
		E.Skins:HandleButton(f.Option1, true)
		
		f.Option2 = CreateFrame('Button', 'InstallOption2Button', f, 'UIPanelButtonTemplate')
		f.Option2:StripTextures()
		f.Option2:Size(110, 30)
		f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45)
		f.Option2:SetText('')
		f.Option2:Hide()
		f.Option2:SetScript('OnShow', function() f.Option1:SetWidth(110); f.Option1:ClearAllPoints(); f.Option1:Point('BOTTOMRIGHT', f, 'BOTTOM', -4, 45) end)
		f.Option2:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point('BOTTOM', 0, 45) end)
		E.Skins:HandleButton(f.Option2, true)
		
		f.Option3 = CreateFrame('Button', 'InstallOption3Button', f, 'UIPanelButtonTemplate')
		f.Option3:StripTextures()
		f.Option3:Size(100, 30)
		f.Option3:Point('LEFT', f.Option2, 'RIGHT', 4, 0)
		f.Option3:SetText('')
		f.Option3:Hide()
		f.Option3:SetScript('OnShow', function() f.Option1:SetWidth(100); f.Option1:ClearAllPoints(); f.Option1:Point('RIGHT', f.Option2, 'LEFT', -4, 0); f.Option2:SetWidth(100); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOM', f, 'BOTTOM', 0, 45) end)
		f.Option3:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point('BOTTOM', 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		E.Skins:HandleButton(f.Option3, true)
		
		f.Option4 = CreateFrame('Button', 'InstallOption4Button', f, 'UIPanelButtonTemplate')
		f.Option4:StripTextures()
		f.Option4:Size(100, 30)
		f.Option4:Point('LEFT', f.Option3, 'RIGHT', 4, 0)
		f.Option4:SetText('')
		f.Option4:Hide()
		f.Option4:SetScript('OnShow', function() 
			f.Option1:Width(100)
			f.Option2:Width(100)
			
			f.Option1:ClearAllPoints(); 
			f.Option1:Point('RIGHT', f.Option2, 'LEFT', -4, 0); 
			f.Option2:ClearAllPoints(); 
			f.Option2:Point('BOTTOMRIGHT', f, 'BOTTOM', -4, 45) 
		end)
		f.Option4:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point('BOTTOM', 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		E.Skins:HandleButton(f.Option4, true)
		
		f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
		f.SubTitle:FontTemplate(nil, 15, nil)
		f.SubTitle:Point('TOP', 0, -40)
		
		f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc1:FontTemplate()
		f.Desc1:Point('TOP', 0, -75)
		f.Desc1:Width(f:GetWidth() - 40)
		
		f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc2:FontTemplate()
		f.Desc2:Point('TOP', 0, -125)
		f.Desc2:Width(f:GetWidth() - 40)
		
		f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc3:FontTemplate()
		f.Desc3:Point('TOP', 0, -175)
		f.Desc3:Width(f:GetWidth() - 40)
		
		f.Desc4 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc4:FontTemplate()
		f.Desc4:Point('BOTTOM', 0, 80)
		f.Desc4:Width(f:GetWidth() - 40)
		
		local close = CreateFrame('Button', nil, f, 'UIPanelCloseButton')
		close:SetPoint('TOPRIGHT', f, 'TOPRIGHT')
		close:SetScript('OnClick', function()
			f:Hide()
		end)
		E.Skins:HandleCloseButton(close)
		
		f.tutorialImage = f:CreateTexture(nil, 'OVERLAY')
		f.tutorialImage:Size(256, 128)
		f.tutorialImage:SetTexture('Interface\\AddOns\\ElvUI_MerathilisUI\\media\\textures\\merathilis_logo.tga')
		f.tutorialImage:Point('BOTTOM', 0, 75)
		
		f.side = CreateFrame('Frame', 'MERTitleFrame', f)
		f.side:SetTemplate('Transparent')
		--f.side:Point('LEFT', f, 'LEFT', E.PixelMode and -1 or -3, 0)
		f.side:Size(180, 400)
		
		for i = 1, MAX_PAGE do
			titleText[i] = CreateFrame('Frame', nil, f.side)
			titleText[i]:Size(180, 20)
			titleText[i].text = titleText[i]:CreateFontString(nil, 'OVERLAY')
			titleText[i].text:SetPoint('LEFT', 27, 0)
			titleText[i].text:FontTemplate(nil, 12)
			titleText[i].text:SetTextColor(unpack(E['media'].rgbvaluecolor))
			
			-- Create Animation
			titleText[i].text.anim = CreateAnimationGroup(titleText[i].text)
			titleText[i].text.anim.color = titleText[i].text.anim:CreateAnimation("Color")
			titleText[i].text.anim.color:SetColorType("Text")
			
			titleText[i].hoverTex = titleText[i]:CreateTexture(nil, 'OVERLAY')
			titleText[i].hoverTex:SetTexture([[Interface\MONEYFRAME\Arrow-Right-Up]])
			titleText[i].hoverTex:Size(14)
			titleText[i].hoverTex:Point('RIGHT', titleText[i].text, 'LEFT', 4, -2)
			titleText[i].hoverTex:SetAlpha(0)
			titleText[i].check = titleText[i]:CreateTexture(nil, 'OVERLAY')
			titleText[i].check:Size(20)
			titleText[i].check:Point('LEFT', titleText[i].text, 'RIGHT', 0, -2)
			titleText[i].check:SetTexture([[Interface\BUTTONS\UI-CheckBox-Check]])
			titleText[i].check:Hide()
			
			if i == 1 then titleText[i].text:SetFormattedText("%s", L['Welcome'])
				elseif i == 2 then titleText[i].text:SetFormattedText("%s", L['Layout'])
				elseif i == 3 then titleText[i].text:SetFormattedText("%s", L['Chat'])
				elseif i == 4 then titleText[i].text:SetFormattedText("%s", L['DataTexts'])
				elseif i == 5 then titleText[i].text:SetFormattedText("%s", L['ActionBars'])
				elseif i == 6 then titleText[i].text:SetFormattedText("%s", L['UnitFrames'])
				elseif i == 7 then titleText[i].text:SetFormattedText("%s", ADDONS)
				elseif i == 8 then titleText[i].text:SetFormattedText("%s", L['Finish'])
			end
			
			if(i == 1) then
				titleText[i]:Point('TOP', f.side, 'TOP', 0, -40)
			else
				titleText[i]:Point('TOP', titleText[i - 1], 'BOTTOM')
			end
		end
	end
	
	-- Animations
	MERTitleFrame:Point('LEFT', 'MERInstallFrame', 'LEFT', E.PixelMode and -1 or -3, 0)
	local animGroup = CreateAnimationGroup(MERTitleFrame)
	local anim = animGroup:CreateAnimation("Move")
	anim:SetOffset(-180, 0)
	anim:SetDuration(1)
	anim:SetSmoothing("Bounce")
	anim:Play()
	
	MERInstallFrame:Show()
	NextPage()
end
