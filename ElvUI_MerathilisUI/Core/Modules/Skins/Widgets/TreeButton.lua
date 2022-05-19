local MER, F, E, L, V, P, G = unpack(select(2, ...))
local module = MER.Modules.Skins
local LSM = E.Libs.LSM
local S = E.Skins

function module:HandleTreeGroup(widget)
	if widget.CreateButton then
		widget.CreateButton_Changed = widget.CreateButton
		widget.CreateButton = function(...)
			local button = widget.CreateButton_Changed(...)

			if not E.private.mui.skins.widgets.treeGroupButton.enable then
				return button
			end

			local db = E.private.mui.skins.widgets.treeGroupButton

			if db.text.enable then
				local text = button.Text or button.GetName and button:GetName() and _G[button:GetName() .. "Text"]
				if text and text.GetTextColor then
					F.SetFontDB(text, db.text.font)

					text.SetPoint_ = text.SetPoint
					text.SetPoint = function(text, point, arg1, arg2, arg3, arg4)
						if point == "LEFT" and type(arg2) == "number" and abs(arg2 - 2) < 0.1 then
							arg2 = 0
						end

						text.SetPoint_(text, point, arg1, arg2, arg3, arg4)
					end
				end
			end

			if db.backdrop.enable then
				-- Create background
				button:SetHighlightTexture("")

				local bg = button:CreateTexture()
				bg:SetInside(button, 1, 0)
				bg:SetAlpha(0)
				bg:SetTexture(LSM:Fetch("statusbar", db.backdrop.texture) or E.media.normTex)

				if button.Center then
					local layer, subLayer = button.Center:GetDrawLayer()
					subLayer = subLayer and subLayer + 1 or 0
					bg:SetDrawLayer(layer, subLayer)
				end

				F.SetVertexColorDB(bg, db.backdrop.classColor and module.ClassColor or db.backdrop.color)

				local group, onEnter, onLeave = self.Animation(bg, db.backdrop.animationType, db.backdrop.animationDuration, db.backdrop.alpha)
				button.MERAnimation = {bg = bg, group = group, onEnter = onEnter, onLeave = onLeave}

				self:SecureHookScript(button, "OnEnter", onEnter)
				self:SecureHookScript(button, "OnLeave", onLeave)

				-- Avoid the hook is flushed
				self:SecureHook(button, "SetScript", function(frame, scriptType)
					if scriptType == "OnEnter" then
						self:Unhook(frame, "OnEnter")
						self:SecureHookScript(frame, "OnEnter", onEnter)
					elseif scriptType == "OnLeave" then
						self:Unhook(frame, "OnLeave")
						self:SecureHookScript(frame, "OnLeave", onLeave)
					end
				end)
			end

			button.MERSkinned = true

			return button
		end
	end
end