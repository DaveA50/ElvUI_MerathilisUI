local MER, E, L, V, P, G = unpack(select(2, ...))
local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

local function Skin_WeakAuras(f, fType)
	if fType == "icon" then
		if not f.IsSkinned then
			f:CreateBackdrop()
			MER:CreateBackdropShadow(f, true)
			f.backdrop.Center:StripTextures()
			f.backdrop:SetFrameLevel(0)
			f.backdrop.icon = f.icon
			f.backdrop:HookScript("OnUpdate", function(self)
				self:SetAlpha(self.icon:GetAlpha())
				if self.shadow then
					self.shadow:SetAlpha(self.icon:GetAlpha())
				end
			end)
			f.IsSkinned = true
		end
	elseif fType == "aurabar" then
		if not f.IsSkinned then
			f:CreateBackdrop()
			f.backdrop.Center:StripTextures()
			f.backdrop:SetFrameLevel(0)
			MER:CreateBackdropShadow(f, true)
			f.iconFrame:SetAllPoints(f.icon)
			f.iconFrame:CreateBackdrop()
			f.IsSkinned = true
		end
	end
end

function S:WeakAuras()
	if E.private.muiSkins.addonSkins.wa ~= true then return; end

	local regionTypes = _G.WeakAuras.regionTypes
	local Create_Icon, Modify_Icon = regionTypes.icon.create, regionTypes.icon.modify
	local Create_AuraBar, Modify_AuraBar = regionTypes.aurabar.create, regionTypes.aurabar.modify

	regionTypes.icon.create = function(parent, data)
		local region = Create_Icon(parent, data)
		Skin_WeakAuras(region, "icon")
		return region
	end

	regionTypes.aurabar.create = function(parent)
		local region = Create_AuraBar(parent)
		Skin_WeakAuras(region, "aurabar")
		return region
	end

	regionTypes.icon.modify = function(parent, region, data)
		Modify_Icon(parent, region, data)
		Skin_WeakAuras(region, "icon")
	end

	regionTypes.aurabar.modify = function(parent, region, data)
		Modify_AuraBar(parent, region, data)
		Skin_WeakAuras(region, "aurabar")
	end

	for weakAura, regions in pairs(_G.WeakAuras.regions) do
		if regions.regionType == "icon" or regions.regionType == "aurabar" then
			Skin_WeakAuras(regions.region, regions.regionType)
		end
	end
end

S:AddCallbackForAddon("WeakAuras")
