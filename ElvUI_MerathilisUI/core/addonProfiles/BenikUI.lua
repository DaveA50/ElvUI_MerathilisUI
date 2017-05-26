local MER, E, L, V, P, G = unpack(select(2, ...))

function MER:LoadBenikUIProfile()
	--[[----------------------------------
	--	BenikUI - Settings
	--]]----------------------------------
	E.db["benikui"]["general"]["loginMessage"] = false
	E.db["benikui"]["general"]["splashScreen"] = false
	E.db["benikui"]["colors"]["gameMenuColor"] = 1
	E.db["benikui"]["misc"]["ilevel"]["enable"] = false
	E.db["benikui"]["datatexts"]["chat"]["enable"] = false
	E.db["benikui"]["datatexts"]["chat"]["transparent"] = true
	E.db["benikui"]["datatexts"]["chat"]["editBoxPosition"] = "BELOW_CHAT"
	E.db["benikui"]["datatexts"]["chat"]["styled"] = false
	E.db["benikui"]["datatexts"]["chat"]["backdrop"] = true
	E.db["benikui"]["datatexts"]["middle"]["enable"] = false
	E.db["benikui"]["datatexts"]["middle"]["transparent"] = true
	E.db["benikui"]["datatexts"]["middle"]["backdrop"] = true
	E.db["benikui"]["datatexts"]["middle"]["width"] = 412
	E.db["benikui"]["datatexts"]["middle"]["height"] = 19
	E.db["benikui"]["datatexts"]["middle"]["styled"] = true
	E.db["benikui"]["datatexts"]["mail"]["toggle"] = false
	E.db["benikui"]["datatexts"]["garrison"]["currency"] = true
	E.db["benikui"]["datatexts"]["garrison"]["oil"] = true
	E.db["benikuiDatabars"]["experience"]["notifiers"]["enable"] = false
	E.db["benikuiDatabars"]["reputation"]["notifiers"]["enable"] = false
	E.db["benikuiDatabars"]["artifact"]["notifiers"]["enable"] = false
	E.db["benikui"]["unitframes"]["misc"]["svui"] = true
	E.db["benikui"]["unitframes"]["textures"]["power"] = E.db.unitframe.statusbar
	E.db["benikui"]["unitframes"]["textures"]["health"] = E.db.unitframe.statusbar
	E.db["benikui"]["unitframes"]["infoPanel"]["fixInfoPanel"] = true
	E.db["benikui"]["unitframes"]["infoPanel"]["texture"] = "MerathilisEmpty"
	E.db["benikui"]["unitframes"]["textures"]["ignoreTransparency"] = true
	E.db["dashboards"]["barColor"] = {r = MER.ClassColor.r, g = MER.ClassColor.g, b = MER.ClassColor.b}
	E.db["dashboards"]["system"]["enableSystem"] = false
	E.db["dashboards"]["professions"]["enableProfessions"] = false
	E.db["dashboards"]["tokens"]["enableTokens"] = false
	E.db["dashboards"]["tokens"]["tooltip"] = false
	E.db["dashboards"]["tokens"]["flash"] = false
	E.db["dashboards"]["tokens"]["width"] = 130
	E.db["dashboards"]["tokens"]["combat"] = true
	E.db["movers"]["BuiMiddleDtMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,2"
	E.db["movers"]["tokenHolderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-164"
	E.db["movers"]["BuiDashboardMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-8"
end