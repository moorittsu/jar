-- Load the Simple Tiled Implementation (STI) library for tilemaps
local sti = require("libraries/sti")
-- Load the player module (player.lua)
require("player")

function love.load()
    -- Load the map with Box2D physics enabled
    map1 = sti("map/testmap.lua", {"box2d"})
    -- Create a new physics world with no gravity
    world = love.physics.newWorld(0, 1000)
    -- Initialize Box2D collision objects from the map
    map1:box2d_init(world)
    -- Hide the 'solid' layer in the map (optional)
    map1.layers.solid.visible = false

    -- Initialize the player and its physics body
    player.load(world)
end

function love.update(dt)
    -- Update the player each frame
    player:update(dt)
    -- Update the physics world
    world:update(dt)
end

function love.draw()
    -- Draw the map, scaled up by 4x
    map1:draw(0, 0, 4, 4)
    -- Save the current graphics state
    love.graphics.push()
    -- Scale everything drawn after this by 4x
    love.graphics.scale(4, 4)
    -- Draw the player
    player:draw()
    -- Restore the previous graphics state
    love.graphics.pop()
end