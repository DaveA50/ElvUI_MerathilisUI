local MER, F, E, L, V, P, G = unpack(select(2, ...))

V.general = {
	install_complete = nil,
}

V.misc = {
	guildNewsItemLevel = true,
}

V.skins = {
	enable = true,
	style = true,
	shadowOverlay = false,
	toggleDirection = 1,
	shadow = {
		enable = true,
		increasedSize = 0,
		color = {
			r = 0,
			g = 0,
			b = 0
		},
	},
	widgets = {
		button = {
			enable = true,
			backdrop = {
				enable = true,
				texture = "MER_NormTex",
				classColor = false,
				color = {r = 0, g = 0.752, b = 0.980},
				alpha = 1,
				animationType = "FADE",
				animationDuration = 0.2,
				removeBorderEffect = true
			},
			selected = {
				enable = true,
				backdropClassColor = false,
				backdropColor = {r = 0.322, g = 0.608, b = 0.961},
				backdropAlpha = 0.4,
				borderClassColor = false,
				borderColor = {r = 0.145, g = 0.353, b = 0.698},
				borderAlpha = 1
			},
			text = {
				enable = true,
				font = {
					name = E.db.general.font,
					style = "OUTLINE"
				},
			},
		},
		tab = {
			enable = true,
			backdrop = {
				enable = true,
				texture = "MER_NormTex",
				classColor = false,
				color = {r = 0, g = 0.752, b = 0.980},
				alpha = 1,
				animationType = "FADE",
				animationDuration = 0.2
			},
			selected = {
				enable = true,
				texture = "MER_NormTex",
				backdropClassColor = false,
				backdropColor = {r = 0.322, g = 0.608, b = 0.961},
				backdropAlpha = 0.4,
				borderClassColor = false,
				borderColor = {r = 0.145, g = 0.353, b = 0.698},
				borderAlpha = 1
			},
			text = {
				enable = true,
				normalClassColor = false,
				normalColor = {r = 1, g = 0.82, b = 0},
				selectedClassColor = false,
				selectedColor = {r = 1, g = 1, b = 1},
				font = {
					name = E.db.general.font,
					style = "OUTLINE"
				}
			}
		},
		checkBox = {
			enable = true,
			texture = "MER_NormTex",
			classColor = false,
			color = {r = 0, g = 0.752, b = 0.980, a = 1}
		},
		slider = {
			enable = true,
			texture = "MER_NormTex",
			classColor = false,
			color = {r = 0, g = 0.752, b = 0.980, a = 1}
		},
		treeGroupButton = {
			enable = true,
			backdrop = {
				enable = true,
				texture = "MER_NormTex",
				classColor = false,
				color = {r = 0, g = 0.752, b = 0.980},
				alpha = 1,
				animationType = "FADE",
				animationDuration = 0.2,
			},
			selected = {
				enable = true,
				texture = "MER_NormTex",
				backdropClassColor = false,
				backdropColor = {r = 0.322, g = 0.608, b = 0.961, a = 0.75},
				borderClassColor = false,
				borderColor = {r = 0.145, g = 0.353, b = 0.698, a = 0},
			},
			text = {
				enable = true,
				normalClassColor = false,
				normalColor = {r = 1, g = 0.82, b = 0},
				selectedClassColor = false,
				selectedColor = {r = 1, g = 1, b = 1},
				font = {
					name = E.db.general.font,
					style = "OUTLINE"
				}
			}
		},
	},
	blizzard = {
		enable = true,
		arena = true,
		arenaRegistrar = true,
		character = true,
		encounterjournal = true,
		gossip = true,
		quest = true,
		questChoice = true,
		spellbook = true,
		talent = true,
		auctionhouse = true,
		friends = true,
		garrison = true,
		orderhall = true,
		contribution = true,
		artifact = true,
		collections = true,
		calendar = true,
		merchant = true,
		worldmap = true,
		pvp = true,
		achievement = true,
		tradeskill = true,
		lfg = true,
		lfguild = true,
		talkinghead = true,
		guild = true,
		objectiveTracker = true,
		addonManager = true,
		mail = true,
		raid = true,
		dressingroom = true,
		timemanager = true,
		blackmarket = true,
		guildcontrol = true,
		macro = true,
		binding = true,
		gbank = true,
		taxi = true,
		help = true,
		loot = true,
		deathRecap = true,
		communities = true,
		channels = true,
		challenges = true,
		azerite = true,
		AzeriteRespec = true,
		IslandQueue = true,
		IslandsPartyPose = true,
		BFAMissions = true,
		minimap = true,
		Scrapping = true,
		trainer = true,
		debug = true,
		inspect = true,
		socket = true,
		itemUpgrade = true,
		trade = true,
		voidstorage = true,
		AlliedRaces = true,
		GMChat = true,
		Archaeology = true,
		AzeriteEssence = true,
		itemInteraction = true,
		animaDiversion = true,
		soulbinds = true,
		covenantSanctum = true,
		covenantPreview = true,
		playerChoice = true,
		chromieTime = true,
		levelUp = true,
		covenantRenown = true,
		guide = true,
		craft = true,
		eventToast = true,
		weeklyRewards = true,
		misc = true,
		tooltip = true,
		bgmap = true,
		bgscore = true,
		barber = true,
		chatBubbles = true,
		expansionLanding = true,
		majorFactions = true,
		blizzardOptions = true,
		editor = true,
	},

	addonSkins = {
		enable = true,
		ace3 = true,
		ace3DropdownBackdrop = true,
		abp = true,
		bw = true,
		xiv = true,
		bui = true,
		bs = true,
		pa = true,
		ls = true,
		dbm = true,
		cl = true,
		cbn = true,
		et = true,
		dt = true,
		wa = true,
		waOptions = true,
		waCooldowns = false,
		tldr = true,
	},

	embed = {
		enable = true,
	}
}
