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
end

function Object:render()
	local render_self = transformModel(BLUEPRINTS[self.id], self.x, self.y, self.angle, self.size)
	drawModel(coords_out(render_self), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

	-- if on edge, draw other ships
	if render_self[1][1] > VIRTUAL_WIDTH or render_self[2][1] > VIRTUAL_WIDTH or render_self[4][1] > VIRTUAL_WIDTH then
		for k, vector in pairs(render_self) do
			vector[1] = vector[1] - VIRTUAL_WIDTH
		end
		drawModel(coords_out(render_self), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

	elseif render_self[1][1] < 0 or render_self[2][1] < 0 or render_self[4][1] < 0 then
		for k, vector in pairs(render_self) do
			vector[1] = vector[1] + VIRTUAL_WIDTH
		end
		drawModel(coords_out(render_self), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
	end

	if render_self[1][2] > VIRTUAL_HEIGHT or render_self[2][2] > VIRTUAL_HEIGHT or render_self[4][2] > VIRTUAL_HEIGHT then
		for k, vector in pairs(render_self) do
			vector[2] = vector[2] - VIRTUAL_HEIGHT
		end
		drawModel(coords_out(render_self), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		if render_self[1][1] > VIRTUAL_WIDTH or render_self[2][1] > VIRTUAL_WIDTH or render_self[4][1] > VIRTUAL_WIDTH then
			for k, vector in pairs(render_self) do
				vector[1] = vector[1] - VIRTUAL_WIDTH
			end
			drawModel(coords_out(render_self), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		elseif render_self[1][1] < 0 or render_self[2][1] < 0 or render_self[4][1] < 0 then
			for k, vector in pairs(render_self) do
				vector[1] = vector[1] + VIRTUAL_WIDTH
			end
			drawModel(coords_out(render_self), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
		end

	elseif render_self[1][2] < 0 or render_self[2][2] < 0 or render_self[4][2] < 0 then
		-- left top
		for k, vector in pairs(render_self) do
			vector[2] = vector[2] + VIRTUAL_HEIGHT
		end
		drawModel(coords_out(render_self), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		if render_self[1][1] > VIRTUAL_WIDTH or render_self[2][1] > VIRTUAL_WIDTH or render_self[4][1] > VIRTUAL_WIDTH then
			for k, vector in pairs(render_self) do
				vector[1] = vector[1] - VIRTUAL_WIDTH
			end
			drawModel(coords_out(render_self), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)

		elseif render_self[1][1] < 0 or render_self[2][1] < 0 or render_self[4][1] < 0 then
			for k, vector in pairs(render_self) do
				vector[1] = vector[1] + VIRTUAL_WIDTH
			end
			drawModel(coords_out(render_self), {0.8, 0.2, 0.2}, true, {1, 1, 1}, 1)
		end
	end
end