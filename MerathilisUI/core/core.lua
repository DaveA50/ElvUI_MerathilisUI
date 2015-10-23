local E, L, V, P, G, _ = unpack(ElvUI);
local MER = E:NewModule('MerathilisUI', "AceConsole-3.0");

local LSM = LibStub('LibSharedMedia-3.0');
local EP = LibStub('LibElvUIPlugin-1.0');
local addon, ns = ...
local format = string.format

MER.TexCoords = {.08, 0.92, -.04, 0.92}
MER.Title = format('|cffff7d0a%s |r', 'MerathilisUI')
MER.Version = GetAddOnMetadata('MerathilisUI', 'Version') -- with this we get the addon version from toc file

function MER:cOption(name)
	local MER_COLOR = '|cffff7d0a%s |r'
	return (MER_COLOR):format(name)
end

function MER:StyleFrame(frame)
	if not IsAddOnLoaded("ElvUI_BenikUI") then return end
	if frame and not frame.style then
		frame:Style("Outside")
	end
end

function MER:RegisterMerMedia()
	--Fonts
	E['media'].muiFont = LSM:Fetch('font', 'Merathilis Prototype')
	E['media'].muiVisitor = LSM:Fetch('font', 'Merathilis Visitor1')
	E['media'].muiVisitor2 = LSM:Fetch('font', 'Merathilis Visitor2')
	E['media'].muiTuk = LSM:Fetch('font', 'Merathilis Tukui')
	
	--Textures
	E['media'].MuiEmpty = LSM:Fetch('statusbar', 'MerathilisEmpty')
	E['media'].MuiFlat = LSM:Fetch('statusbar', 'MerathilisFlat')
	E['media'].MuiMelli = LSM:Fetch('statusbar', 'MerathilisMelli')
	E['media'].MuiMelliDark = LSM:Fetch('statusbar', 'MerathilisMelliDark')
	E['media'].MuiOnePixel = LSM:Fetch('statusbar', 'MerathilisOnePixel')
end

E.MerConfig = {}

function MER:AddOptions()
	for _, func in pairs(E.MerConfig) do
		func()
	end	
end

function MER:DasOptions()
	E:ToggleConfig(); LibStub("AceConfigDialog-3.0-ElvUI"):SelectGroup("ElvUI", "mui")
end

function MER:LoadCommands()
	self:RegisterChatCommand("mui", "DasOptions")
	self:RegisterChatCommand("muisetup", "SetupUI")
end

function MER:Initialize()
	self:RegisterMerMedia()
	self:LoadCommands()
	self:LoadGameMenu()
	-- if ElvUI installed and if in your profile the install is nil then run the SetupUI() function.
	-- This is a check so that your setup won't run everytime you login
	-- Enable it when you are done
	
	-- Try if to force that first BenikUI install process pops up and then mine. Did not work, and i dont know why?!
	-- if IsAddOnLoaded("ElvUI_BenikUI") then
	-- 		if E.private.install_complete == E.version and E.db.bui.installed == true and E.db.mui.installed == nil then self:SetupUI()
	-- else
	-- 		if E.private.install_complete == E.version and E.db.mui.installed == nil then self:SetupUI() end
	if E.private.install_complete == E.version and E.db.mui.installed == nil then self:SetupUI() end -- pop the message only if ElvUI install is complete on this char and your ui hasn't been applied yet

	-- run the setup again when a profile gets deleted.
	local profileKey = ElvDB.profileKeys[E.myname..' - '..E.myrealm]
	if ElvDB.profileKeys and profileKey == nil then self:SetupUI() end
	
	if E.db.muiGeneral.LoginMsg then
		print(MER.Title..format('v|cff00c0fa%s|r',MER.Version)..L[' is loaded.'])
	end
	EP:RegisterPlugin(addon, self.AddOptions)
end

E:RegisterModule(MER:GetName())
