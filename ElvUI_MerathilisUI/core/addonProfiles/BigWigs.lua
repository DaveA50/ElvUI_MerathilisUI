local E, L, V, P, G = unpack(ElvUI);
local MER = E:GetModule('MerathilisUI');

function MER:LoadBigWigsProfile()
	--[[----------------------------------
	--	BigWigs - Settings
	--]]----------------------------------
	BigWigs3DB = {
		["namespaces"] = {
			["BigWigs_Plugins_Victory"] = {},
			["BigWigs_Plugins_Colors"] = {},
			["BigWigs_Plugins_Alt Power"] = {
				["profiles"] = {
					["MerathilisUI"] = {
						["posx"] = 339.84443097218,
						["fontSize"] = 11,
						["fontOutline"] = "",
						["font"] = "Merathilis Roboto-Bold",
						["lock"] = true,
						["posy"] = 61.8444405166224,
					},
				},
			},
			["BigWigs_Plugins_BossBlock"] = {},
			["BigWigs_Plugins_Bars"] = {
				["profiles"] = {
					["MerathilisUI"] = {
						["BigWigsEmphasizeAnchor_y"] = 274.777784431353,
						["fontSize"] = 11,
						["BigWigsAnchor_width"] = 239.999954223633,
						["BigWigsAnchor_y"] = 265.177697393337,
						["BigWigsEmphasizeAnchor_x"] = 251.977762177876,
						["barStyle"] = "MerathilisUI",
						["emphasizeGrowup"] = true,
						["BigWigsAnchor_x"] = 1018.51096216262,
						["outline"] = "OUTLINE",
						["BigWigsEmphasizeAnchor_width"] = 244.999984741211,
						["font"] = "Merathilis Roboto-Bold",
						["emphasizeScale"] = 1.1,
						["texture"] = "MerathilisLight",
					},
				},
			},
			["BigWigs_Plugins_Super Emphasize"] = {
				["profiles"] = {
					["MerathilisUI"] = {
						["font"] = "Merathilis Roboto-Bold",
					},
				},
			},
			["BigWigs_Plugins_Sounds"] = {},
			["BigWigs_Plugins_Messages"] = {
				["profiles"] = {
					["MerathilisUI"] = {
						["outline"] = "OUTLINE",
						["fontSize"] = 20,
						["BWEmphasizeCountdownMessageAnchor_x"] = 664,
						["BWMessageAnchor_x"] = 608,
						["growUpwards"] = false,
						["BWEmphasizeCountdownMessageAnchor_y"] = 523,
						["font"] = "Merathilis Roboto-Bold",
						["BWEmphasizeMessageAnchor_y"] = 614,
						["BWMessageAnchor_y"] = 676,
						["BWEmphasizeMessageAnchor_x"] = 610,
					},
				},
			},
			["BigWigs_Plugins_Statistics"] = {},
			["BigWigs_Plugins_Respawn"] = {},
			["BigWigs_Plugins_Proximity"] = {
				["profiles"] = {
					["MerathilisUI"] = {
						["posx"] = 900.11113290675,
						["font"] = "Merathilis Roboto-Bold",
						["lock"] = true,
						["height"] = 99.0000381469727,
						["posy"] = 70.4000288314296,
					},
				},
			},
			["BigWigs_Plugins_Raid Icons"] = {},
			["LibDualSpec-1.0"] = {},
		},
		["profiles"] = {
			["MerathilisUI"] = {
				["fakeDBMVersion"] = true,
			},
		},
	}

	local db = LibStub("AceDB-3.0"):New(BigWigs3DB, nil, true)
	db:SetProfile("MerathilisUI")
end