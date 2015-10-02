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
	['Loot'] = true,
}

P['muiSkins'] = {
	['MasterPlan'] = true,
	['Quest'] = true,
}

P['muiUnitframes'] = {
	['HoverClassColor'] = true,
}
