local MER, F, E, L, V, P, G = unpack(select(2, ...))
local module = MER.Modules.Skins
local S = E.Skins

local abs = abs
local strlower = strlower


function module.IsUglyYellow(...)
	local r, g, b = ...
	return abs(r - 1) + abs(g - 0.82) + abs(b) < 0.02
end

function module.Animation(texture, aType, duration, data)
	local aType = strlower(aType)
	local group = texture:CreateAnimationGroup()

	if aType == "fade" then
		local alpha = data
		local anim = group:CreateAnimation("Alpha")
		group.anim = anim

		-- Set the default status is waiting to play enter animation
		anim.isEnterMode = true
		anim:SetFromAlpha(0)
		anim:SetToAlpha(alpha)
		anim:SetSmoothing("in")
		anim:SetDuration(duration)

		group:SetScript("OnPlay", function()
			texture:SetAlpha(anim:GetFromAlpha())
		end)

		group:SetScript("OnFinished", function()
			texture:SetAlpha(anim:GetToAlpha())
		end)

		local restart = function()
			if group:IsPlaying() then
				group:Pause()
				group:Restart()
			else
				group:Play()
			end
		end

		local onEnter = function()
			local remainingProgress = anim.isEnterMode and (1 - anim:GetProgress()) or anim:GetProgress()
			local remainingDuration = remainingProgress * duration

			anim:SetFromAlpha(alpha * (1 - remainingProgress))
			anim:SetToAlpha(alpha)
			anim:SetSmoothing("in")
			anim:SetDuration(remainingDuration)
			anim.isEnterMode = true
			restart()
		end

		local onLeave = function()
			local remainingProgress = anim.isEnterMode and anim:GetProgress() or (1 - anim:GetProgress())
			local remainingDuration = remainingProgress * duration

			anim:SetFromAlpha(alpha * remainingProgress)
			anim:SetToAlpha(0)
			anim:SetSmoothing("out")
			anim:SetDuration(remainingDuration)
			anim.isEnterMode = false
			restart()
		end

		return group, onEnter, onLeave
	elseif aType == "scale" then
	end
end

function module:Ace3_RegisterAsWidget(_, widget)
	local widgetType = widget.type

	if not widgetType then
		return
	end

	if widgetType == "Button" or widgetType == "Button-ElvUI" then
		self:HandleButton(nil, widget)
	end
end

module:SecureHook(S, "Ace3_RegisterAsWidget")
