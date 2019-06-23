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
end

function Asteroid:render()
	local render_asteroid = transformModel(ASTEROID_BLUEPRINT, self.x, self.y, self.angle, self.size)
	drawModel(coords_out(render_asteroid), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
end