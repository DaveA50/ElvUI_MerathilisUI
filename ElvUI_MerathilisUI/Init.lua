local E, L, V, P, G = unpack(ElvUI)
local EP = LibStub('LibElvUIPlugin-1.0')
local addon, Engine = ...

local MER = E.Libs.AceAddon:NewAddon(addon, 'AceConsole-3.0', 'AceEvent-3.0', 'AceHook-3.0')

-- Cache global variables
-- Lua functions
local _G = _G
local pairs = pairs
-- WoW API / Variables
-- GLOBALS:

--Setting up table to unpack.
Engine[1] = MER
Engine[2] = E
Engine[3] = L
Engine[4] = V
Engine[5] = P
Engine[6] = G
_G[addon] = Engine

MER.Config = {}
MER.RegisteredModules = {}

function MER:AddOptions()
	for _, func in pairs(MER.Config) do
		func()
	end
end

-- Register own Modules
function MER:RegisterModule(name)
	if self.initialized then
		local module = self:GetModule(name)
		if (module and module.Initialize) then
			module:Initialize()
		end
	else
		self["RegisteredModules"][#self["RegisteredModules"] + 1] = name
	end
end

function MER:GetRegisteredModules()
	return self["RegisteredModules"]
end

function MER:InitializeModules()
	for _, moduleName in pairs(MER["RegisteredModules"]) do
		local module = self:GetModule(moduleName)
		if module.Initialize then
			module:Initialize()
		end
	end
end

function MER:Init()
	self.initialized = true

	self:Initialize()
	self:InitializeModules()
	EP:RegisterPlugin(addon, self.AddOptions)
end

E.Libs.EP:HookInitialize(MER, MER.Init)
