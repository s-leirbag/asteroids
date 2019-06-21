Asteroid = Class{}

function Asteroid:init(x, y, dx, dy, size, angle)
	self.x = x
	self.y = y
	self.dx = dx
	self.dy = dy
	self.size = size
	self.angle = angle
end

function Asteroid:update(dt)
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt
	self.x, self.y = wrapCoords(self.x, self.y)

	print("x: " .. self.x .. " y: " .. self.y)
end

function Asteroid:render()
	-- love.graphics.rectangle('line', self.x, self.y, self.size, self.size)

	-- if self.x + self.size > VIRTUAL_WIDTH then
	-- 	love.graphics.rectangle('line', self.x - VIRTUAL_WIDTH, self.y, self.size, self.size)
	-- end

	-- if self.y + self.size > VIRTUAL_HEIGHT then
	-- 	love.graphics.rectangle('line', self.x, self.y - VIRTUAL_HEIGHT, self.size, self.size)
	-- end

	-- if self.x + self.size > VIRTUAL_WIDTH and self.y + self.size > VIRTUAL_HEIGHT then
	-- 	love.graphics.rectangle('line', self.x - VIRTUAL_WIDTH, self.y - VIRTUAL_HEIGHT, self.size, self.size)
	-- end

	local render_asteroid = transformModel(ASTEROID_BLUEPRINT, self.x, self.y, self.angle, 5)
	drawModel(coords_out(render_asteroid), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
end