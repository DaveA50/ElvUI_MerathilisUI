local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

-- Core
P['mui'] = {
	['installed'] = nil,
}

P['muiGeneral'] = {
	['LoginMsg'] = true,
	['GameMenu'] = true,
}

P['muiMisc'] = {
	['RareAlert'] = false, -- default off, because of spam using Hearthstone into Garrison
	['HideAlertFrame'] = true,
	['MailInputbox'] = true,
	['Screenshot'] = true,
	['TooltipIcon'] = true,
	['noDuel'] = false,
	['LootAnnouncer'] = true,
}

P['muiSkins'] = {
	['MasterPlan'] = true,
	['Quest'] = true,
}

P['muiUnitframes'] = {
	['EmptyBar'] = {
		['enable'] = true,
		['threat'] = true,
		['groupHeight'] = 20,
	},
	['HoverClassColor'] = true,
}
