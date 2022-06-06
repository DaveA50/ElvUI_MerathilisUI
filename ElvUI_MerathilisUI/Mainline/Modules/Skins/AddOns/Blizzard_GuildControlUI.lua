local MER, F, E, L, V, P, G = unpack(select(2, ...))
local module = MER.Modules.Skins
local S = E:GetModule('Skins')

local _G = _G

local function LoadSkin()
	if not module:CheckDB("guildcontrol", "guildcontrol") then
		return
	end

	_G.GuildControlUI:Styling()
	MER:CreateBackdropShadow(_G.GuildControlUI)
end

S:AddCallbackForAddon("Blizzard_GuildControlUI", LoadSkin)
