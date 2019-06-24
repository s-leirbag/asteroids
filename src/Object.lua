Object = Class{}

function Object:init(id, x, y, dx, dy, size, angle)
	self.id = id
	self.x = x
	self.y = y
	self.dx = dx
	self.dy = dy
	self.size = size
	self.angle = angle
end

function Object:update(dt)
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt
	self.x, self.y = wrapCoords(self.x, self.y)
	self.model = transformModel(BLUEPRINTS[self.id], self.x, self.y, self.angle, self.size)
end

function Object:render()
	drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

	-- if on edge, draw other ships
	local tooFar = {0, 0}			-- tooFar[1] is right/left, tooFar[2] is up/down

	for k, vector in pairs(self.model) do
		if vector[1] > VIRTUAL_WIDTH then
			tooFar[1] = 1

			break
		elseif vector[1] < 0 then
			tooFar[1] = -1

			break
		end
	end

	for k, vector in pairs(self.model) do
		if vector[2] > VIRTUAL_HEIGHT then
			tooFar[2] = 1

			break

		elseif vector[2] < 0 then
			tooFar[2] = -1

			break
		end
	end

	if tooFar[1] == 0 then
		if tooFar[2] == 1 then
			for k, vector in pairs(self.model) do
				vector[2] = vector[2] - VIRTUAL_HEIGHT
			end
			drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		elseif tooFar[2] == -1 then
			for k, vector in pairs(self.model) do
				vector[2] = vector[2] + VIRTUAL_HEIGHT
			end
			drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
		end

	elseif tooFar[1] == 1 then
		for k, vector in pairs(self.model) do
			vector[1] = vector[1] - VIRTUAL_WIDTH
		end
		drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		if tooFar[2] ~= 0 then
			if tooFar[2] == 1 then
				for k, vector in pairs(self.model) do
					vector[2] = vector[2] - VIRTUAL_HEIGHT
				end
				drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

			-- tooFar[2] is -1
			else
				for k, vector in pairs(self.model) do
					vector[2] = vector[2] + VIRTUAL_HEIGHT
				end
				drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
			end

			for k, vector in pairs(self.model) do
				vector[1] = vector[1] + VIRTUAL_WIDTH
			end
			drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
		end

	-- tooFar[1] is -1
	else
		for k, vector in pairs(self.model) do
			vector[1] = vector[1] + VIRTUAL_WIDTH
		end
		drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		if tooFar[2] ~= 0 then
			if tooFar[2] == 1 then
				for k, vector in pairs(self.model) do
					vector[2] = vector[2] - VIRTUAL_HEIGHT
				end
				drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

			-- tooFar[2] is -1
			else
				for k, vector in pairs(self.model) do
					vector[2] = vector[2] + VIRTUAL_HEIGHT
				end
				drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
			end

			for k, vector in pairs(self.model) do
				vector[1] = vector[1] - VIRTUAL_WIDTH
			end
			drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
		end
	end

	if self.model[1][2] > VIRTUAL_HEIGHT or self.model[2][2] > VIRTUAL_HEIGHT or self.model[3][1] > VIRTUAL_HEIGHT or self.model[4][2] > VIRTUAL_HEIGHT then
		for k, vector in pairs(self.model) do
			vector[2] = vector[2] - VIRTUAL_HEIGHT
		end
		drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		if self.model[1][1] > VIRTUAL_WIDTH or self.model[2][1] > VIRTUAL_WIDTH or self.model[3][1] > VIRTUAL_WIDTH or self.model[4][1] > VIRTUAL_WIDTH then
			for k, vector in pairs(self.model) do
				vector[1] = vector[1] - VIRTUAL_WIDTH
			end
			drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		elseif self.model[1][1] < 0 or self.model[2][1] < 0 or self.model[3][1] < 0 or self.model[4][1] < 0 then
			for k, vector in pairs(self.model) do
				vector[1] = vector[1] + VIRTUAL_WIDTH
			end
			drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
		end

	elseif self.model[1][2] < 0 or self.model[2][2] < 0 or self.model[3][1] < 0 or self.model[4][2] < 0 then
		-- left top
		for k, vector in pairs(self.model) do
			vector[2] = vector[2] + VIRTUAL_HEIGHT
		end
		drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		if self.model[1][1] > VIRTUAL_WIDTH or self.model[2][1] > VIRTUAL_WIDTH or self.model[4][1] > VIRTUAL_WIDTH then
			for k, vector in pairs(self.model) do
				vector[1] = vector[1] - VIRTUAL_WIDTH
			end
			drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		elseif self.model[1][1] < 0 or self.model[2][1] < 0 or self.model[4][1] < 0 then
			for k, vector in pairs(self.model) do
				vector[1] = vector[1] + VIRTUAL_WIDTH
			end
			drawModel(coords_out(self.model), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
		end
	end
end