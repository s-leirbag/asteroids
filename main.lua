love.graphics.setDefaultFilter('nearest', 'nearest')
require 'src/Dependencies'

function love.load()
    love.window.setTitle('Asteroids')
    math.randomseed(os.time())
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = false,
        fullscreen = false,
        resizable = true
    })
    love.keyboard.keysPressed = {}

    player = Object(1, VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, 0, 0, 3, 0)
    asteroids = {Object(math.random(3, 6), 100, 100, 20, -25, 16, 0)} --- make sure asteroid doesn't spawn on player later
    bullets = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    updateMouse()

    -- PLAYER
    -- steering
    if love.keyboard.isDown('left') then
        player.angle = player.angle - 230 * dt

        if player.angle < -180 then
            player.angle = player.angle + 360
        end
    end
    
    if love.keyboard.isDown('right') then
        player.angle = player.angle + 230 * dt

        if player.angle > 180 then
            player.angle = player.angle - 360
        end
    end

    -- thrust
    if love.keyboard.isDown('up') then
        player.dx = player.dx + math.sin(math.rad(player.angle)) * 10
        player.dy = player.dy + -math.cos(math.rad(player.angle)) * 10
        player.dx = player.dx * 0.9
        player.dy = player.dy * 0.9
    end

    -- bullets
    if love.keyboard.wasPressed('space') then
        table.insert(bullets, Object(2, player.x, player.y, math.sin(math.rad(player.angle)) * BULLET_SPEED, -math.cos(math.rad(player.angle)) * BULLET_SPEED, 2, player.angle))
    end

    for k, asteroid in pairs(asteroids) do
        asteroid:update(dt)
    end

    for k, bullet in ipairs(bullets) do
        bullet:update(dt)

        for i, vector in pairs(bullet.model) do
            if vector[1] > VIRTUAL_WIDTH or vector[1] < 0 or vector[2] > VIRTUAL_HEIGHT or vector[2] < 0 then
                table.remove(bullets, k)

                break
            end
        end
    end

    player:update(dt)

    love.keyboard.keysPressed = {}
    Timer.update(dt)
end

function love.draw()
    push:start()

    for k, asteroid in pairs(asteroids) do
        asteroid:render()
    end

    for k, bullet in ipairs(bullets) do
        bullet:render()
    end

    player:render()

    love.graphics.print("angle: " .. player.angle, 10, 10)

    push:finish()
end

function updateMouse(dt)
    mouseX, mouseY = love.mouse.getPosition()
    mouseX, mouseY = push:toGame(mouseX, mouseY)
end