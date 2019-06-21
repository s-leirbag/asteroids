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

function drawModel(coords, color, outline, outlineColor, thickness)
	if color then
		love.graphics.setColor(color[1], color[2], color[3])
	end

	love.graphics.polygon('fill', coords)

	if outline then
		if outlineColor then
			love.graphics.setColor(outlineColor[1], outlineColor[2], outlineColor[3])
		end
		
		if thickness then
			love.graphics.setLineWidth(thickness)
		end

		drawLines(coords)
	end
end

function transformModel(model, x, y, angle, scalar)
	local newModel = {}
	for k, vector in pairs(model) do
		newModel[k] = vector
	end

	-- rotate
	if angle then
		for k, vector in pairs(model) do
			newModel[k][1] = vector[1] * math.cos(math.rad(angle)) - vector[2] * math.sin(math.rad(angle))
			newModel[k][2] = vector[1] * math.sin(math.rad(angle)) + vector[2] * math.cos(math.rad(angle))
		end
	end

	-- scale
	if scalar then
		for k, vector in pairs(newModel) do
			vector[1] = vector[1] * scalar
			vector[2] = vector[2] * scalar
		end
	end

	-- move
	if x and y then
		for k, vector in pairs(newModel) do
			vector[1] = vector[1] + x
			vector[2] = vector[2] + y
		end
	end

	return newModel
end

function drawLines(coords)
    for i = 1, #coords / 2 - 1 do
        love.graphics.line(coords[i * 2 - 1], coords[i * 2], coords[i * 2 + 1], coords[i * 2 + 2])
    end
    love.graphics.line(coords[#coords - 1], coords[#coords], coords[1], coords[2])
end

function coords_out(shape)
    local coords = {}
    for k, vector in ipairs(shape) do
        for i, coord in pairs(vector) do
            table.insert(coords, coord)
        end
    end

    return coords
end