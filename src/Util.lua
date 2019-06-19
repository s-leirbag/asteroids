function wrapCoords(x, y)
	if x < 0 then
		x = x + VIRTUAL_WIDTH
	elseif x > VIRTUAL_WIDTH then
		x = x - VIRTUAL_WIDTH
	end

	if y < 0 then
		y = y + VIRTUAL_HEIGHT
	elseif y > VIRTUAL_HEIGHT then
		y = y - VIRTUAL_HEIGHT
	end

	return x, y
end