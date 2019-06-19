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

    asteroids = {Asteroid(30, 40, 20, -25, 30)}
    player = Player(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, 0, 0, 2, 0)
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

    for k, asteroid in pairs(asteroids) do
        asteroid:update(dt)
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

    player:render()

    push:finish()
end

function updateMouse(dt)
    mouseX, mouseY = love.mouse.getPosition()
    mouseX, mouseY = push:toGame(mouseX, mouseY)
end