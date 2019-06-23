WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 640

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 320

ASPECT_RATIO = VIRTUAL_HEIGHT / VIRTUAL_WIDTH

SHIP_BLUEPRINT = {
	{0, -5},
	{3, 3},
	{0, 1},
	{-3, 3}
}

ASTEROID_BLUEPRINT = {}

for i = 1, 20 do
	local angle = i / 20 * 360
	local radius = math.random(5.0, 7.0)
	table.insert(ASTEROID_BLUEPRINT, {radius * math.cos(math.rad(angle)), radius * math.sin(math.rad(angle))})
end