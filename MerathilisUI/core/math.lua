local E, L, V, P, G = unpack(ElvUI);

--Cache global variables
local format = string.format
--WoW API / Variables


local styles = {
	['CURRENT'] = '%s',
	['CURRENT_MAX'] = '%s - %s',
	['CURRENT_PERCENT'] =  '%s - %.1f%%',
	['CURRENT_MAX_PERCENT'] = '%s - %s | %.1f%%',
	['PERCENT'] = '%.1f%%',
	['PERCENT_SHORT'] = '%.1f%%',
	['DEFICIT'] = '-%s'
}

function E:GetFormattedText(style, min, max)
	assert(styles[style], 'Invalid format style: '..style)
	assert(min, 'You need to provide a current value. Usage: E:GetFormattedText(style, min, max)')
	assert(max, 'You need to provide a maximum value. Usage: E:GetFormattedText(style, min, max)')

	if max == 0 then max = 1 end

	local useStyle = styles[style]

	if style == 'DEFICIT' then
		local deficit = max - min
		if deficit <= 0 then
			return ''
		else
			return format(useStyle, E:ShortValue(deficit))
		end
	elseif style == 'PERCENT' then
		local s = format(useStyle, min / max * 100)
		return s
	elseif style == 'PERCENT_SHORT' then
		local s = format(useStyle, format("%.0f", min / max * 100))
		s = s:gsub(".0%%", "%%")
		return s
	elseif style == 'CURRENT' or ((style == 'CURRENT_MAX' or style == 'CURRENT_MAX_PERCENT' or style == 'CURRENT_PERCENT') and min == max) then
		return format(styles['CURRENT'],  E:ShortValue(min))
	elseif style == 'CURRENT_MAX' then
		return format(useStyle,  E:ShortValue(min), E:ShortValue(max))
	elseif style == 'CURRENT_PERCENT' then
		local s = format(useStyle, E:ShortValue(min), min / max * 100)
		return s
	elseif style == 'CURRENT_MAX_PERCENT' then
		local s = format(useStyle, E:ShortValue(min), E:ShortValue(max), min / max * 100)
		return s
	end
end
