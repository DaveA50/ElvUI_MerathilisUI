local E, L, V, P, G, _ = unpack(ElvUI);
local MER = E:GetModule('MerathilisUI');

-- local means that this function is used in this file only and cannot be accessed from other files/addons.
-- A local function must be above the global ones (e.g. MER:SetupUI()). Globals can be accessed from other files/addons
-- Also local functions take less memory
local function SetMoverPosition(mover, point, anchor, secondaryPoint, x, y)
	if not _G[mover] then return end
	local frame = _G[mover]

	frame:ClearAllPoints()
	frame:SetPoint(point, anchor, secondaryPoint, x, y)
	E:SaveMoverPosition(mover)
end

-- local functions must go up
function SetupUI() -- this cannot be local when using the module name (MER)
	-- Here you put ElvUI settings that you want enabled or not.
	-- Opening ElvUI.lua file from the WTF folder will show you your current profile settings.
	do
	-- General
		E.private.general.pixelPerfect = true
		E.db.general.totems.size = 36
		E.db.general.font = 'Merathilis Prototype'
		E.db.general.fontSize = 11
		E.db.general.interruptAnnounce = "RAID"
		E.db.general.autoRepair = "GUILD"
		E.db.general.minimap.garrisonPos = "TOPRIGHT"
		E.db.general.minimap.icons.garrison.scale = 0.9
		E.db.general.minimap.icons.garrison.position = "TOPRIGHT"
		E.db.general.minimap.icons.garrison.yOffset = 10
		E.db.general.minimap.size = 150
		E.db.general.loginmessage = false
		E.db.general.stickyFrames = false
		E.db.general.backdropcolor.r = 0.101960784313726
		E.db.general.backdropcolor.g = 0.101960784313726
		E.db.general.backdropcolor.b = 0.101960784313726
		E.db.general.vendorGrays = true
		E.db.general.bottompanel = false
		E.global.general.smallerWorldMap = false
		E.db.general.backdropfadecolor.r = 0.0549
		E.db.general.backdropfadecolor.g = 0.0549
		E.db.general.backdropfadecolor.b = 0.0549
		E.private.general.namefont = 'Merathilis Prototype'
		E.private.general.dmgfont = 'ElvUI Combat'
		E.private.general.normTex = 'MerathilisFlat'
		E.private.general.glossTex = 'MerathilisFlat'
		E.private.skins.blizzard.alertframes = true
		E.private.skins.blizzard.questChoice = true
	end
	
	do
	-- Actionbars
		E.db.actionbar.font = 'Merathilis Prototype'
		E.db.actionbar.fontOutline = 'OUTLINE'
		E.db.actionbar.macrotext = true
		
		E.db.actionbar.bar1.buttonspacing = 4
		E.db.actionbar.bar1.backdrop = true
		E.db.actionbar.bar1.heightMult = 2
		E.db.actionbar.bar1.buttonsize = 30
		E.db.actionbar.bar1.buttons = 12
		E.db.actionbar.bar2.enable = true
		E.db.actionbar.bar2.buttonspacing = 4
		E.db.actionbar.bar2.buttons = 12
		E.db.actionbar.bar2.buttonsize = 30
		E.db.actionbar.bar2.heightMult = 1
		E.db.actionbar.bar2.backdrop = false
		E.db.actionbar.bar3.backdrop = true
		E.db.actionbar.bar3.buttonsPerRow = 3
		E.db.actionbar.bar3.buttonsize = 30
		E.db.actionbar.bar3.buttons = 6
		E.db.actionbar.bar4.buttonspacing = 4
		E.db.actionbar.bar4.mouseover = true
		E.db.actionbar.bar4.buttonsize = 26
		E.db.actionbar.bar5.backdrop = true
		E.db.actionbar.bar5.buttonsPerRow = 3
		E.db.actionbar.bar5.buttonsize = 30
		E.db.actionbar.bar5.buttons = 6
		E.db.actionbar.bar6.backdrop = true
		E.db.actionbar.bar6.buttonsPerRow = 1
		E.db.actionbar.bar6.mouseover = true
		E.db.actionbar.bar6.buttons = 4
		E.db.actionbar.barPet.point = 'RIGHT'
		E.db.actionbar.barPet.buttonspacing = 4
		E.db.actionbar.stanceBar.point = 'BOTTOMLEFT'
		E.db.actionbar.stanceBar.backdrop = true
		E.db.actionbar.stanceBar.buttonsPerRow = 6
		E.db.actionbar.stanceBar.buttonsize = 20
	end
	
	do
	-- Auras
		E.db.auras.debuffs.size = 30
		E.db.auras.fadeThreshold = 10
		E.db.auras.font = 'Merathilis Prototype'
		E.db.auras.fontOutline = 'OUTLINE'
		E.db.auras.consolidatedBuffs.fontSize = 11
		E.db.auras.consolidatedBuffs.font = 'Merathilis Visitor1'
		E.db.auras.consolidatedBuffs.fontOutline = 'OUTLINE'
		E.db.auras.consolidatedBuffs.filter = false
		E.db.auras.buffs.fontSize = 12
		E.db.auras.buffs.horizontalSpacing = 15
		E.db.auras.buffs.verticalSpacing = 15
		E.db.auras.buffs.size = 28
	end
	
	do
	-- Bags
		E.db.bags.itemLevelFont = 'Merathilis Prototype'
		E.db.bags.itemLevelFontSize = 8
		E.db.bags.itemLevelFontOutline = 'OUTLINE'
		E.db.bags.countFont = 'Merathilis Prototype'
		E.db.bags.countFontSize = 11
		E.db.bags.countFontOutline = 'OUTLINE'
		E.db.bags.yOffsetBank = 235
		E.db.bags.bagSize = 25
		E.db.bags.alignToChat = false
		E.db.bags.bagWidth = 450
		E.db.bags.bankSize = 25
		E.db.bags.bankWidth = 450
		E.db.bags.moneyFormat = 'BLIZZARD'
		E.db.bags.itemLevelThreshold = 650
	end
	
	do
	-- Chat
		E.db.chat.keywordSound = 'Whisper Alert'
		E.db.chat.tabFont = 'Merathilis Roadway'
		E.db.chat.tabFontOutline = 'OUTLINE'
		E.db.chat.panelTabTransparency = true
		E.db.chat.fontOutline = 'OUTLINE'
		E.db.chat.chatHistory = false
		E.db.chat.font = 'Merathilis Prototype'
		E.db.chat.fontSize = 13
		E.db.chat.panelWidth = 400
		E.db.chat.panelHeigth = 150
		E.db.chat.editBoxPosition = 'ABOVE_CHAT'
		E.db.chat.panelBackdrop = 'SHOWBOTH'
		E.db.chat.keywords = '%MYNAME%, ElvUI, Andy'
		E.db.chat.timeStampFormat = '%H:%M '
	end
	
	do
	-- Datatexts
		E.db.datatexts.font = 'Merathilis Roadway'
		E.db.datatexts.fontSize = 14
		E.db.datatexts.fontOutline = 'OUTLINE'
		E.db.datatexts.leftChatPanel = false
		E.db.datatexts.rightChatPanel = false
		E.db.datatexts.time24 = true
		E.db.datatexts.minimapPanels = false
		E.db.datatexts.panelTransparency = false
		E.db.datatexts.actionbar3 = false
		E.db.datatexts.actionbar5 = false
		E.db.datatexts.goldCoins = true
		E.db.datatexts.noCombatHover = true
		
		E.db.datatexts.panels.RightChatDataPanel.right = ''
		E.db.datatexts.panels.RightChatDataPanel.left = ''
		E.db.datatexts.panels.RightChatDataPanel.middle = ''
		E.db.datatexts.panels.LeftChatDataPanel.right = ''
		E.db.datatexts.panels.LeftChatDataPanel.left = ''
		E.db.datatexts.panels.LeftChatDataPanel.middle = ''
		E.db.datatexts.panels.RightMiniPanel = ''
		E.db.datatexts.panels.Actionbar3DataPanel = ''
		E.db.datatexts.panels.Top_Center = ''
		E.db.datatexts.panels.LeftMiniPanel = ''
		E.db.datatexts.panels.Actionbar5DataPanel = ''
	end
	
	do
	-- Nameplates
		E.db.nameplate.font = 'Merathilis Roadway'
		E.db.nameplate.fontSize = 11
		E.db.nameplate.fontOutline = 'OUTLINE'
		E.db.nameplate.debuffs.font = 'Merathilis Prototype'
		E.db.nameplate.debuffs.fontSize = 9
		E.db.nameplate.debuffs.fontOutline = 'OUTLINE'
		E.db.nameplate.auraFontOutline = 'OUTLINE'
		E.db.nameplate.maxAuras = 5
		E.db.nameplate.comboPoints = true
		E.db.nameplate.sortDirection = 1
		E.db.nameplate.colorByTime = true
		E.db.nameplate.buffs.font = 'Merathilis Prototype'
		E.db.nameplate.buffs.fontSize = 7
		E.db.nameplate.buffs.fontOutline = 'OUTLINE'
		E.db.nameplate.healthBar.text.enable = true
		E.db.nameplate.healthBar.text.format = 'CURRENT_PERCENT'
		E.db.nameplate.healthBar.height = 4
		E.db.nameplate.healthBar.colorByRaidIcon = true
		E.db.nameplate.healthBar.lowHPScale.enable = true
		E.db.nameplate.healthBar.width = 100
		E.db.nameplate.auraFont = 'ElvUI Font'
		E.db.nameplate.healthtext = 'CURRENT_PERCENT'
		E.db.nameplate.auraAnchor = 1
		E.db.nameplate.targetIndicator.color.g = 0
		E.db.nameplate.targetIndicator.color.b = 0
		E.db.nameplate.wrapName = true
		E.db.nameplate.buffs.fontOutline = 'OUTLINE'
		E.db.nameplate.buffs.font = 'Merathilis Prototype'
	end
	
	do
	-- Tooltip
		E.db.tooltip.font = 'Merathilis Prototype'
		E.db.tooltip.fontOutline = 'OUTLINE'
		E.db.tooltip.combathide = true
		E.db.tooltip.style = 'inset'
		E.db.tooltip.itemCount = 'NONE'
		E.db.tooltip.headerFontSize = 14
		E.db.tooltip.textFontSize = 11
		E.db.tooltip.smallTextFontSize = 11
		E.db.tooltip.healthBar.font = 'Merathilis Prototype'
		E.db.tooltip.healthBar.fontSize = 10
		E.db.tooltip.healthBar.fontOutline = 'OUTLINE'
		E.db.tooltip.healthBar.height = 5
	end
	
	do
	-- Unitframes
		E.db.unitframe.font = 'Merathilis Tukui'
		E.db.unitframe.fontSize = 14
		E.db.unitframe.fontOutline = 'OUTLINE'
		E.db.unitframe.smoothbars = true
		E.db.unitframe.statusbar = 'MerathilisFlat'
		E.db.unitframe.colors.powerclass = true
		E.db.unitframe.colors.castColor.r = 0.1
		E.db.unitframe.colors.castColor.g = 0.1
		E.db.unitframe.colors.castColor.b = 0.1
		E.db.unitframe.colors.transparentAurabars = true
		E.db.unitframe.colors.transparentPower = true
		E.db.unitframe.colors.transparentCastbar = true
		E.db.unitframe.colors.health.r = 0.235294117647059
		E.db.unitframe.colors.health.g = 0.235294117647059
		E.db.unitframe.colors.health.b = 0.235294117647059
	-- Player
		E.db.unitframe.units.player.width = 240
		E.db.unitframe.units.player.height = 45
		E.db.unitframe.units.player.debuffs.fontSize = 11
		E.db.unitframe.units.player.debuffs.attachTo = 'FRAME'
		E.db.unitframe.units.player.debuffs.sizeOverride = 32
		E.db.unitframe.units.player.debuffs.xOffset = -3
		E.db.unitframe.units.player.debuffs.yOffset = 5
		E.db.unitframe.units.player.debuffs.anchorPoint = 'LEFT'
		E.db.unitframe.units.player.portrait.enable = true
		E.db.unitframe.units.player.portrait.overlay = true
		E.db.unitframe.units.player.portrait.camDistanceScale = 1.35
		E.db.unitframe.units.player.portrait.width = 43
		E.db.unitframe.units.player.classbar.enable = false
		E.db.unitframe.units.player.aurabar.enable = false
		E.db.unitframe.units.player.threatStyle = 'ICONTOPRIGHT'
		E.db.unitframe.units.player.castbar.icon = true
		E.db.unitframe.units.player.castbar.width = 240
		E.db.unitframe.units.player.castbar.height = 18
		E.db.unitframe.units.player.customTexts = {}
		E.db.unitframe.units.player.customTexts.Gesundheit = {}
		E.db.unitframe.units.player.customTexts.Gesundheit.font = 'Merathilis Tukui'
		E.db.unitframe.units.player.customTexts.Gesundheit.justifyH = 'LEFT'
		E.db.unitframe.units.player.customTexts.Gesundheit.fontOutline = 'OUTLINE'
		E.db.unitframe.units.player.customTexts.Gesundheit.xOffset = 0
		E.db.unitframe.units.player.customTexts.Gesundheit.yOffset = 9
		E.db.unitframe.units.player.customTexts.Gesundheit.text_format = '[name:medium] [difficultycolor][smartlevel] [shortclassification]'
		E.db.unitframe.units.player.customTexts.Gesundheit.size = 24
		E.db.unitframe.units.player.customTexts.LevelClass = {}
		E.db.unitframe.units.player.customTexts.LevelClass.font = 'Merathilis Tukui'
		E.db.unitframe.units.player.customTexts.LevelClass.justifyH = 'LEFT'
		E.db.unitframe.units.player.customTexts.LevelClass.fontOutline = 'OUTLINE'
		E.db.unitframe.units.player.customTexts.LevelClass.xOffset = 0
		E.db.unitframe.units.player.customTexts.LevelClass.yOffset = -7
		E.db.unitframe.units.player.customTexts.LevelClass.size = 12
		E.db.unitframe.units.player.customTexts.LevelClass.text_format = '[difficultycolor][level] [race] [namecolor][class]'
		E.db.unitframe.units.player.health.xOffset = -3
		E.db.unitframe.units.player.health.yOffset = -33
		E.db.unitframe.units.player.health.text_format = '[healthcolor][health:percent] - [health:current]'
		E.db.unitframe.units.player.power.xOffset = 5
		E.db.unitframe.units.player.power.yOffset = -32
		E.db.unitframe.units.player.power.height = 5
		E.db.unitframe.units.player.power.hideonnpc = true
		E.db.unitframe.units.player.power.detachedWidth = 298
		E.db.unitframe.units.player.buffs.sizeOverride = 30
		E.db.unitframe.units.player.buffs.yOffset = 2
		E.db.unitframe.units.player.buffs.noDuration = false
		E.db.unitframe.units.player.buffs.attachTo = 'FRAME'
	-- Target
		E.db.unitframe.units.target.width = 240
		E.db.unitframe.units.target.height = 45
		E.db.unitframe.units.target.castbar.latency = true
		E.db.unitframe.units.target.castbar.width = 239.999954223633
		E.db.unitframe.units.target.debuffs.sizeOverride = 32
		E.db.unitframe.units.target.debuffs.yOffset = 5
		E.db.unitframe.units.target.debuffs.xOffset = 3
		E.db.unitframe.units.target.debuffs.anchorPoint = 'RIGHT'
		E.db.unitframe.units.target.debuffs.numrows = 2
		E.db.unitframe.units.target.debuffs.perrow = 3
		E.db.unitframe.units.target.debuffs.attachTo = 'FRAME'
		E.db.unitframe.units.target.aurabar.enable = false
		E.db.unitframe.units.target.aurabar.attachTo = 'BUFFS'
		E.db.unitframe.units.target.name.xOffset = 8
		E.db.unitframe.units.target.name.yOffset = -32
		E.db.unitframe.units.target.name.position = 'RIGHT'
		E.db.unitframe.units.target.name.text_format = ''
		E.db.unitframe.units.target.threatStyle = 'ICONTOPLEFT'
		E.db.unitframe.units.target.power.xOffset = -2
		E.db.unitframe.units.target.power.yOffset = -32
		E.db.unitframe.units.target.power.detachedWidth = 298
		E.db.unitframe.units.target.power.hideonnpc = false
		E.db.unitframe.units.target.power.height = 5
		E.db.unitframe.units.target.customTexts = {}
		E.db.unitframe.units.target.customTexts.Gesundheit = {}
		E.db.unitframe.units.target.customTexts.Gesundheit.font = 'Merathilis Tukui'
		E.db.unitframe.units.target.customTexts.Gesundheit.justifyH = 'RIGHT'
		E.db.unitframe.units.target.customTexts.Gesundheit.fontOutline = 'OUTLINE'
		E.db.unitframe.units.target.customTexts.Gesundheit.xOffset = 8
		E.db.unitframe.units.target.customTexts.Gesundheit.size = 24
		E.db.unitframe.units.target.customTexts.Gesundheit.text_format = '[name:medium] [difficultycolor]'
		E.db.unitframe.units.target.customTexts.Gesundheit.yOffset = 9
		E.db.unitframe.units.target.customTexts.Name1 = {}
		E.db.unitframe.units.target.customTexts.Name1.font = 'Merathilis Tukui'
		E.db.unitframe.units.target.customTexts.Name1.justifyH = 'RIGHT'
		E.db.unitframe.units.target.customTexts.Name1.fontOutline = 'OUTLINE'
		E.db.unitframe.units.target.customTexts.Name1.xOffset = 1
		E.db.unitframe.units.target.customTexts.Name1.size = 12
		E.db.unitframe.units.target.customTexts.Name1.text_format = '[difficultycolor][level] [namecolor][smartclass]'
		E.db.unitframe.units.target.customTexts.Name1.yOffset = -7
		E.db.unitframe.units.target.health.xOffset = 8
		E.db.unitframe.units.target.health.text_format = '[healthcolor][health:percent] - [health:current]'
		E.db.unitframe.units.target.health.yOffset = -33
		E.db.unitframe.units.target.portrait.rotation = 307
		E.db.unitframe.units.target.portrait.overlay = true
		E.db.unitframe.units.target.portrait.xOffset = 0.07
		E.db.unitframe.units.target.portrait.enable = true
		E.db.unitframe.units.target.portrait.camDistanceScale = 1.35
		E.db.unitframe.units.target.buffs.sizeOverride = 21
		E.db.unitframe.units.target.buffs.perrow = 11
		E.db.unitframe.units.target.buffs.fontSize = 12
		E.db.unitframe.units.target.castbar.width = 240
		E.db.unitframe.units.target.castbar.height = 18
	-- TargetTarget
		E.db.unitframe.units.targettarget.debuffs.enable = true
		E.db.unitframe.units.targettarget.power.position = 'CENTER'
		E.db.unitframe.units.targettarget.power.height = 5
		E.db.unitframe.units.targettarget.width = 100
		E.db.unitframe.units.targettarget.name.yOffset = -1
		E.db.unitframe.units.targettarget.health.position = 'CENTER'
		E.db.unitframe.units.targettarget.height = 25
	-- Focus
		E.db.unitframe.units.focus.power.height = 5
		E.db.unitframe.units.focus.width = 122
		E.db.unitframe.units.focus.height = 20
		E.db.unitframe.units.focus.castbar.height = 6
		E.db.unitframe.units.focus.castbar.width = 122
	-- FocusTarget
		E.db.unitframe.units.focustarget.debuffs.enable = true
		E.db.unitframe.units.focustarget.debuffs.anchorPoint = 'TOPRIGHT'
		E.db.unitframe.units.focustarget.threatStyle = 'GLOW'
		E.db.unitframe.units.focustarget.power.enable = true
		E.db.unitframe.units.focustarget.power.height = 5
		E.db.unitframe.units.focustarget.width = 122
		E.db.unitframe.units.focustarget.enable = true
		E.db.unitframe.units.focustarget.height = 20
	-- Raid
		E.db.unitframe.units.raid.horizontalSpacing = 1
		E.db.unitframe.units.raid.debuffs.fontSize = 12
		E.db.unitframe.units.raid.debuffs.enable = true
		E.db.unitframe.units.raid.debuffs.yOffset = -5
		E.db.unitframe.units.raid.debuffs.anchorPoint = 'TOPRIGHT'
		E.db.unitframe.units.raid.debuffs.sizeOverride = 21
		E.db.unitframe.units.raid.rdebuffs.fontSize = 12
		E.db.unitframe.units.raid.numGroups = 4
		E.db.unitframe.units.raid.growDirection = 'RIGHT_UP'
		E.db.unitframe.units.raid.name.xOffset = 2
		E.db.unitframe.units.raid.name.yOffset = -23
		E.db.unitframe.units.raid.name.text_format = '[namecolor][name:short] [difficultycolor][smartlevel]'
		E.db.unitframe.units.raid.name.position = 'CENTER'
		E.db.unitframe.units.raid.buffIndicator.fontSize = 11
		E.db.unitframe.units.raid.buffIndicator.size = 10
		E.db.unitframe.units.raid.roleIcon.size = 12
		E.db.unitframe.units.raid.power.position = 'CENTER'
		E.db.unitframe.units.raid.power.height = 15
		E.db.unitframe.units.raid.healthPrediction = true
		E.db.unitframe.units.raid.width = 79
		E.db.unitframe.units.raid.groupBy = 'ROLE'
		E.db.unitframe.units.raid.health.frequentUpdates = true
		E.db.unitframe.units.raid.health.position = 'CENTER'
		E.db.unitframe.units.raid.health.text_format = '[health:deficit]'
		E.db.unitframe.units.raid.buffs.enable = true
		E.db.unitframe.units.raid.buffs.yOffset = 42
		E.db.unitframe.units.raid.buffs.anchorPoint = 'BOTTOMLEFT'
		E.db.unitframe.units.raid.buffs.clickTrough = true
		E.db.unitframe.units.raid.buffs.useBlacklist = false
		E.db.unitframe.units.raid.buffs.noDuration = false
		E.db.unitframe.units.raid.buffs.playerOnly = false
		E.db.unitframe.units.raid.buffs.perrow = 1
		E.db.unitframe.units.raid.buffs.useFilter = 'TurtleBuffs'
		E.db.unitframe.units.raid.buffs.noConsolidated = false
		E.db.unitframe.units.raid.buffs.sizeOverride = 22
		E.db.unitframe.units.raid.buffs.xOffset = 30
		E.db.unitframe.units.raid.height = 45
		E.db.unitframe.units.raid.verticalSpacing = 10
		E.db.unitframe.units.raid.raidicon.attachTo = 'LEFT'
		E.db.unitframe.units.raid.raidicon.xOffset = 9
		E.db.unitframe.units.raid.raidicon.size = 13
		E.db.unitframe.units.raid.raidicon.yOffset = 0
	-- Raid40
		E.db.unitframe.units.raid40.horizontalSpacing = 1
		E.db.unitframe.units.raid40.debuffs.enable = true
		E.db.unitframe.units.raid40.debuffs.yOffset = -9
		E.db.unitframe.units.raid40.debuffs.anchorPoint = 'TOPRIGHT'
		E.db.unitframe.units.raid40.debuffs.clickTrough = true
		E.db.unitframe.units.raid40.debuffs.useBlacklist = false
		E.db.unitframe.units.raid40.debuffs.perrow = 2
		E.db.unitframe.units.raid40.debuffs.useFilter = 'Whitlist (Strict)'
		E.db.unitframe.units.raid40.debuffs.sizeOverride = 21
		E.db.unitframe.units.raid40.debuffs.xOffset = -4
		E.db.unitframe.units.raid40.rdebuffs.size = 26
		E.db.unitframe.units.raid40.growthDirection = 'RIGHT_UP'
		E.db.unitframe.units.raid40.name.position = 'TOP'
		E.db.unitframe.units.raid40.groupBy = 'ROLE'
		E.db.unitframe.units.raid40.roleIcon.position = 'TOPRIGHT'
		E.db.unitframe.units.raid40.roleIcon.enable = true
		E.db.unitframe.units.raid40.raidWideSorting = false
		E.db.unitframe.units.raid40.power.enable = true
		E.db.unitframe.units.raid40.power.position = 'CENTER'
		E.db.unitframe.units.raid40.power.height = 5
		E.db.unitframe.units.raid40.customTexts = {}
		E.db.unitframe.units.raid40.customTexts.HealthText = {}
		E.db.unitframe.units.raid40.customTexts.HealthText.font = 'Merathilis Tukui'
		E.db.unitframe.units.raid40.customTexts.HealthText.justifyH = 'CENTER'
		E.db.unitframe.units.raid40.customTexts.HealthText.fontOutline = 'OUTLINE'
		E.db.unitframe.units.raid40.customTexts.HealthText.xOffset = 0
		E.db.unitframe.units.raid40.customTexts.HealthText.yOffset = -7
		E.db.unitframe.units.raid40.customTexts.HealthText.text_format = '[healthcolor][health:deficit]'
		E.db.unitframe.units.raid40.customTexts.HealthText.size = 10
		E.db.unitframe.units.raid40.healPrediction = true
		E.db.unitframe.units.raid40.width = 79
		E.db.unitframe.units.raid40.positionOverride = 'BOTTOMRIGHT'
		E.db.unitframe.units.raid40.health.frequentUpdates = true
		E.db.unitframe.units.raid40.buffs.enable = true
		E.db.unitframe.units.raid40.buffs.yOffset = 25
		E.db.unitframe.units.raid40.buffs.anchorPoint = 'BOTTOMLEFT'
		E.db.unitframe.units.raid40.buffs.clickTrough = true
		E.db.unitframe.units.raid40.buffs.useBlacklist = false
		E.db.unitframe.units.raid40.buffs.noDuration = false
		E.db.unitframe.units.raid40.buffs.playerOnly = false
		E.db.unitframe.units.raid40.buffs.perrow = 1
		E.db.unitframe.units.raid40.buffs.useFilter = 'TurtleBuffs'
		E.db.unitframe.units.raid40.buffs.noConsolidated = false
		E.db.unitframe.units.raid40.buffs.sizeOverride = 17
		E.db.unitframe.units.raid40.buffs.xOffset = 21
		E.db.unitframe.units.raid40.height = 43
		E.db.unitframe.units.raid40.verticalSpacing = 1
		E.db.unitframe.units.raid40.raidicon.attachTo = 'LEFT'
		E.db.unitframe.units.raid40.raidicon.xOffset = 9
		E.db.unitframe.units.raid40.raidicon.size = 13
		E.db.unitframe.units.raid40.raidicon.yOffset = 0
	-- Party
		E.db.unitframe.units.party.debuffs.sizeOverride = 21
		E.db.unitframe.units.party.debuffs.yOffset = -7
		E.db.unitframe.units.party.debuffs.anchorPoint = 'TOPRIGHT'
		E.db.unitframe.units.party.debuffs.xOffset = -4
		E.db.unitframe.units.party.targetsGroup.anchorPoint = 'BOTTOM'
		E.db.unitframe.units.party.GPSArrow.size = 40
		E.db.unitframe.units.party.customTexts = {}
		E.db.unitframe.units.party.customTexts.HealthText = {}
		E.db.unitframe.units.party.customTexts.HealthText.font = 'Merathilis Tukui'
		E.db.unitframe.units.party.customTexts.HealthText.justifyH = 'CENTER'
		E.db.unitframe.units.party.customTexts.HealthText.fontOutline = 'OUTLINE'
		E.db.unitframe.units.party.customTexts.HealthText.xOffset = 0
		E.db.unitframe.units.party.customTexts.HealthText.yOffset = -7
		E.db.unitframe.units.party.customTexts.HealthText.text_format = '[healthcolor][health:deficit]'
		E.db.unitframe.units.party.customTexts.HealthText.size = 10
		E.db.unitframe.units.party.healPrediction = true
		E.db.unitframe.units.party.name.xOffset = 2
		E.db.unitframe.units.party.name.yOffset = -23
		E.db.unitframe.units.party.name.text_format = '[namecolor][name:short] [difficultycolor][smartlevel]'
		E.db.unitframe.units.party.name.position = 'CENTER'
		E.db.unitframe.units.party.height = 45
		E.db.unitframe.units.party.verticalSpacing = 4
		E.db.unitframe.units.party.raidicon.attachTo = 'LEFT'
		E.db.unitframe.units.party.raidicon.xOffset = 9
		E.db.unitframe.units.party.raidicon.size = 13
		E.db.unitframe.units.party.raidicon.yOffset = 0
		E.db.unitframe.units.party.horizontalSpacing = 1
		E.db.unitframe.units.party.growthDirection = 'RIGHT_UP'
		E.db.unitframe.units.party.buffIndicator.size = 10
		E.db.unitframe.units.party.power.text_format = ''
		E.db.unitframe.units.party.power.height = 15
		E.db.unitframe.units.party.positionOverride = 'BOTTOM'
		E.db.unitframe.units.party.width = 79
		E.db.unitframe.units.party.groupBy = 'ROLE'
		E.db.unitframe.units.party.health.frequentUpdates = true
		E.db.unitframe.units.party.health.position = 'BOTTOM'
		E.db.unitframe.units.party.health.text_format = ''
		E.db.unitframe.units.party.petsGroup.anchorPoint = 'BOTTOM'
		E.db.unitframe.units.party.buffs.enable = true
		E.db.unitframe.units.party.buffs.yOffset = 28
		E.db.unitframe.units.party.buffs.anchorPoint = 'BOTTOMLEFT'
		E.db.unitframe.units.party.buffs.clickTrough = true
		E.db.unitframe.units.party.buffs.useBlacklist = false
		E.db.unitframe.units.party.buffs.noDuration = false
		E.db.unitframe.units.party.buffs.playerOnly = false
		E.db.unitframe.units.party.buffs.perrow = 1
		E.db.unitframe.units.party.buffs.useFilter = 'TurtleBuffs'
		E.db.unitframe.units.party.buffs.noConsolidated = false
		E.db.unitframe.units.party.buffs.sizeOverride = 22
		E.db.unitframe.units.party.buffs.xOffset = 30
	-- Assist
		E.db.unitframe.units.assist.targetsGroup.enable = false
	-- Pet
		E.db.unitframe.units.pet.castbar.latency = true
		E.db.unitframe.units.pet.castbar.width = 102
		E.db.unitframe.units.pet.width = 102
		E.db.unitframe.units.pet.height = 24
		E.db.unitframe.units.pet.power.height = 5
	-- Arena
		E.db.unitframe.units.arena.power.width = 'inset'
	-- Boss
		E.db.unitframe.units.boss.castbar.latency = true
		E.db.unitframe.units.boss.portrait.enable = true
		E.db.unitframe.units.boss.power.height = 10
		E.db.unitframe.units.boss.width = 215
		E.db.unitframe.units.boss.height = 45
		E.db.unitframe.units.boss.threatStyle = 'BORDERS'
	-- PetTarget
		E.db.unitframe.units.pettarget.power.width = 'inset'
	end
	
	-- Movers
	if E.db.movers == nil then E.db.movers = {} end -- prevent a lua error when running the install after a profile gets deleted.
	do
	-- PlayerMover
		SetMoverPosition('ElvUF_PlayerMover', 'BOTTOM', E.UIParent, 'BOTTOM', -192, 147)
		SetMoverPosition('ElvUF_PlayerCastbarMover', 'BOTTOM', E.UIParent, 'BOTTOM', -192, 110)
	-- TargetMover
		SetMoverPosition('ElvUF_TargetMover', 'BOTTOM', E.UIParent, 'BOTTOM', 192, 147)
		SetMoverPosition('ElvUF_TargetCastbarMover', 'BOTTOM', E.UIParent, 'BOTTOM', 192, 110)
	-- ...
		SetMoverPosition('MinimapMover', 'TOPRIGHT', E.UIParent, 'TOPRIGHT', -5, -6)
		SetMoverPosition('DebuffsMover', 'TOPRIGHT', E.UIParent, 'TOPRIGHT', -183, -134)
	-- AlertFrame for Garrison etc.
		SetMoverPosition('AlertFrameMover', 'TOP', E.UIParent, 'TOP', 0, -140)
	-- ...
		SetMoverPosition('ElvUF_BodyGuardMover', 'BOTTOMLEFT', E.UIParent, 'BOTTOMLEFT', 497, 196)
		SetMoverPosition('ElvUF_PartyMover', 'BOTTOMLEFT', E.UIParent, 'BOTTOMLEFT', 2, 182)
		SetMoverPosition('WatchFrameMover', 'TOPRIGHT', E.UIParent, 'TOPRIGHT', -122, -292)
		SetMoverPosition('BossHeaderMover', 'TOPRIGHT', E.UIParent, 'TOPRIGHT', -56, -397)
		SetMoverPosition('Top_Center_Mover', 'BOTTOM', E.UIParent, 'BOTTOM', -262, 0)
		SetMoverPosition('ElvAB_6', 'BOTTOMRIGHT', E.UIParent, 'BOTTOMRIGHT', -421, 59)
		SetMoverPosition('PetAB', 'BOTTOM', E.UIParent, 'BOTTOM', 0, 200)
		SetMoverPosition('TargetPowerBarMover', 'BOTTOM', E.UIParent, 'BOTTOM', 203, 429)
		SetMoverPosition('VehicleSeatMover', 'TOPLEFT', E.UIParent, 'TOPLEFT', 2, -84)
		SetMoverPosition('TotemBarMover', 'BOTTOMLEFT', E.UIParent, 'BOTTOMLEFT', 421, 8)
		SetMoverPosition('TempEnchantMover', 'TOPRIGHT', E.UIParent, 'TOPRIGHT', -5, -299)
		SetMoverPosition('ElvAB_5', 'BOTTOM', E.UIParent, 'BOTTOM', -262, 34)
		SetMoverPosition('ElvAB_3', 'BOTTOM', E.UIParent, 'BOTTOM', 262, 34)
		SetMoverPosition('ReputationBarMover', 'BOTTOMRIGHT', E.UIParent, 'BOTTOMRIGHT', -404, 23)
		SetMoverPosition('ExperienceBarMover', 'BOTTOMRIGHT', E.UIParent, 'BOTTOMRIGHT', 404, 23)
		SetMoverPosition('ElvAB_2', 'BOTTOM', E.UIParent, 'BOTTOM', 0, 62)
		SetMoverPosition('ElvAB_1', 'BOTTOM', E.UIParent, 'BOTTOM', 0, 27)
		SetMoverPosition('ArenaHeaderMover', 'TOPRIGHT', E.UIParent, 'TOPRIGHT', -150, -305)
		SetMoverPosition('ElvUF_Raid40Mover', 'BOTTOMLEFT', E.UIParent, 'BOTTOMLEFT', 2, 183)
		SetMoverPosition('ElvUF_Raid25Mover', 'BOTTOMLEFT', E.UIParent, 'BOTTOMLEFT', 2, 183)
		SetMoverPosition('ShiftAB', 'BOTTOMLEFT', E.UIParent, 'BOTTOMLEFT', 898, 106)
		SetMoverPosition('MicrobarMover', 'TOPLEFT', E.UIParent, 'TOPLEFT', 4, -4)
		SetMoverPosition('ClassBarMover', 'BOTTOM', E.UIParent, 'BOTTOM', -1, 349)
		SetMoverPosition('ElvUF_FocusMover', 'BOTTOMRIGHT', E.UIParent, 'BOTTOMRIGHT', -484, 240)
		SetMoverPosition('DigSiteProgressBarMover', 'TOP', E.UIParent, 'TOP', -2, 0)
		SetMoverPosition('FlareMover', 'BOTTOM', E.UIParent, 'BOTTOM', 0, 253)
		SetMoverPosition('LocationMover', 'TOP', E.UIParent, 'TOP', 0, -7)
		SetMoverPosition('GMMover', 'TOPLEFT', E.UIParent, 'TOPLEFT', 329, 0)
		SetMoverPosition('LeftChatMover', 'BOTTOMLEFT', E.UIParent, 'BOTTOMLEFT', 2, 23)
		SetMoverPosition('ElvUF_RaidMover', 'BOTTOMLEFT', E.UIParent, 'BOTTOMLEFT', 2, 183)
		SetMoverPosition('ElvUF_AssistMover', 'TOPLEFT', E.UIParent, 'BOTTOMLEFT', 2, 571)
		SetMoverPosition('RightChatMover', 'BOTTOMRIGHT', E.UIParent, 'BOTTOMRIGHT', -2, 23)
		SetMoverPosition('tokenHolderMover', 'TOPLEFT', E.UIParent, 'TOPLEFT', 4, -119)
		SetMoverPosition('UIBFrameMover', 'TOPRIGHT', E.UIParent, 'TOPRIGHT', -44, -161)
		SetMoverPosition('BNETMover', 'TOP', E.UIParent, 'TOP', 0, -38)
		SetMoverPosition('ObjectiveFrameMover', 'TOPRIGHT', E.UIParent, 'TOPRIGHT', -200, -281)
		SetMoverPosition('AltPowerBarMover', 'TOP', E.UIParent, 'TOP', 1, -272)
		SetMoverPosition('ElvAB_4', 'BOTTOMRIGHT', E.UIParent, 'BOTTOMRIGHT', 0, 367)
		SetMoverPosition('Bottom_Panel_Mover', 'BOTTOM', E.UIParent, 'BOTTOM', 260, 1)
		SetMoverPosition('LossControlMover', 'BOTTOM', E.UIParent, 'BOTTOM', 0, 399)
		SetMoverPosition('ElvUF_TargetTargetMover', 'BOTTOM', E.UIParent, 'BOTTOM', 0, 169)
		SetMoverPosition('ElvUF_PetMover', 'BOTTOM', E.UIParent, 'BOTTOM', 0, 135)
		SetMoverPosition('ElvUF_PetCastbarMover', 'BOTTOM', E.UIParent, 'BOTTOM', 0, 114)
		SetMoverPosition('MarkMover', 'BOTTOM', E.UIParent, 'BOTTOM', 0, 167)
		SetMoverPosition('PlayerPortraitMover', 'BOTTOMLEFT', E.UIParent, 'BOTTOMLEFT', 584, 177)
		SetMoverPosition('ElvUF_RaidpetMover', 'TOPLEFT', E.UIParent, 'BOTTOMLEFT', 2, 698)
		SetMoverPosition('LootFrameMover', 'TOPRIGHT', E.UIParent, 'TOPRIGHT', -495, -457)
		SetMoverPosition('BossButton', 'BOTTOMLEFT', E.UIParent, 'BOTTOMLEFT', 524, 131)
		SetMoverPosition('ElvUF_Raid10Mover', 'BOTTOM', E.UIParent, 'BOTTOM', 1, 282)
		SetMoverPosition('NemoMover', 'TOP', E.UIParent, 'TOP', -277, -540)
		SetMoverPosition('BuffsMover', 'TOPRIGHT', E.UIParent, 'TOPRIGHT', -183, -9)
		SetMoverPosition('ElvUF_FocusTargetMover', 'BOTTOMRIGHT', E.UIParent, 'BOTTOMRIGHT', -484, 268)
		SetMoverPosition('MinimapButtonAnchor', 'TOPRIGHT', E.UIParent, 'TOPRIGHT', -5, -231)
		SetMoverPosition('ElvUF_FocusCastbarMover', 'BOTTOMRIGHT', E.UIParent, 'BOTTOMRIGHT', -484, 230)
	end
	
	-- Addons
	-- AddOnSkins
	if IsAddOnLoaded('AddOnSkins') then
		do
			-- reset the embeds in case of Skada/Recount swap
			E.private['addonskins']['EmbedSystem'] = nil
			E.private['addonskins']['EmbedSystemDual'] = nil
			E.private['addonskins']['EmbedBelowTop'] = nil
			E.private['addonskins']['TransparentEmbed'] = nil
			E.private['addonskins']['RecountBackdrop'] = false
			E.private['addonskins']['EmbedMain'] = nil
			E.private['addonskins']['EmbedLeft'] = nil
			E.private['addonskins']['EmbedRight'] = nil
			
			if IsAddOnLoaded('Skada') then
				E.private['addonskins']['EmbedSystem'] = false
				E.private['addonskins']['EmbedSystemDual'] = true
				E.private['addonskins']['EmbedBelowTop'] = false
				E.private['addonskins']['TransparentEmbed'] = true
				E.private['addonskins']['SkadaBackdrop'] = false
				E.private['addonskins']['EmbedMain'] = 'Skada'
				E.private['addonskins']['EmbedLeft'] = 'Skada'
				E.private['addonskins']['EmbedRight'] = 'Skada'
			end
		end
	end
	
	-- BenikUI
	if E.db.bui == nil then E.db.bui = {} end
	if IsAddOnLoaded('ElvUI_BenikUI') then
		do
			E.db.bui.gameMenuColor = 1
			E.db.bui.styledChatDts = true
			E.db.bui.garrisonCurrency = true
			E.db.bui.middleDatatext.styled = true
			E.db.bui.middleDatatext.backdrop = true
			E.db.bui.middleDatatext.width = 423
			E.db.bui.transparentDts = true
			E.db.bui.garrisonCurrencyOil = true
			E.db.bui.LoginMsg = false
			E.db.bui.StyleColor = 1
			E.db.bui.abStyleColor = 1
			E.db.dashboards.system.enableSystem = false
			E.db.dashboards.tokens.enableTokens = false
			E.db.dashboards.professions.enableProfessions = false
			E.db.datatexts.panels.BuiRightChatDTPanel.right = 'BuiMail'
			E.db.datatexts.panels.BuiRightChatDTPanel.left = 'Skada'
			E.db.datatexts.panels.BuiRightChatDTPanel.middle = 'Garrison+ (BenikUI)'
			if role == 'tank' then
				E.db.datatexts.panels.BuiLeftChatDTPanel.right = 'Attack Power'
			elseif role == 'dpsMelee' then
				E.db.datatexts.panels.BuiLeftChatDTPanel.right = 'Attack Power'
			elseif role == 'healer' or 'dpsCaster' then
				E.db.datatexts.panels.BuiLeftChatDTPanel.right = 'Spell/Heal Power'
			end
			E.db.datatexts.panels.BuiLeftChatDTPanel.left = 'MUI Talent/Loot Specialization'
			E.db.datatexts.panels.BuiLeftChatDTPanel.middle = 'Durability'
			E.db.datatexts.panels.BuiMiddleDTPanel.right = 'S&L Currency'
			E.db.datatexts.panels.BuiMiddleDTPanel.left = 'Improved System'
			E.db.datatexts.panels.BuiMiddleDTPanel.middle = 'Time'
		end
	end
	
	-- LocationPlus
	if E.db.locplus == nil then E.db.locplus = {} end
	if IsAddOnLoaded('ElvUI_LocPlus') then
		do
			E.db.locplus.lpfont = 'Merathilis Roadway'
			E.db.locplus.dtheight = 17
			E.db.locplus.fish = false
			E.db.locplus.lpwidth = 220
			E.db.locplus.petlevel = false
			E.db.locplus.ttreczones = false
			E.db.locplus.ttinst = false
			E.db.locplus.lpfontsize = 16
			E.db.locplus.lpfontflags = 'OUTLINE'
			E.db.locplus.ttrecinst = false
			E.db.locplus.ht = true
			E.db.locplus.displayOther = 'NONE'
			E.db.locplus.profcap = true
			E.db.locplus.shadow = true
			E.db.locplus.customCoordsColor = 1
			E.db.locplus.dig = false
			E.db.locplus.showicon = false
			E.db.locplus.ttlvl = false
			E.db.datatexts.panels.LeftCoordDtPanel = 'S&L Guild'
			E.db.datatexts.panels.RightCoordDtPanel = 'S&L Friends'
		end
	end
	
	-- ElvUI_VisualAuraTimer
	if IsAddOnLoaded('ElvUI_VisualAuraTimers') then
		do
			E.db.VAT.enableStaticColor = true
			E.db.VAT.barHeight = 6
			E.db.VAT.spacing = 0
			E.db.VAT.staticColor.r = 1
			E.db.VAT.staticColor.g = 0.5
			E.db.VAT.staticColor.b = 0
			E.db.VAT.showText = false
			E.db.VAT.colors.minutesIndicator.r = 1
			E.db.VAT.colors.minutesIndicator.g = 0.5
			E.db.VAT.colors.minutesIndicator.b = 0
			E.db.VAT.colors.hourminutesIndicator.r = 1
			E.db.VAT.colors.hourminutesIndicator.g = 0.5
			E.db.VAT.colors.hourminutesIndicator.b = 0
			E.db.VAT.colors.expireIndicator.r = 1
			E.db.VAT.colors.expireIndicator.g = 0.5
			E.db.VAT.colors.expireIndicator.b = 0
			E.db.VAT.colors.secondsIndicator.r = 1
			E.db.VAT.colors.secondsIndicator.g = 0.5
			E.db.VAT.colors.secondsIndicator.b = 0
			E.db.VAT.colors.daysIndicator.r = 1
			E.db.VAT.colors.daysIndicator.g = 0.5
			E.db.VAT.colors.daysIndicator.b = 0
			E.db.VAT.colors.hoursIndicator.r = 1
			E.db.VAT.colors.hoursIndicator.r = 0.5
			E.db.VAT.colors.hoursIndicator.r = 0
			E.db.VAT.decimalThreshold = 5
			E.db.VAT.statusbarTexture = 'MerathilisFlat'
			E.db.VAT.position = 'TOP'
		end
	end
	
	-- Skada
	if IsAddOnLoaded('Skada') then
		do
			SkadaDB['profiles']['Merathilis'] = {
				["windows"] = {
					{
						["titleset"] = false,
						["barslocked"] = true,
						["y"] = 56.2857055664063,
						["x"] = 1459.28596496582,
						["title"] = {
							["color"] = {
								["a"] = 0,
								["r"] = 0.101960784313725,
								["g"] = 0.101960784313725,
								["b"] = 0.301960784313726,
							},
							["font"] = "Merathilis Roadway",
							["fontsize"] = 10,
							["borderthickness"] = 0,
							["fontflags"] = "",
							["height"] = 17,
							["texture"] = "MerathilisFlat",
						},
						["barfontflags"] = "OUTLINE",
						["point"] = "TOPRIGHT",
						["barbgcolor"] = {
							["a"] = 0,
							["b"] = 0.301960784313726,
							["g"] = 0.301960784313726,
							["r"] = 0.301960784313726,
						},
						["barcolor"] = {
							["a"] = 0,
							["g"] = 0.301960784313726,
							["r"] = 0.301960784313726,
						},
						["barfontsize"] = 10,
						["mode"] = "Schaden",
						["spark"] = false,
						["bartexture"] = "MerathilisOnePixel",
						["barwidth"] = 181.000015258789,
						["barspacing"] = 1,
						["enabletitle"] = true,
						["classcolortext"] = true,
						["reversegrowth"] = false,
						["background"] = {
							["height"] = 124.373611450195,
						},
						["barfont"] = "Merathilis Prototype",
						["name"] = "DPS",
					}, -- [1]
					{
						["barheight"] = 16,
						["classicons"] = false,
						["barslocked"] = true,
						["enabletitle"] = true,
						["wipemode"] = "",
						["set"] = "current",
						["hidden"] = false,
						["y"] = 9.37583923339844,
						["barfont"] = "Merathilis Prototype",
						["name"] = "HPS",
						["display"] = "bar",
						["barfontflags"] = "",
						["classcolortext"] = true,
						["scale"] = 1,
						["reversegrowth"] = false,
						["barfontsize"] = 10,
						["barorientation"] = 1,
						["snapto"] = true,
						["version"] = 1,
						["title"] = {
							["color"] = {
								["a"] = 0.800000011920929,
								["b"] = 0.301960784313726,
								["g"] = 0.101960784313725,
								["r"] = 0.101960784313725,
							},
							["bordertexture"] = "None",
							["font"] = "Merathilis Roadway",
							["borderthickness"] = 0,
							["fontsize"] = 17,
							["fontflags"] = "OUTLINE",
							["height"] = 15,
							["margin"] = 0,
							["texture"] = "MerathilisFlat",
						},
						["buttons"] = {
							["segment"] = true,
							["menu"] = true,
							["stop"] = true,
							["mode"] = true,
							["report"] = true,
							["reset"] = true,
						},
						["spark"] = false,
						["bartexture"] = "MerathilisOnePixel",
						["barwidth"] = 205.428512573242,
						["barspacing"] = 1,
						["clickthrough"] = false,
						["point"] = "TOPRIGHT",
						["background"] = {
							["borderthickness"] = 0,
							["color"] = {
								["a"] = 0.2,
								["r"] = 0,
								["g"] = 0,
								["b"] = 0.5,
							},
							["height"] = 140.42854309082,
							["bordertexture"] = "None",
							["margin"] = 0,
							["texture"] = "Solid",
						},
						["barcolor"] = {
							["a"] = 0,
							["b"] = 0.8,
							["g"] = 0.301960784313726,
							["r"] = 0.301960784313726,
						},
						["barbgcolor"] = {
							["a"] = 0,
							["b"] = 0.301960784313726,
							["g"] = 0.301960784313726,
							["r"] = 0.301960784313726,
						},
						["classcolorbars"] = true,
						["modeincombat"] = "",
						["returnaftercombat"] = false,
						["mode"] = "Heilung",
						["x"] = 1675.83778381348,
					}, -- [2]
				},		
			}
		end
	end
	
	if IsAddOnLoaded('BigWigs') then
		do
			BigWigs3DB = {
				["profileKeys"] = {
					["Merathilîs - Shattrath"] = "Default",
					["Merathilis - Shattrath"] = "Merathilis-Eule",
					["Garét - Shattrath"] = "Default",
					["Asragoth - Shattrath"] = "Default",
					["Jahzzy - Garrosh"] = "Default",
					["Melisendra - Shattrath"] = "Default",
					["Damará - Shattrath"] = "Merathilis-Heal",
					["Maithilis - Shattrath"] = "Default",
					["Róhal - Shattrath"] = "Default",
					["Brítt - Shattrath"] = "Default",
					["Missthilis - Garrosh"] = "Default",
					["Meramage - Garrosh"] = "Default",
				},
				["namespaces"] = {
					["BigWigs_Bosses_The Iron Maidens"] = {
						["profiles"] = {
							["Merathilis-Eule"] = {
								["custom_off_heartseeker_marker"] = true,
							},
						},
					},
					["BigWigs_Bosses_Mannoroth"] = {
						["profiles"] = {
							["Merathilis-Eule"] = {
								[181597] = 547,
								["custom_off_gaze_marker"] = true,
								[181799] = 515,
							},
							["Default"] = {
								[181354] = 67075,
							},
						},
					},
					["BigWigs_Plugins_Alt Power"] = {
						["profiles"] = {
							["Merathilis-Eule"] = {
								["posx"] = 810.718497504029,
								["fontSize"] = 10.9999990463257,
								["font"] = "Merathilis Prototype",
								["fontOutline"] = "",
								["lock"] = true,
								["posy"] = 202.206108761591,
							},
							["Default"] = {
								["posx"] = 745.62137594281,
								["fontSize"] = 10.9999990463257,
								["font"] = "Bui Prototype",
								["fontOutline"] = "",
								["posy"] = 278.274528269621,
							},
							["Merathilis-Heal"] = {
								["posx"] = 806.329889857589,
								["fontSize"] = 10.9999990463257,
								["fontOutline"] = "",
								["font"] = "Merathilis Prototype",
								["posy"] = 263.645846042418,
							},
							["Damará - Shattrath"] = {
								["posx"] = 822.421435898214,
								["fontSize"] = 10.9999990463257,
								["fontOutline"] = "",
								["font"] = "Bui Prototype",
								["posy"] = 244.628843871305,
							},
						},
					},
					["LibDualSpec-1.0"] = {
						["char"] = {
							["Merathilis - Shattrath"] = {
								["profile"] = "Merathilis-Heal",
								["enabled"] = true,
								["specGroup"] = 1,
							},
							["Damará - Shattrath"] = {
								["profile"] = "Damará - Shattrath",
								["specGroup"] = 1,
								["enabled"] = true,
							},
						},
					},
					["BigWigs_Bosses_Archimonde"] = {
						["profiles"] = {
							["Merathilis-Heal"] = {
								[187180] = 579,
								[183817] = 0,
							},
						},
					},
					["BigWigs_Bosses_Will of the Emperor"] = {
						["profiles"] = {
							["Merathilis-Eule"] = {
								["combo"] = 33283,
								["arc"] = 33283,
							},
						},
					},
					["BigWigs_Plugins_Victory"] = {
					},
					["BigWigs_Plugins_Statistics"] = {
					},
					["BigWigs_Plugins_Sounds"] = {
					},
					["BigWigs_Plugins_Messages"] = {
						["profiles"] = {
							["Merathilis-Eule"] = {
								["BWEmphasizeMessageAnchor_x"] = 548.018613931999,
								["BWEmphasizeCountdownMessageAnchor_x"] = 594.167263362324,
								["BWMessageAnchor_x"] = 547.937125897879,
								["chat"] = false,
								["BWEmphasizeCountdownMessageAnchor_y"] = 542.227131600485,
								["font"] = "Merathilis Prototype",
								["BWEmphasizeMessageAnchor_y"] = 634.599967567738,
								["BWMessageAnchor_y"] = 482.660092769766,
								["growUpwards"] = true,
								["fontSize"] = 20,
							},
							["Default"] = {
								["fontSize"] = 20,
								["BWEmphasizeCountdownMessageAnchor_x"] = 594.167263362324,
								["chat"] = false,
								["BWEmphasizeMessageAnchor_y"] = 634.599967567738,
								["BWMessageAnchor_y"] = 482.660092769766,
								["BWMessageAnchor_x"] = 547.937125897879,
								["growUpwards"] = true,
								["BWEmphasizeCountdownMessageAnchor_y"] = 542.227131600485,
								["font"] = "Bui Prototype",
								["BWEmphasizeMessageAnchor_x"] = 548.018613931999,
							},
							["Merathilis-Heal"] = {
								["BWEmphasizeMessageAnchor_x"] = 548.018613931999,
								["BWEmphasizeCountdownMessageAnchor_x"] = 594.167263362324,
								["BWMessageAnchor_x"] = 547.937125897879,
								["chat"] = false,
								["BWEmphasizeCountdownMessageAnchor_y"] = 542.227131600485,
								["font"] = "Merathilis Prototype",
								["BWEmphasizeMessageAnchor_y"] = 634.599967567738,
								["BWMessageAnchor_y"] = 482.660092769766,
								["growUpwards"] = true,
								["fontSize"] = 20,
							},
							["Damará - Shattrath"] = {
								["BWEmphasizeMessageAnchor_x"] = 548.018613931999,
								["BWEmphasizeCountdownMessageAnchor_x"] = 594.167263362324,
								["BWMessageAnchor_x"] = 547.937125897879,
								["chat"] = false,
								["BWEmphasizeCountdownMessageAnchor_y"] = 542.227131600485,
								["font"] = "Bui Prototype",
								["BWEmphasizeMessageAnchor_y"] = 634.599967567738,
								["BWMessageAnchor_y"] = 482.660092769766,
								["fontSize"] = 20,
								["growUpwards"] = true,
							},
						},
					},
					["BigWigs_Bosses_Kilrogg Deadeye"] = {
						["profiles"] = {
							["Default"] = {
								[182428] = 66051,
							},
						},
					},
					["BigWigs_Plugins_Proximity"] = {
						["profiles"] = {
							["Merathilis-Eule"] = {
								["fontSize"] = 20,
								["width"] = 140.000030517578,
								["posy"] = 139.937301559658,
								["lock"] = false,
								["posx"] = 316.168293714338,
								["sound"] = true,
								["font"] = "Merathilis Prototype",
							},
							["Default"] = {
								["fontSize"] = 20,
								["font"] = "Bui Prototype",
								["posx"] = 302.271253561194,
								["lock"] = true,
								["posy"] = 284.759955070203,
							},
							["Merathilis-Heal"] = {
								["posx"] = 302.271253561194,
								["fontSize"] = 20,
								["lock"] = true,
								["posy"] = 284.759955070203,
								["font"] = "Merathilis Prototype",
							},
							["Damará - Shattrath"] = {
								["posx"] = 302.271253561194,
								["fontSize"] = 20,
								["lock"] = true,
								["font"] = "Bui Prototype",
								["posy"] = 284.759955070203,
							},
						},
					},
					["BigWigs_Plugins_BossBlock"] = {
					},
					["BigWigs_Plugins_HeroesVoices"] = {
					},
					["BigWigs_Bosses_Blackhand"] = {
						["profiles"] = {
							["Default"] = {
								[155992] = 66051,
								["custom_off_markedfordeath_marker"] = true,
								["custom_off_massivesmash_marker"] = true,
							},
						},
					},
					["BigWigs_Plugins_Raid Icons"] = {
					},
					["BigWigs_Plugins_Bars"] = {
						["profiles"] = {
							["Merathilis-Eule"] = {
								["outline"] = "OUTLINE",
								["fontSize"] = 20,
								["scale"] = 0.9,
								["BigWigsAnchor_y"] = 143.539996791631,
								["emphasizeGrowup"] = true,
								["BigWigsAnchor_x"] = 951.685603728169,
								["texture"] = "MerathilisFlat",
								["emphasizeTime"] = 14,
								["barStyle"] = "AddOnSkins Half-Bar",
								["monochrome"] = false,
								["BigWigsEmphasizeAnchor_x"] = 445.301161921743,
								["font"] = "Merathilis Roadway",
								["BigWigsEmphasizeAnchor_y"] = 188.360327821069,
								["fill"] = false,
								["BigWigsAnchor_width"] = 363.885375976563,
								["BigWigsEmphasizeAnchor_width"] = 532.931091308594,
								["emphasizeScale"] = 1.1,
							},
							["Default"] = {
								["outline"] = "OUTLINE",
								["fontSize"] = 20,
								["BigWigsAnchor_width"] = 359.456695556641,
								["BigWigsAnchor_y"] = 142.077037839956,
								["emphasizeGrowup"] = true,
								["BigWigsAnchor_x"] = 948.759744418567,
								["BigWigsEmphasizeAnchor_width"] = 271.126495361328,
								["texture"] = "BuiFlat",
								["barStyle"] = "AddOnSkins Half-Bar",
								["monochrome"] = false,
								["BigWigsEmphasizeAnchor_x"] = 217.095424835039,
								["font"] = "Bui Roadway",
								["BigWigsEmphasizeAnchor_y"] = 327.332023933559,
								["emphasizeTime"] = 14,
								["scale"] = 0.9,
								["emphasizeScale"] = 1.1,
							},
							["Merathilis-Heal"] = {
								["BigWigsEmphasizeAnchor_y"] = 385.845841560149,
								["fontSize"] = 20,
								["emphasizeTime"] = 14,
								["BigWigsAnchor_y"] = 146.466003386204,
								["scale"] = 0.9,
								["BigWigsEmphasizeAnchor_width"] = 324.755065917969,
								["BigWigsEmphasizeAnchor_x"] = 165.895295733844,
								["barStyle"] = "AddOnSkins Half-Bar",
								["monochrome"] = false,
								["emphasizeGrowup"] = true,
								["BigWigsAnchor_x"] = 945.102742433446,
								["font"] = "Merathilis Roadway",
								["outline"] = "OUTLINE",
								["BigWigsAnchor_width"] = 357.538421630859,
								["emphasizeScale"] = 1.1,
								["texture"] = "MerathilisFlat",
							},
							["Damará - Shattrath"] = {
								["outline"] = "OUTLINE",
								["fontSize"] = 9,
								["texture"] = "BuiMelliDark",
								["BigWigsEmphasizeAnchor_width"] = 324.755065917969,
								["BigWigsAnchor_width"] = 390.171173095703,
								["BigWigsAnchor_y"] = 154.511568124053,
								["BigWigsEmphasizeAnchor_x"] = 165.895295733844,
								["scale"] = 0.9,
								["BigWigsEmphasizeAnchor_y"] = 385.845841560149,
								["emphasizeGrowup"] = true,
								["BigWigsAnchor_x"] = 933.399886417392,
								["font"] = "Bui Prototype",
								["monochrome"] = false,
								["barStyle"] = "AddOnSkins Half-Bar",
								["emphasizeScale"] = 1.1,
								["emphasizeTime"] = 14,
							},
						},
					},
					["BigWigs_Plugins_ThogarBarColors"] = {
					},
					["BigWigs_Bosses_Fel Lord Zakuun"] = {
						["profiles"] = {
							["Merathilis-Eule"] = {
								[179583] = 66051,
							},
						},
					},
					["BigWigs_Plugins_Super Emphasize"] = {
						["profiles"] = {
							["Merathilis-Eule"] = {
								["font"] = "Merathilis Prototype",
							},
							["Default"] = {
								["font"] = "Bui Prototype",
							},
							["Merathilis-Heal"] = {
								["font"] = "Merathilis Prototype",
							},
							["Damará - Shattrath"] = {
								["font"] = "Bui Prototype",
							},
						},
					},
					["BigWigs_Bosses_Gorefiend"] = {
						["profiles"] = {
							["Merathilis-Eule"] = {
								[181295] = 66307,
							},
						},
					},
					["BigWigs_Bosses_Hans'gar and Franzok"] = {
						["profiles"] = {
							["Merathilis-Eule"] = {
								["stages"] = 66051,
								[162124] = 66051,
							},
						},
					},
					["BigWigs_Bosses_Shadow-Lord Iskar"] = {
						["profiles"] = {
							["Merathilis-Heal"] = {
								["custom_off_wind_marker"] = true,
								[181753] = 547,
							},
						},
					},
					["BigWigs_Plugins_Colors"] = {
					},
					["BigWigs_Plugins_Respawn"] = {
					},
					["BigWigs_Bosses_Xhul'horac"] = {
						["profiles"] = {
							["Default"] = {
								[190224] = 1539,
								[190223] = 1539,
								[186453] = 4611,
							},
						},
					},
					["BigWigs_Bosses_Tyrant Velhari"] = {
						["profiles"] = {
							["Merathilis-Heal"] = {
								[182459] = 615,
							},
						},
					},
					["BigWigs_Bosses_Iron Reaver"] = {
						["profiles"] = {
							["Merathilis-Heal"] = {
								[185282] = 515,
							},
						},
					},
				},
				["global"] = {
					["watchedMovies"] = {
						["993:2"] = true,
						["984:1"] = {
							true, -- [1]
							[3] = true,
						},
						["964:1"] = true,
						["969:2"] = true,
						[294] = true,
						[295] = true,
						["994:3"] = true,
						["993:4"] = true,
					},
				},
				["profiles"] = {
					["Merathilis-Eule"] = {
						["fakeDBMVersion"] = true,
					},
					["Default"] = {
						["fakeDBMVersion"] = true,
					},
					["Merathilis-Heal"] = {
						["fakeDBMVersion"] = true,
					},
					["Damará - Shattrath"] = {
						["fakeDBMVersion"] = true,
					},
				},
			}
			BigWigs3IconDB = {
				["hide"] = true,
			}
		end
	end
	
	if IsAddOnLoaded('xCT+') then
		do
			xCTSavedDB['profiles']["Merathilis - Shattrath"] = {
				["frames"] = {
					["general"] = {
						["fontOutline"] = "2OUTLINE",
						["font"] = "Merathilis Tukui",
						["colors"] = {
							["auras"] = {
								["colors"] = {
									["debuffsGained"] = {
										["color"] = {
											1, -- [1]
											0.1, -- [2]
											0.1, -- [3]
										},
									},
									["buffsGained"] = {
										["color"] = {
											1, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
									["buffsFaded"] = {
										["color"] = {
											0.5, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
									["debuffsFaded"] = {
										["color"] = {
											0.5, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
								},
							},
							["killingBlow"] = {
								["color"] = {
									0.2, -- [1]
									1, -- [2]
									0.2, -- [3]
								},
							},
							["combat"] = {
								["colors"] = {
									["combatLeaving"] = {
										["color"] = {
											0.1, -- [1]
											1, -- [2]
											0.1, -- [3]
										},
									},
									["combatEntering"] = {
										["color"] = {
											1, -- [1]
											0.1, -- [2]
											0.1, -- [3]
										},
									},
								},
							},
							["interrupts"] = {
								["color"] = {
									1, -- [1]
									0.5, -- [2]
									0, -- [3]
								},
							},
							["reputation"] = {
								["colors"] = {
									["reputationGain"] = {
										["color"] = {
											0.1, -- [1]
											0.1, -- [2]
											1, -- [3]
										},
									},
									["reputationLoss"] = {
										["color"] = {
											1, -- [1]
											0.1, -- [2]
											0.1, -- [3]
										},
									},
								},
							},
							["lowResources"] = {
								["colors"] = {
									["lowResourcesMana"] = {
										["color"] = {
											1, -- [1]
											0.1, -- [2]
											0.1, -- [3]
										},
									},
									["lowResourcesHealth"] = {
										["color"] = {
											1, -- [1]
											0.1, -- [2]
											0.1, -- [3]
										},
									},
								},
							},
							["honorGains"] = {
								["color"] = {
									0.1, -- [1]
									0.1, -- [2]
									1, -- [3]
								},
							},
							["dispells"] = {
								["colors"] = {
									["dispellBuffs"] = {
										["color"] = {
											0, -- [1]
											1, -- [2]
											0.5, -- [3]
										},
									},
									["dispellStolen"] = {
										["color"] = {
											0.31, -- [1]
											0.71, -- [2]
											1, -- [3]
										},
									},
									["dispellDebuffs"] = {
										["color"] = {
											1, -- [1]
											0, -- [2]
											0.5, -- [3]
										},
									},
								},
							},
						},
						["enabledFrame"] = false,
					},
					["power"] = {
						["enabledFrame"] = false,
						["font"] = "Merathilis Tukui",
						["colors"] = {
							["color_SOUL_SHARDS"] = {
								["color"] = {
									0.5, -- [1]
									0.32, -- [2]
									0.55, -- [3]
								},
							},
							["color_HOLY_POWER"] = {
								["color"] = {
									0.95, -- [1]
									0.9, -- [2]
									0.6, -- [3]
								},
							},
							["color_MANA"] = {
								["color"] = {
									0, -- [1]
									0, -- [2]
									1, -- [3]
								},
							},
							["color_FOCUS"] = {
								["color"] = {
									1, -- [1]
									0.5, -- [2]
									0.25, -- [3]
								},
							},
							["color_CHI"] = {
								["color"] = {
									0.71, -- [1]
									1, -- [2]
									0.92, -- [3]
								},
							},
							["color_RAGE"] = {
								["color"] = {
									1, -- [1]
									0, -- [2]
									0, -- [3]
								},
							},
							["color_ENERGY"] = {
								["color"] = {
									1, -- [1]
									1, -- [2]
									0, -- [3]
								},
							},
							["color_RUNIC_POWER"] = {
								["color"] = {
									0, -- [1]
									0.82, -- [2]
									1, -- [3]
								},
							},
							["color_ECLIPSE_positive"] = {
								["color"] = {
									0.8, -- [1]
									0.82, -- [2]
									0.6, -- [3]
								},
							},
							["color_RUNES"] = {
								["color"] = {
									0.5, -- [1]
									0.5, -- [2]
									0.5, -- [3]
								},
							},
							["color_ECLIPSE_negative"] = {
								["color"] = {
									0.3, -- [1]
									0.52, -- [2]
									0.9, -- [3]
								},
							},
						},
						["fontOutline"] = "2OUTLINE",
					},
					["healing"] = {
						["enableRealmNames"] = false,
						["fontSize"] = 12,
						["Width"] = 68,
						["showFriendlyHealers"] = false,
						["X"] = -109,
						["colors"] = {
							["healingTakenCritical"] = {
								["color"] = {
									0.1, -- [1]
									1, -- [2]
									0.1, -- [3]
								},
							},
							["healingTaken"] = {
								["color"] = {
									0.1, -- [1]
									0.75, -- [2]
									0.1, -- [3]
								},
							},
							["healingTakenPeriodic"] = {
								["color"] = {
									0.1, -- [1]
									0.5, -- [2]
									0.1, -- [3]
								},
							},
							["shieldTaken"] = {
								["color"] = {
									0.6, -- [1]
									0.65, -- [2]
									1, -- [3]
								},
							},
							["healingTakenPeriodicCritical"] = {
								["color"] = {
									0.1, -- [1]
									0.5, -- [2]
									0.1, -- [3]
								},
							},
						},
						["fontOutline"] = "2OUTLINE",
						["Height"] = 218,
						["font"] = "Merathilis Tukui",
						["Y"] = -18,
					},
					["outgoing"] = {
						["Y"] = 29,
						["fontSize"] = 12,
						["colors"] = {
							["genericDamage"] = {
								["color"] = {
									1, -- [1]
									0.82, -- [2]
									0, -- [3]
								},
							},
							["healingSpells"] = {
								["colors"] = {
									["healingOut"] = {
										["color"] = {
											0.1, -- [1]
											0.75, -- [2]
											0.1, -- [3]
										},
									},
									["shieldOut"] = {
										["color"] = {
											0.6, -- [1]
											0.65, -- [2]
											1, -- [3]
										},
									},
									["healingOutPeriodic"] = {
										["color"] = {
											0.1, -- [1]
											0.5, -- [2]
											0.1, -- [3]
										},
									},
								},
							},
							["spellSchools"] = {
								["colors"] = {
									["SpellSchool_Nature"] = {
										["color"] = {
											0.3, -- [1]
											1, -- [2]
											0.3, -- [3]
										},
									},
									["SpellSchool_Arcane"] = {
										["color"] = {
											1, -- [1]
											0.5, -- [2]
											1, -- [3]
										},
									},
									["SpellSchool_Frost"] = {
										["color"] = {
											0.5, -- [1]
											1, -- [2]
											1, -- [3]
										},
									},
									["SpellSchool_Physical"] = {
										["color"] = {
											1, -- [1]
											1, -- [2]
											0, -- [3]
										},
									},
									["SpellSchool_Shadow"] = {
										["color"] = {
											0.5, -- [1]
											0.5, -- [2]
											1, -- [3]
										},
									},
									["SpellSchool_Holy"] = {
										["color"] = {
											1, -- [1]
											0.9, -- [2]
											0.5, -- [3]
										},
									},
									["SpellSchool_Fire"] = {
										["color"] = {
											1, -- [1]
											0.5, -- [2]
											0, -- [3]
										},
									},
								},
							},
							["misstypesOut"] = {
								["color"] = {
									0.5, -- [1]
									0.5, -- [2]
									0.5, -- [3]
								},
							},
						},
						["fontOutline"] = "2OUTLINE",
						["Height"] = 317,
						["font"] = "Merathilis Tukui",
						["X"] = 231,
						["Width"] = 122,
					},
					["critical"] = {
						["Y"] = 29,
						["fontSize"] = 12,
						["colors"] = {
							["genericDamageCritical"] = {
								["color"] = {
									1, -- [1]
									1, -- [2]
									0, -- [3]
								},
							},
							["healingSpells"] = {
								["colors"] = {
									["healingOutCritical"] = {
										["color"] = {
											0.1, -- [1]
											1, -- [2]
											0.1, -- [3]
										},
									},
								},
							},
						},
						["fontOutline"] = "2OUTLINE",
						["Height"] = 317,
						["font"] = "Merathilis Tukui",
						["X"] = 150,
						["Width"] = 96,
					},
					["procs"] = {
						["fontOutline"] = "2OUTLINE",
						["font"] = "Merathilis Tukui",
						["colors"] = {
							["spellReactive"] = {
								["color"] = {
									1, -- [1]
									0.82, -- [2]
									0, -- [3]
								},
							},
							["spellProc"] = {
								["color"] = {
									1, -- [1]
									0.82, -- [2]
									0, -- [3]
								},
							},
						},
						["enabledFrame"] = false,
					},
					["loot"] = {
						["font"] = "Merathilis Tukui",
						["fontOutline"] = "2OUTLINE",
						["enabledFrame"] = false,
					},
					["class"] = {
						["enabledFrame"] = false,
						["font"] = "Merathilis Tukui",
						["colors"] = {
							["comboPoints"] = {
								["color"] = {
									1, -- [1]
									0.82, -- [2]
									0, -- [3]
								},
							},
							["comboPointsMax"] = {
								["color"] = {
									0, -- [1]
									0.82, -- [2]
									1, -- [3]
								},
							},
						},
						["fontOutline"] = "2OUTLINE",
					},
					["damage"] = {
						["fontSize"] = 12,
						["Width"] = 131,
						["Y"] = -18,
						["X"] = -210,
						["colors"] = {
							["missTypesTaken"] = {
								["colors"] = {
									["missTypeBlock"] = {
										["color"] = {
											0.5, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
									["missTypeMiss"] = {
										["color"] = {
											0.5, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
									["missTypeImmune"] = {
										["color"] = {
											0.5, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
									["missTypeDodge"] = {
										["color"] = {
											0.5, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
									["missTypeParry"] = {
										["color"] = {
											0.5, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
									["missTypeResist"] = {
										["color"] = {
											0.5, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
									["missTypeEvade"] = {
										["color"] = {
											0.5, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
									["missTypeAbsorb"] = {
										["color"] = {
											0.5, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
									["missTypeReflect"] = {
										["color"] = {
											0.5, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
									["missTypeDeflect"] = {
										["color"] = {
											0.5, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
								},
							},
							["damageTakenCritical"] = {
								["color"] = {
									1, -- [1]
									0.1, -- [2]
									0.1, -- [3]
								},
							},
							["spellDamageTaken"] = {
								["color"] = {
									0.75, -- [1]
									0.3, -- [2]
									0.85, -- [3]
								},
							},
							["spellDamageTakenCritical"] = {
								["color"] = {
									0.75, -- [1]
									0.3, -- [2]
									0.85, -- [3]
								},
							},
							["damageTaken"] = {
								["color"] = {
									0.75, -- [1]
									0.1, -- [2]
									0.1, -- [3]
								},
							},
							["missTypesTakenPartial"] = {
								["colors"] = {
									["missTypeBlockPartial"] = {
										["color"] = {
											0.75, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
									["missTypeResistPartial"] = {
										["color"] = {
											0.75, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
									["missTypeAbsorbPartial"] = {
										["color"] = {
											0.75, -- [1]
											0.5, -- [2]
											0.5, -- [3]
										},
									},
								},
							},
						},
						["fontOutline"] = "2OUTLINE",
						["Height"] = 218,
						["font"] = "Merathilis Tukui",
						["insertText"] = "bottom",
					},
				},
				["dbVersion"] = "4.1.6",
			}
		end
	end

	-- AddonMovers
	do
		SetMoverPosition('LocationLiteMover', 'TOP', E.UIParent, 'TOP', 0, -7)
		SetMoverPosition('BuiMiddleDtMover', 'BOTTOM', E.UIParent, 'BOTTOM', 0, 2)
	end
	E:UpdateAll(true)
	
	print('MerathilisUI Setup is done. Please Reload')
	-- Setup is done so set our option to true, so the Setup won't run again on this player.
	-- Enable it when you are done with the settings
	
	E.db.Merathilis.installed = true
end
