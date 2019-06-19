Player = Class{}

function Player:init(x, y, dx, dy, size, angle)
	self.x = x
	self.y = y
	self.dx = dx
	self.dy = dy
	self.size = size
	self.angle = angle

	self.shipBlueprint = {
		{0, -5},
		{3, 3},
		{0, 1},
		{-3, 3}
	}

	-- scale up ship blueprint
	for k, vector in pairs(self.shipBlueprint) do
		vector[1] = vector[1] * self.size
		vector[2] = vector[2] * self.size
	end
end

function Player:update(dt)
	-- steering
	if love.keyboard.isDown('left') then
		self.angle = self.angle - 230 * dt
	end

	if love.keyboard.isDown('right') then
		self.angle = self.angle + 230 * dt
	end

	-- thrust
	if love.keyboard.isDown('up') then
		self.dx = math.sin(math.rad(self.angle)) * 70
		self.dy = -math.cos(math.rad(self.angle)) * 70
	end

	-- update position
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt
	self.x, self.y = wrapCoords(self.x, self.y)
end

function Player:render()
	-- update ship
	-- rotate
	local renderShip = {}
	for k, vector in pairs(self.shipBlueprint) do
		renderShip[k] = {}
		renderShip[k][1] = vector[1] * math.cos(math.rad(self.angle)) - vector[2] * math.sin(math.rad(self.angle))
		renderShip[k][2] = vector[1] * math.sin(math.rad(self.angle)) + vector[2] * math.cos(math.rad(self.angle))
		print(renderShip[k][1] .. ", " .. renderShip[k][2])
	end

	-- move to Player
	for k, vector in pairs(renderShip) do
		vector[1] = vector[1] + self.x
		vector[2] = vector[2] + self.y
	end

	drawPolygon(coords_out(renderShip), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

	if renderShip[1][1] > VIRTUAL_WIDTH or renderShip[2][1] > VIRTUAL_WIDTH or renderShip[4][1] > VIRTUAL_WIDTH then
		for k, vector in pairs(renderShip) do
			vector[1] = vector[1] - VIRTUAL_WIDTH
		end
		drawPolygon(coords_out(renderShip), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		if renderShip[1][2] > VIRTUAL_HEIGHT or renderShip[2][2] > VIRTUAL_HEIGHT or renderShip[4][2] > VIRTUAL_HEIGHT then
			for k, vector in pairs(renderShip) do
				vector[1] = vector[1] - VIRTUAL_WIDTH
				vector[2] = vector[2] - VIRTUAL_HEIGHT
			end
			drawPolygon(coords_out(renderShip), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		end

	elseif renderShip[1][1] < 0 or renderShip[2][1] < 0 or renderShip[4][1] < 0 then
		for k, vector in pairs(renderShip) do
			vector[1] = vector[1] + VIRTUAL_WIDTH
		end
		drawPolygon(coords_out(renderShip), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		if renderShip[1][2] < 0 or renderShip[2][2] < 0 or renderShip[4][2] < 0 then
			for k, vector in pairs(renderShip) do
				vector[1] = vector[1] - VIRTUAL_WIDTH
				vector[2] = vector[2] + VIRTUAL_HEIGHT
			end

			drawPolygon(coords_out(renderShip), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
		end
	end

	if renderShip[1][2] > VIRTUAL_HEIGHT or renderShip[2][2] > VIRTUAL_HEIGHT or renderShip[4][2] > VIRTUAL_HEIGHT then
		for k, vector in pairs(renderShip) do
			vector[2] = vector[2] - VIRTUAL_HEIGHT
		end
		drawPolygon(coords_out(renderShip), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

	elseif renderShip[1][2] < 0 or renderShip[2][2] < 0 or renderShip[4][2] < 0 then
		for k, vector in pairs(renderShip) do
			vector[2] = vector[2] + VIRTUAL_HEIGHT
		end

		drawPolygon(coords_out(renderShip), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
	end

	-- if self.y + self.size > VIRTUAL_HEIGHT then
	-- 	love.graphics.rectangle('line', self.x, self.y - VIRTUAL_HEIGHT, self.size, self.size)
	-- end

	-- if self.x + self.size > VIRTUAL_WIDTH and self.y + self.size > VIRTUAL_HEIGHT then
	-- 	love.graphics.rectangle('line', self.x - VIRTUAL_WIDTH, self.y - VIRTUAL_HEIGHT, self.size, self.size)
	-- end

	-- self.shipBlueprint[1, 2, 4]
end