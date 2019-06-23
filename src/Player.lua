Player = Class{}

function Player:init(x, y, dx, dy, size, angle)
	self.x = x
	self.y = y
	self.dx = dx
	self.dy = dy
	self.size = size
	self.angle = angle
end

function Player:update(dt)
	-- steering
	if love.keyboard.isDown('left') then
		self.angle = self.angle - 230 * dt

		if self.angle < -180 then
			self.angle = self.angle + 360
		end
	end
	
	if love.keyboard.isDown('right') then
		self.angle = self.angle + 230 * dt

		if self.angle > 180 then
			self.angle = self.angle - 360
		end
	end

	-- thrust
	if love.keyboard.isDown('up') then
		self.dx = self.dx + math.sin(math.rad(self.angle)) * 20
		self.dy = self.dy + -math.cos(math.rad(self.angle)) * 20
		self.dx = self.dx * 0.9
		self.dy = self.dy * 0.9
	end

	-- update position
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt
	self.x, self.y = wrapCoords(self.x, self.y)
end

function Player:render()
	-- render actual
	local render_ship = transformModel(SHIP_BLUEPRINT, self.x, self.y, self.angle, self.size)
	drawModel(coords_out(render_ship), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

	-- if on edge, draw other ships
	if render_ship[1][1] > VIRTUAL_WIDTH or render_ship[2][1] > VIRTUAL_WIDTH or render_ship[4][1] > VIRTUAL_WIDTH then
		for k, vector in pairs(render_ship) do
			vector[1] = vector[1] - VIRTUAL_WIDTH
		end
		drawModel(coords_out(render_ship), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

	elseif render_ship[1][1] < 0 or render_ship[2][1] < 0 or render_ship[4][1] < 0 then
		for k, vector in pairs(render_ship) do
			vector[1] = vector[1] + VIRTUAL_WIDTH
		end
		drawModel(coords_out(render_ship), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
	end

	if render_ship[1][2] > VIRTUAL_HEIGHT or render_ship[2][2] > VIRTUAL_HEIGHT or render_ship[4][2] > VIRTUAL_HEIGHT then
		for k, vector in pairs(render_ship) do
			vector[2] = vector[2] - VIRTUAL_HEIGHT
		end
		drawModel(coords_out(render_ship), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		if render_ship[1][1] > VIRTUAL_WIDTH or render_ship[2][1] > VIRTUAL_WIDTH or render_ship[4][1] > VIRTUAL_WIDTH then
			for k, vector in pairs(render_ship) do
				vector[1] = vector[1] - VIRTUAL_WIDTH
			end
			drawModel(coords_out(render_ship), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		elseif render_ship[1][1] < 0 or render_ship[2][1] < 0 or render_ship[4][1] < 0 then
			for k, vector in pairs(render_ship) do
				vector[1] = vector[1] + VIRTUAL_WIDTH
			end
			drawModel(coords_out(render_ship), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
		end

	elseif render_ship[1][2] < 0 or render_ship[2][2] < 0 or render_ship[4][2] < 0 then
		-- left top
		for k, vector in pairs(render_ship) do
			vector[2] = vector[2] + VIRTUAL_HEIGHT
		end
		drawModel(coords_out(render_ship), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		if render_ship[1][1] > VIRTUAL_WIDTH or render_ship[2][1] > VIRTUAL_WIDTH or render_ship[4][1] > VIRTUAL_WIDTH then
			for k, vector in pairs(render_ship) do
				vector[1] = vector[1] - VIRTUAL_WIDTH
			end
			drawModel(coords_out(render_ship), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		elseif render_ship[1][1] < 0 or render_ship[2][1] < 0 or render_ship[4][1] < 0 then
			for k, vector in pairs(render_ship) do
				vector[1] = vector[1] + VIRTUAL_WIDTH
			end
			drawModel(coords_out(render_ship), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
		end
	end

	-- print coordinates
	-- love.graphics.print("x: " .. math.floor(self.x) .. ", y: " .. math.floor(self.y) .. ", angle: " .. math.floor(self.angle), 10, 10)
end