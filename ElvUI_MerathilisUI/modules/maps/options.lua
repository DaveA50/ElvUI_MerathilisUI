local MER, E, L, V, P, G = unpack(select(2, ...))
local MM = E:GetModule("mUIMinimap")

local function Minimap()
	E.Options.args.mui.args.minimap = {
		type = "group",
		name = MINIMAP_LABEL,
		order = 16,
		get = function(info) return E.db.mui.maps.minimap[ info[#info] ] end,
		set = function(info, value) E.db.mui.maps.minimap[ info[#info] ] = value; end,
		disabled = function() return not E.private.general.minimap.enable end,
		args = {
			header1 = {
				type = "header",
				name = MER:cOption(MINIMAP_LABEL),
				order = 1,
			},
			coords = {
				order = 2,
				type = "group",
				name = MER:cOption(L["Coordinates"]),
				guiInline = true,
				get = function(info) return E.db.mui.maps.minimap.coords[ info[#info] ] end,
				set = function(info, value) E.db.mui.maps.minimap.coords[ info[#info] ] = value; E:StaticPopup_Show("PRIVATE_RL"); end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
					},
					position = {
						order = 2,
						type = "select",
						name = L["Position"],
						values = {
							["TOP"] = L["Top"],
							["BOTTOM"] = L["Bottom"],
							["LEFT"] = L["Left"],
							["RIGHT"] = L["Right"],
							["CENTER"] = L["Center"],
						},
					},
				},
			},
			buttonCollector = {
				order = 3,
				type = "group",
				name = MER:cOption(L["MiniMap Buttons"])..MER.NewSign,
				guiInline = true,
				get = function(info) return E.db.mui.maps.minimap.buttonCollector[ info[#info] ] end,
				set = function(info, value) E.db.mui.maps.minimap.buttonCollector[ info[#info] ] = value; E:StaticPopup_Show("PRIVATE_RL"); end,
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
					},
				},
			},
		},
	}
end
tinsert(MER.Config, Minimap)