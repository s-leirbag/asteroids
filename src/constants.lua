WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 640

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 320

BULLET_SPEED = 250

BLUEPRINTS = {
	-- ship
	{
		{0, -5},
		{3, 3},
		{0, 1},
		{-3, 3}
	},
	-- bullet
	{
		{-1, -6},
		{1, -6},
		{1, -1},
		{-1, -1}
	},
}

-- asteroids
for k = 3, 6 do
	BLUEPRINTS[k] = {}
	for i = 1, 20 do
		local angle = i / 20 * 360
		local radius = math.random() * 0.8 + 2
		table.insert(BLUEPRINTS[k], {radius * math.cos(math.rad(angle)), radius * math.sin(math.rad(angle))})
	end
end